From: =?UTF-8?q?Rodolfo=20Garc=C3=ADa=20Pe=C3=B1as=20=28kix=29?=
	<kix@kix.es>
Subject: [PATCH 1/3] UUID support
Date: Wed,  6 Mar 2013 22:51:48 +0100
Message-ID: <1362606710-18089-2-git-send-email-kix@kix.es>
References: <1362606710-18089-1-git-send-email-kix@kix.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ks399202.kimsufi.com ([37.59.37.136]:36437 "EHLO
	ks399202.kimsufi.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752951Ab3CFVwN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 6 Mar 2013 16:52:13 -0500
In-Reply-To: <1362606710-18089-1-git-send-email-kix@kix.es>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: "=?UTF-8?q? Rodolfo=20Garc=C3=ADa=20Pe=C3=B1as=20(kix) ?=" <kix@kix.es>

=46rom: "Rodolfo Garc=C3=ADa Pe=C3=B1as (kix)" <kix@kix.es>

This patch includes support for UUID tags.

The new code detect if the resume device starts with the string "UUID=3D=
"
and then convert the UUID to the /dev device.

Signed-off-by: Rodolfo Garc=C3=ADa Pe=C3=B1as (kix) <kix@kix.es>
---
 Makefile.am  |    2 ++
 configure.ac |   11 +++++++++++
 suspend.c    |   32 ++++++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+)

diff --git a/Makefile.am b/Makefile.am
index 76a041d..4da1b4e 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -69,11 +69,13 @@ AM_CFLAGS=3D\
 	-DS2RAM \
 	-D_LARGEFILE64_SOURCE \
 	$(LZO_CFLAGS) \
+	$(LIBBLKID_LIBS_CFLAGS) \
 	$(LIBGCRYPT_CFLAGS)
=20
 common_s2disk_libs=3D\
 	$(LZO_LIBS) \
 	$(LIBGCRYPT_LIBS) \
+	$(LIBBLKID_LIBS) \
 	$(PTHREAD_LIBS)
 common_s2ram_libs=3D
=20
diff --git a/configure.ac b/configure.ac
index 9172296..3924532 100644
--- a/configure.ac
+++ b/configure.ac
@@ -188,6 +188,17 @@ else
 	AC_MSG_ERROR([Unsupported architecture ${host}])
 fi
=20
+if test -z "${LIBBLKID_LIBS}"; then
+	AC_ARG_VAR([LIBBLKID_CFLAGS], [C compiler flags for libblkid])
+	AC_ARG_VAR([LIBBLKID_LIBS], [linker flags for libblkid])
+	AC_CHECK_LIB(
+		[blkid],
+		[blkid_new_probe],
+		[LIBBLKID_LIBS=3D"-lblkid"],
+		[AC_MSG_ERROR([Required libblkid was not found])]
+	)
+fi
+
 if test "${enable_compress}" =3D "yes"; then
 	CONFIG_FEATURES=3D"${CONFIG_FEATURES} compress"
 	AC_DEFINE([CONFIG_COMPRESS], [1], [Define if compression enabled])
diff --git a/suspend.c b/suspend.c
index 479ce58..56a99db 100644
--- a/suspend.c
+++ b/suspend.c
@@ -38,6 +38,7 @@
 #ifdef CONFIG_COMPRESS
 #include <lzo/lzo1x.h>
 #endif
+#include <blkid/blkid.h>
=20
 #include "swsusp.h"
 #include "memalloc.h"
@@ -229,6 +230,8 @@ static struct config_par parameters[] =3D {
 	}
 };
=20
+static char *fsprobe_get_devname_by_uuid(const char *uuid);
+
 static loff_t check_free_swap(int dev)
 {
 	int error;
@@ -2414,6 +2417,21 @@ int main(int argc, char *argv[])
 	}
=20
 	ret =3D 0;
+
+	/* If device is UUID, convert it to dev file */
+	if (!strncmp(resume_dev_name, "UUID=3D", 5)) {
+		char *tmpdev =3D NULL;
+
+		tmpdev =3D (char *) fsprobe_get_devname_by_uuid(resume_dev_name);
+		if (!tmpdev) {
+			ret =3D ENODEV;
+			goto Umount;
+		}
+
+		snprintf(resume_dev_name, MAX_STR_LEN -1, "%s", tmpdev);
+		free(tmpdev);
+	}
+
 	if (stat(resume_dev_name, &stat_buf)) {
 		suspend_error("Could not stat the resume device file.");
 		ret =3D ENODEV;
@@ -2561,3 +2579,17 @@ Umount:
=20
 	return ret;
 }
+
+static char *fsprobe_get_devname_by_uuid(const char *uuid)
+{
+	char *tmp_uuid =3D NULL, *ptr =3D NULL, *ret =3D NULL;
+
+	tmp_uuid =3D strdup(uuid);
+	ptr =3D strtok(tmp_uuid, "=3D");	/* string UUID */
+	ptr =3D strtok(NULL, "=3D");	/* UUID value */
+
+	if (ptr)
+		ret =3D blkid_evaluate_tag("UUID", ptr, NULL);
+
+	return ret;
+}
--=20
1.7.10.4

