# Author: Frank She
# Repository: https://github.com/Newton0314/Abingdon-Linux-Association/blob/master/Emacs_Resources/Org2Md.py

"""
Please using the following link to generate the table of contents
https://ecotrust-canada.github.io/markdown-toc/
Or using Typora alternatively

Primary thoughts: the major differences between .org & .md are in terms of 4 aspects:
- Header
- Source code block
- Preamble
- Table
TODO Integrating GUI (such as Tkinter) with the converter
"""

import re

header_list = ['#', '##', '###', '####', '#####']
in_latex_block = -1
in_maths_block = 0


def header(line):
    """
    Converting the Org header (*) to Md header (#)
    :param line:
    :return:
    """
    level_num = -1
    for each in line:
        if each == '*':
            level_num += 1
        else:
            break
    if level_num >= 0:
        line = header_list[level_num] + line.lstrip('*')
    return line


def src(line):
    """
    Converting Org source code blocks to Md format
    Languages configured: Python, latex
    Writing an adaptation for maths block in Typora
    Primary thoughts:
    If there are only 2 '$$' in a latex source code block, '#+begin_latex latex' and '#+end_latex' can be removed
    and '\begin{equation}' & '\end{equation}' can be replaced by 2 '$$'
    :param line:
    :return:
    """
    global in_latex_block
    global in_maths_block

    if re.match("#\+begin_src python|#\+BEGIN_SRC python", line):
        line = "```python\n"
    elif re.match("#\+begin_latex latex", line) or re.match("#\+end_latex", line):
        line = ''
    elif re.match("#\+end_src|#\+END_SRC", line):
        line = "```\n"
    return line


def latex_to_maths(line):
    line = line.replace("\\begin{equation}", "$$")
    line = line.replace("\\end{equation}", "$$")
    return line


def preamble(line):
    """
    Converting Org preambles (#+TITLE, #+AUTHOR .etc) to Md format (title ======, **Author** .etc)
    :return:
    """
    if re.match("#\+TITLE:", line):  # Pandocs's syntax doesn't work, thus html is used
        line = f'<center><font size="+10">{line.replace("#+TITLE:", "")}</font></center>\n'
        # Note: it is rather a centered and zoomed plain text rather than a title
    elif re.match("#\+AUTHOR:", line):
        line = line.replace("#+AUTHOR", "**Author**")
    return line


def table(line):
    """
    Converting Org table to Md format
    :param line:
    :return:
    """
    if line[:2] == '|-':
        line = line.replace('+', '|')  # format of the grid line
    return line


def parser(f_name_in, f_name_out):
    """
    1. Converting the Org header (*) to Markdown header (#)
    2. Converting the Org source code block (#+begin_src & #+end_src) to Md src (```)
    3. Converting the Org Preamble to Md format
    4. Converting the Org table to Md format
    :param f_name_in: str, the name of the Org file
    :param f_name_out: str, the name of the converted Markdown file
    :return:
    """
    global in_latex_block
    global in_maths_block
    line_num = 0
    f_in = open(f_name_in, 'r')
    f_out = open(f_name_out, 'w')

    print("Start parsing...")

    for each_line in f_in:
        each_line = table(src(header(latex_to_maths(each_line))))

        if line_num < 5:  # preamble is highly unlikely to be more than 5 lines
            """
            Note that the preamble is converted after the header since the header 
            converter function will interpret the Md preamble (e.g **Author**)
            as a Org level-2 header
            """
            each_line = preamble(each_line)
            line_num += 1
        f_out.write(each_line)

    print("Transfer completed")
    f_in.close()
    f_out.close()


if __name__ == "__main__":
    print("Please Enter the Input File Name (name.org): ")
    filename_in = str(input()) + ".org"
    filename_out = f"{filename_in.replace('.org', '')}_markdown copy.md"
    # The Md file will be saved in the same parent folder
    print("=============================")
    print(f"Input Filename: {filename_in}")
    print(f"Output Filename: {filename_out}")
    parser(filename_in, filename_out)
    print("=============================")

""""————————————————
Reference link: //blog.csdn.net/abcamus/java/article/details/53738481
"""
