# Module mod\_define

## Variable Definition For Arbitrary Directives

This module is contained in the `mod_define.c` file.
It provides the definition variables for arbitrary directives, i.e. variables which
can be expanded on any(!) directive line.
It is compatible with Apache httpd 2.0 and 2.2. It is not compiled into the server by default.
To use `mod_define` you have to enable the following line in the server build `Configuration` file:

```
        AddModule  modules/extra/mod_define.so
```
For Apache httpd 2.4 use [Define](https://httpd.apache.org/docs/2.4/mod/core.html#define) *parameter-name* [*parameter-value*]
### Define

 [**Syntax:**](directive-dict.html#Syntax) `Define` *variable* *value*
  [**Default:**](directive-dict.html#Default) *none*
  [**Context:**](directive-dict.html#Context) server config, virtual host, directory, .htaccess
  [**Override:**](directive-dict.html#Override) none
  [**Status:**](directive-dict.html#Status) Extension
  [**Module:**](directive-dict.html#Module) mod\_define.c
  [**Compatibility:**](directive-dict.html#Compatibility) Apache+EAPI

The `Define` directive defines a variable which later can be expanded
with the unsafe but short construct \`\``$`*variable*'' or the safe
but longer construct \`\``${`*variable*`}`'' on any configuration line.
Do not intermix this with the third-party module `mod_macro`.
The `mod_define` module doesn't provide a general macro mechanism,
although one can consider variable substitutions as a special form of macros.
Because the value of to which \`\``$`*variable*'' expands has
to fit into one line. When you need macros which can span more lines, you've to use `mod_macro`.
OTOH `mod_macro` cannot be used to expand a
variable/macro on an arbitrary directive line.
So, the typical use case of `mod_define` is to make strings *variable* (and this way easily changeable at one location)
and not to *bundle* things together (as it's the typical use case for macros).

The syntax of the expansion construct ( \`\``${`*variable*`}`'')
follows the Perl and Shell syntax, but can be changed via the `Define`
directive, too.
Four internal variables can be used for this. The default is:

```
    Define mod_define::escape "\\"
    Define mod_define::dollar "$"
    Define mod_define::open   "{"
    Define mod_define::close  "}"
```
When you need to escape some of the expansion constructs you place the
mod\_define::escape character in front of it.
The default is the backslash as in Perl or the Shell.

**Example:**

```
    Define master     "Joe Average <joe@average.dom>"
    Define docroot    /usr/local/apache/htdocs
    Define hostname   foo
    Define domainname bar.dom
    Define portnumber 80
      :
    <VirtualHost $hostname.$domainname:$portnumber>
    SetEnv       SERVER_MASTER "$master"
    ServerName   $hostname.$domainname
    ServerAlias  $hostname
    Port         $portnumber
    DocumentRoot $docroot
    <Directory $docroot>
      :
    <Directory>
```