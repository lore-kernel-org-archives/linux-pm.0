From: =?UTF-8?q?Rodolfo=20Garc=C3=ADa=20Pe=C3=B1as=20=28kix=29?=
	<kix@kix.es>
Subject: [PATCH 6/7] Support to disable KMS using config file
Date: Sat,  6 Jul 2013 15:49:15 +0200
Message-ID: <1373118556-27472-7-git-send-email-kix@kix.es>
References: <1373118556-27472-1-git-send-email-kix@kix.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kix.es ([46.105.17.89]:54724 "EHLO what.com.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751051Ab3GFN4h (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 6 Jul 2013 09:56:37 -0400
In-Reply-To: <1373118556-27472-1-git-send-email-kix@kix.es>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: rjw@sisk.pl, "=?UTF-8?q? Rodolfo=20Garc=C3=ADa=20Pe=C3=B1as=20(kix) ?=" <kix@kix.es>

=46rom: "Rodolfo Garc=C3=ADa Pe=C3=B1as (kix)" <kix@kix.es>

This patch adds support to disable the KMS via config file.

The user can add "s2ram_disable_kms =3D y" to the configuration file
to avoid the use of KMS.

We need move up the call to read the config file for s2ram (get_s2ram_c=
onfig())
because the test for the "no_kms_flag" [line 90: "if (!no_kms_flag) {"]=
=2E

In s2ram.c, the function to read the config file search for s2ram_disab=
le_kms"
and as sign the value to s2ram_disable_kms variable.

Signed-off-by: Rodolfo Garc=C3=ADa Pe=C3=B1as (kix) <kix@kix.es>
---
 s2ram-main.c |    6 +++---
 s2ram-x86.c  |   11 ++++++++++-
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/s2ram-main.c b/s2ram-main.c
index 40ba17b..c37d578 100644
--- a/s2ram-main.c
+++ b/s2ram-main.c
@@ -84,6 +84,9 @@ int main(int argc, char *argv[])
 		}
 	}
=20
+	/* Test if s2ram will use quirks from the configuration file */
+	ret =3D get_s2ram_config();
+
 	/* Check if the KMS support is disabled by user */
 	if (!no_kms_flag) {
 		/* KMS */
@@ -98,9 +101,6 @@ int main(int argc, char *argv[])
 		printf("KMS disabled by user.\n");
 	}
=20
-	/* Test if s2ram will use quirks from the configuration file */
-	ret =3D get_s2ram_config();
-
 	if (ret) {
 		/* No configuration file, using quirks form database */
 		ret =3D s2ram_is_supported();
diff --git a/s2ram-x86.c b/s2ram-x86.c
index ec581a2..78b9433 100644
--- a/s2ram-x86.c
+++ b/s2ram-x86.c
@@ -32,7 +32,7 @@ static unsigned char vga_pci_state[256];
 static struct pci_dev vga_dev;
 static struct pci_access *pacc;
 static int vbe_mode =3D -1, dmi_scanned;
-static char s2ram_force;
+static char s2ram_force, s2ram_disable_kms;
 static char s2ram_quirks[MAX_STR_LEN];
 int flags, force, fb_nosuspend;
=20
@@ -44,6 +44,11 @@ int flags, force, fb_nosuspend;
=20
 static struct config_par s2ram_parameters[] =3D {
 	{
+		.name =3D "s2ram_disable_kms",
+		.fmt =3D "%c",
+		.ptr =3D &s2ram_disable_kms,
+	},
+	{
 		.name =3D "s2ram_force",
 		.fmt =3D "%c",
 		.ptr =3D &s2ram_force,
@@ -431,6 +436,10 @@ int get_s2ram_config(void)
 			fprintf(stderr, "%s: Could not parse config file\n", ret_name);
 			return error;
 		}
+
+		if (s2ram_disable_kms =3D=3D 'y')
+			no_kms_flag =3D 1;
+
 		if (s2ram_force =3D=3D 'y') {
 			force =3D 1;
=20
--=20
1.7.10.4

