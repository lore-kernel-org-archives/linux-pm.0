From: =?UTF-8?q?Rodolfo=20Garc=C3=ADa=20Pe=C3=B1as=20=28kix=29?=
	<kix@kix.es>
Subject: [PATCH 3/3] README: Documentation for s2ram options
Date: Mon, 11 Mar 2013 11:46:21 +0100
Message-ID: <1362998781-4651-4-git-send-email-kix@kix.es>
References: <1362998781-4651-1-git-send-email-kix@kix.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ks399202.kimsufi.com ([37.59.37.136]:49901 "EHLO
	ks399202.kimsufi.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753748Ab3CKKqn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 11 Mar 2013 06:46:43 -0400
In-Reply-To: <1362998781-4651-1-git-send-email-kix@kix.es>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: rjw@sisk.pl, "=?UTF-8?q? Rodolfo=20Garc=C3=ADa=20Pe=C3=B1as=20(kix) ?=" <kix@kix.es>

=46rom: "Rodolfo Garc=C3=ADa Pe=C3=B1as (kix)" <kix@kix.es>

This patch includes the documentation to use the s2ram options, for
the configuration file and the command line.

Signed-off-by: Rodolfo Garc=C3=ADa Pe=C3=B1as (kix) <kix@kix.es>
---
 README |   50 ++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 44 insertions(+), 6 deletions(-)

diff --git a/README b/README
index 8ec0dd6..d5f493c 100644
--- a/README
+++ b/README
@@ -45,10 +45,48 @@ three different methods to suspend the machine:
 The flow of options is:
=20
 1. If the kernel supports KMS, then use it. This option can be overrid=
ing
-   using the argument "-k" in s2ram (s2ram -k).
+   using the argument "-k" in s2ram (s2ram -k). Is possible test if th=
e
+   kernel supports KMS using the argument "-K".
 2. If the kernel don't support KMS, or the user override it, then s2ra=
m
    checks if the configuration file has the parameters. If the paramet=
ers
-   are included, s2ram use them, else, the whitelist is used.
+   are included, s2ram use them, else, the whitelist is used. Is possi=
ble
+   test if the machine is in the whitelist using the argument "-n".
+
+The full table of options is:
+
+User want    =3D What the user needs for their machine (KMS, Whitelist=
 or their
+               own specific quirks).
+KMS support? =3D If the kernel has KMS support enabled.
+In WL?       =3D If the machine is included in the whitelist.
+Command Line =3D What should do the user in the command line (s2ram op=
tions).
+Config File  =3D What should include the user in the configuration fil=
e.
+N/A          =3D Yes and No, for both cases.
+Not possible =3D This option cannot be used!.
+Nothing      =3D The user must not include s2ram_force, s2ram_quirks a=
nd
+               s2ram_quirks lines in the configuration file.
+"<quirks>"   =3D Quirks options to be used. In command line these opti=
ons are
+               --vbe_save, --vbe_post,... and in the config file are
+               vbe_save, vb_post (same options, without the "--").
+
+User want | KMS support? | In WL? | Command Line   | Config File
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D+=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
+          | No           | N/A    | Not possible   | Not possible
+KMS (-K)  +--------------+--------+----------------+------------------=
------
+          | Yes          | N/A    | No arguments   | Nothing
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D+=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
+          | N/A          | No     | Not possible   | Not possible
+          +--------------+--------+----------------+------------------=
------
+WL  (-n)  | No           | Yes    | No arguments   | Nothing
+          +--------------+--------+----------------+------------------=
------
+          | Yes          | Yes    | -k             | s2ram_disable_kms=
 =3D y
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D+=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
+          | No           | N/A    | -f <quirks>    | s2ram_force =3D y
+          |              |        |                | s2ram_quirks =3D =
<quirks>
+User      +--------------+--------+----------------+------------------=
------
+Quirks    | Yes          | N/A    | -k -f <quirks> | s2ram_disable_kms=
 =3D y
+          |              |        |                | s2ram_force =3D y
+          |              |        |                | s2ram_quirks =3D =
<quirks>
+----------+--------------+--------+----------------+------------------=
------
=20
 You need libx86 installed to build s2ram, the HOWTO document explains =
how to
 install it.
@@ -61,16 +99,16 @@ can resume the system from disk using the resume to=
ol otherwise  However, this
 is only possible if your box is present in the s2ram whitelist.
=20
 To build the s2ram and s2both tools you will need the pciutils-devel
-(pciutils-dev) package and the libx86-dev package (which you can get f=
rom=20
-http://www.codon.org.uk/~mjg59/libx86/downloads/). They are necessary =
to=20
-compile the vbetool code (the vbetool code is based on vbetool-1.0 fro=
m=20
+(pciutils-dev) package and the libx86-dev package (which you can get f=
rom
+http://www.codon.org.uk/~mjg59/libx86/downloads/). They are necessary =
to
+compile the vbetool code (the vbetool code is based on vbetool-1.0 fro=
m
 http://www.codon.org.uk/~mjg59/vbetool/). With newer pciutils (2.2.4 a=
nd
 above) you also have to install the zlib development package (zlib-dev=
el on
 SUSE, zlib1g-dev on Debian).
=20
 For debugging, see http://suspend.sf.net/s2ram-support.html.
=20
-acpi-support package from Ubuntu has *very* long whitelist of machines=
:=20
+acpi-support package from Ubuntu has *very* long whitelist of machines=
:
 http://packages.ubuntu.org.cn/dapper/admin/acpi-support that are likel=
y to
 work with s2ram.
=20
--=20
1.7.10.4

