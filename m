From: =?UTF-8?q?Rodolfo=20Garc=C3=ADa=20Pe=C3=B1as=20=28kix=29?=
	<kix@kix.es>
Subject: [PATCH 2/3] Support to disable KMS using config file
Date: Mon, 11 Mar 2013 11:46:20 +0100
Message-ID: <1362998781-4651-3-git-send-email-kix@kix.es>
References: <1362998781-4651-1-git-send-email-kix@kix.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ks399202.kimsufi.com ([37.59.37.136]:49899 "EHLO
	ks399202.kimsufi.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753748Ab3CKKqk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 11 Mar 2013 06:46:40 -0400
In-Reply-To: <1362998781-4651-1-git-send-email-kix@kix.es>
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
le_kms" and assign the value to s2ram_disable_kms variable.

Signed-off-by: Rodolfo Garc=C3=ADa Pe=C3=B1as (kix) <kix@kix.es>
---
 s2ram-main.c |    6 +++---
 s2ram.c      |   11 ++++++++++-
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/s2ram-main.c b/s2ram-main.c
index b430054..27d4823 100644
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
@@ -96,9 +99,6 @@ int main(int argc, char *argv[])
 		printf("KMS disabled by user.\n");
 	}
=20
-	/* Test if s2ram will use quirks from the configuration file */
-	ret =3D get_s2ram_config();
-
 	if (ret) {
 		/* No configuration file, using quirks form database */
 		ret =3D s2ram_is_supported();
diff --git a/s2ram.c b/s2ram.c
index aa2a605..e04cae6 100644
--- a/s2ram.c
+++ b/s2ram.c
@@ -23,11 +23,16 @@
 #include "s2ram.h"
 #include "config_parser.h"
=20
-static char s2ram_force;
+static char s2ram_force, s2ram_disable_kms;
 static char s2ram_quirks[MAX_STR_LEN];
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
@@ -110,6 +115,10 @@ int get_s2ram_config(void)
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

