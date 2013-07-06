From: =?UTF-8?q?Rodolfo=20Garc=C3=ADa=20Pe=C3=B1as=20=28kix=29?=
	<kix@kix.es>
Subject: [PATCH 1/7] quirks support in config file PPC FTBFS
Date: Sat,  6 Jul 2013 15:49:10 +0200
Message-ID: <1373118556-27472-2-git-send-email-kix@kix.es>
References: <1373118556-27472-1-git-send-email-kix@kix.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kix.es ([46.105.17.89]:54726 "EHLO what.com.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751252Ab3GFN4i (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 6 Jul 2013 09:56:38 -0400
In-Reply-To: <1373118556-27472-1-git-send-email-kix@kix.es>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: rjw@sisk.pl, "=?UTF-8?q? Rodolfo=20Garc=C3=ADa=20Pe=C3=B1as=20(kix) ?=" <kix@kix.es>

=46rom: "Rodolfo Garc=C3=ADa Pe=C3=B1as (kix)" <kix@kix.es>

The commit "s2ram: Support quirks from configuration file"
(f63b384ad07396502d0cf54fa5f264a9dccc50ec) included support for quirks
using configuration file. That commit compiles without problems in i386=
 and
amd64 architectures, but not in powerpc.

The problem is that some functions and definitions are in wrong header =
and
code files. This patch moves code between files to allow compile in pow=
erpc
architecture.

The function "get_s2ram_config" is implemented in powerpc files only fo=
r
compatibility. It returns 0 to avoid the quirks code.

Signed-off-by: Rodolfo Garc=C3=ADa Pe=C3=B1as (kix) <kix@kix.es>
---
 s2ram-main.c |    2 ++
 s2ram-ppc.c  |    5 ++++
 s2ram-x86.c  |   80 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 s2ram-x86.h  |   11 --------
 s2ram.c      |   77 --------------------------------------------------=
-----
 s2ram.h      |    2 ++
 whitelist.h  |    9 +++++++
 7 files changed, 98 insertions(+), 88 deletions(-)

diff --git a/s2ram-main.c b/s2ram-main.c
index b430054..40ba17b 100644
--- a/s2ram-main.c
+++ b/s2ram-main.c
@@ -91,6 +91,8 @@ int main(int argc, char *argv[])
 		if (!ret) {
 			printf("KMS graphics driver is in use, skipping quirks.\n");
 			return s2ram_generic_do();
+		} else {
+			printf("This kernel doesn't have KMS support.\n");
 		}
 	} else {
 		printf("KMS disabled by user.\n");
diff --git a/s2ram-ppc.c b/s2ram-ppc.c
index c3040bd..dab6b06 100644
--- a/s2ram-ppc.c
+++ b/s2ram-ppc.c
@@ -51,6 +51,11 @@ int s2ram_hacks(void)
 	return 0;
 }
=20
+int get_s2ram_config(void)
+{
+	return 0;
+}
+
 int s2ram_is_supported(void)
 {
 	int fd, ret =3D 0;
diff --git a/s2ram-x86.c b/s2ram-x86.c
index a091af5..ec581a2 100644
--- a/s2ram-x86.c
+++ b/s2ram-x86.c
@@ -3,6 +3,7 @@
  *
  * Copyright 2006 Pavel Machek <pavel@suse.cz>
  *	     2007 Stefan, Rafael, Tim, Luca
+ * Copyright 2011 Rodolfo Garc=EDa Pe=F1as (kix) <kix@kix.es>
  * Distribute under GPLv2.
  */
=20
@@ -31,6 +32,9 @@ static unsigned char vga_pci_state[256];
 static struct pci_dev vga_dev;
 static struct pci_access *pacc;
 static int vbe_mode =3D -1, dmi_scanned;
+static char s2ram_force;
+static char s2ram_quirks[MAX_STR_LEN];
+int flags, force, fb_nosuspend;
=20
 /* return codes for s2ram_is_supported */
 #define S2RAM_OK	0
@@ -38,6 +42,26 @@ static int vbe_mode =3D -1, dmi_scanned;
 #define S2RAM_NOFB	126
 #define S2RAM_UNKNOWN	127
=20
+static struct config_par s2ram_parameters[] =3D {
+	{
+		.name =3D "s2ram_force",
+		.fmt =3D "%c",
+		.ptr =3D &s2ram_force,
+	},
+	{
+		.name =3D "s2ram_quirks",
+		.fmt =3D "%s",
+		.ptr =3D s2ram_quirks,
+		.len =3D MAX_STR_LEN
+	},
+	{
+		.name =3D NULL,
+		.fmt =3D NULL,
+		.ptr =3D NULL,
+		.len =3D 0,
+	}
+};
+
 void identify_machine(void)
 {
 	if (!dmi_scanned) {
@@ -389,3 +413,59 @@ void s2ram_add_flag(int opt, const char *opt_arg)
 			break;
 	}
 }
+
+/* Parse the configuration file */
+int get_s2ram_config(void)
+{
+	int error;
+	char *conf_name =3D CONFIG_FILE;
+	struct stat stat_buf;
+	char *ret_name =3D NULL;
+
+	if (stat(conf_name, &stat_buf)) {
+		fprintf(stderr, "%s: Could not stat configuration file\n", conf_name=
);
+		return -ENOENT;
+	} else {
+		error =3D parse(ret_name, conf_name, s2ram_parameters);
+		if (error) {
+			fprintf(stderr, "%s: Could not parse config file\n", ret_name);
+			return error;
+		}
+		if (s2ram_force =3D=3D 'y') {
+			force =3D 1;
+
+			if (strlen(s2ram_quirks) !=3D 0) {
+				printf("Using s2ram_quirks %s\n", s2ram_quirks);
+				s2ram_add_quirks(s2ram_quirks);
+			}
+			return 0;
+		}
+		return -1;
+	}
+}
+
+void s2ram_add_quirks(char *s2ram_quirks)
+{
+	int i;
+
+	/* Move to lowercase */
+	for (i=3D0; s2ram_quirks[i]; i++)
+		s2ram_quirks[i] =3D tolower(s2ram_quirks[i]);
+
+	if (strstr(s2ram_quirks, "vbe_post") !=3D NULL)
+		flags |=3D VBE_POST;
+	if (strstr(s2ram_quirks, "vbe_save") !=3D NULL)
+		flags |=3D VBE_POST;
+	if (strstr(s2ram_quirks, "vbe_mode") !=3D NULL)
+		flags |=3D VBE_MODE;
+	if (strstr(s2ram_quirks, "radeon_off") !=3D NULL)
+		flags |=3D RADEON_OFF;
+	if (strstr(s2ram_quirks, "pci_save") !=3D NULL)
+		flags |=3D PCI_SAVE;
+	if (strstr(s2ram_quirks, "s3_bios") !=3D NULL)
+		flags |=3D S3_BIOS;
+	if (strstr(s2ram_quirks, "s3_mode") !=3D NULL)
+		flags |=3D S3_MODE;
+	if (strstr(s2ram_quirks, "fb_nosuspend") !=3D NULL)
+		fb_nosuspend =3D 1;
+}
diff --git a/s2ram-x86.h b/s2ram-x86.h
index 7149100..368851d 100644
--- a/s2ram-x86.h
+++ b/s2ram-x86.h
@@ -5,23 +5,12 @@
  *
  * Distribute under GPLv2.
  */
-#define S3_BIOS     0x01        /* machine needs acpi_sleep=3Ds3_bios =
*/
-#define S3_MODE     0x02        /* machine needs acpi_sleep=3Ds3_mode =
*/
-#define VBE_SAVE    0x04        /* machine needs "vbetool save / resto=
re" */
-#define VBE_POST    0x08        /* machine needs "vbetool post" */
-#define RADEON_OFF  0x10        /* machine needs "radeontool light off=
" */
-#define UNSURE      0x20        /* unverified entries from acpi-suppor=
t 0.59 */
-#define NOFB        0x40        /* must not use a frame buffer */
-#define VBE_MODE    0x80        /* machine needs "vbetool vbemode get =
/ set" */
-#define PCI_SAVE   0x100        /* we need to save the VGA PCI registe=
rs */
=20
 /* Item size */
 #define ITEMSZ  1024
=20
 char bios_version[ITEMSZ], sys_vendor[ITEMSZ], sys_product[ITEMSZ], sy=
s_version[ITEMSZ];
=20
-int flags, force, fb_nosuspend, no_kms_flag;
-
 #define HACKS_LONG_OPTS \
 	{\
 		"nofbsuspend\0\tdo not suspend the framebuffer (debugging only!).",\
diff --git a/s2ram.c b/s2ram.c
index aa2a605..40d4e42 100644
--- a/s2ram.c
+++ b/s2ram.c
@@ -23,28 +23,6 @@
 #include "s2ram.h"
 #include "config_parser.h"
=20
-static char s2ram_force;
-static char s2ram_quirks[MAX_STR_LEN];
-
-static struct config_par s2ram_parameters[] =3D {
-	{
-		.name =3D "s2ram_force",
-		.fmt =3D "%c",
-		.ptr =3D &s2ram_force,
-	},
-	{
-		.name =3D "s2ram_quirks",
-		.fmt =3D "%s",
-		.ptr =3D s2ram_quirks,
-		.len =3D MAX_STR_LEN
-	},
-	{
-		.name =3D NULL,
-		.fmt =3D NULL,
-		.ptr =3D NULL,
-		.len =3D 0,
-	}
-};
=20
=20
 int s2ram_check_kms(void)
@@ -93,58 +71,3 @@ int s2ram_generic_do(void)
 	return ret;
 }
=20
-/* Parse the configuration file */
-int get_s2ram_config(void)
-{
-	int error;
-	char *conf_name =3D CONFIG_FILE;
-	struct stat stat_buf;
-	char *ret_name =3D NULL;
-
-	if (stat(conf_name, &stat_buf)) {
-		fprintf(stderr, "%s: Could not stat configuration file\n", conf_name=
);
-		return -ENOENT;
-	} else {
-		error =3D parse(ret_name, conf_name, s2ram_parameters);
-		if (error) {
-			fprintf(stderr, "%s: Could not parse config file\n", ret_name);
-			return error;
-		}
-		if (s2ram_force =3D=3D 'y') {
-			force =3D 1;
-
-			if (strlen(s2ram_quirks) !=3D 0) {
-				printf("Using s2ram_quirks %s\n", s2ram_quirks);
-				s2ram_add_quirks(s2ram_quirks);
-			}
-			return 0;
-		}
-		return -1;
-	}
-}
-
-void s2ram_add_quirks(char *s2ram_quirks)
-{
-	int i;
-
-	/* Move to lowercase */
-	for (i=3D0; s2ram_quirks[i]; i++)
-		s2ram_quirks[i] =3D tolower(s2ram_quirks[i]);
-
-	if (strstr(s2ram_quirks, "vbe_post") !=3D NULL)
-		flags |=3D VBE_POST;
-	if (strstr(s2ram_quirks, "vbe_save") !=3D NULL)
-		flags |=3D VBE_POST;
-	if (strstr(s2ram_quirks, "vbe_mode") !=3D NULL)
-		flags |=3D VBE_MODE;
-	if (strstr(s2ram_quirks, "radeon_off") !=3D NULL)
-		flags |=3D RADEON_OFF;
-	if (strstr(s2ram_quirks, "pci_save") !=3D NULL)
-		flags |=3D PCI_SAVE;
-	if (strstr(s2ram_quirks, "s3_bios") !=3D NULL)
-		flags |=3D S3_BIOS;
-	if (strstr(s2ram_quirks, "s3_mode") !=3D NULL)
-		flags |=3D S3_MODE;
-	if (strstr(s2ram_quirks, "fb_nosuspend") !=3D NULL)
-		fb_nosuspend =3D 1;
-}
diff --git a/s2ram.h b/s2ram.h
index 145b111..51cc264 100644
--- a/s2ram.h
+++ b/s2ram.h
@@ -23,6 +23,8 @@ void map_radeon_cntl_mem(void);
 #define S2RAM_NOFB      126
 #define S2RAM_UNKNOWN   127
=20
+int no_kms_flag;
+
 int s2ram_hacks(void);
 int s2ram_is_supported(void);
 void identify_machine(void);
diff --git a/whitelist.h b/whitelist.h
index 090920b..f147d4a 100644
--- a/whitelist.h
+++ b/whitelist.h
@@ -2,6 +2,15 @@
  * whitelist of machines that are known to work somehow
  * and all the workarounds
  */
+#define S3_BIOS     0x01        /* machine needs acpi_sleep=3Ds3_bios =
*/
+#define S3_MODE     0x02        /* machine needs acpi_sleep=3Ds3_mode =
*/
+#define VBE_SAVE    0x04        /* machine needs "vbetool save / resto=
re" */
+#define VBE_POST    0x08        /* machine needs "vbetool post" */
+#define RADEON_OFF  0x10        /* machine needs "radeontool light off=
" */
+#define UNSURE      0x20        /* unverified entries from acpi-suppor=
t 0.59 */
+#define NOFB        0x40        /* must not use a frame buffer */
+#define VBE_MODE    0x80        /* machine needs "vbetool vbemode get =
/ set" */
+#define PCI_SAVE   0x100        /* we need to save the VGA PCI registe=
rs */
=20
 struct machine_entry
 {
--=20
1.7.10.4

