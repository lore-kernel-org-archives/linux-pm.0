From: =?UTF-8?q?Rodolfo=20Garc=C3=ADa=20Pe=C3=B1as=20=28kix=29?=
	<kix@kix.es>
Subject: [PATCH 2/3] Typecasting problem in vbetoo.c
Date: Wed,  6 Mar 2013 22:51:49 +0100
Message-ID: <1362606710-18089-3-git-send-email-kix@kix.es>
References: <1362606710-18089-1-git-send-email-kix@kix.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ks399202.kimsufi.com ([37.59.37.136]:36439 "EHLO
	ks399202.kimsufi.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751588Ab3CFVwN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 6 Mar 2013 16:52:13 -0500
In-Reply-To: <1362606710-18089-1-git-send-email-kix@kix.es>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: "=?UTF-8?q? Rodolfo=20Garc=C3=ADa=20Pe=C3=B1as=20(kix) ?=" <kix@kix.es>

=46rom: "Rodolfo Garc=C3=ADa Pe=C3=B1as (kix)" <kix@kix.es>

This patch changes the typecasting for r.es and r.ebx, from "unsigned i=
nt"
to "unsigned long". The new code doesn't show compiler warnings.

Signed-off-by: Rodolfo Garc=C3=ADa Pe=C3=B1as (kix) <kix@kix.es>
---
 vbetool/vbetool.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/vbetool/vbetool.c b/vbetool/vbetool.c
index 55e019f..45fafdb 100644
--- a/vbetool/vbetool.c
+++ b/vbetool/vbetool.c
@@ -243,8 +243,8 @@ void restore_state_from(char *data)
 	r.eax =3D 0x4f04;
 	r.ecx =3D 0xf;		/* all states */
 	r.edx =3D 2;		/* restore state */
-	r.es =3D (unsigned int) (data - LRMI_base_addr()) >> 4;
-	r.ebx =3D (unsigned int) (data - LRMI_base_addr()) & 0xf;
+	r.es =3D (unsigned long) (data - LRMI_base_addr()) >> 4;
+	r.ebx =3D (unsigned long) (data - LRMI_base_addr()) & 0xf;
 	r.ds =3D 0x0040;
=20
 	if (!LRMI_int(0x10, &r)) {
@@ -327,8 +327,8 @@ char *__save_state(int *psize)
 	r.ecx =3D 0xf;		/* all states */
 	r.edx =3D 1;		/* save state */
 =09
-	r.es =3D (unsigned int) (buffer - LRMI_base_addr()) >> 4;
-	r.ebx =3D (unsigned int) (buffer - LRMI_base_addr()) & 0xf;
+	r.es =3D (unsigned long) (buffer - LRMI_base_addr()) >> 4;
+	r.ebx =3D (unsigned long) (buffer - LRMI_base_addr()) & 0xf;
 	r.ds =3D 0x0040;
=20
 	fprintf(stderr, "ES: 0x%04X EBX: 0x%04X\n", r.es, r.ebx);
--=20
1.7.10.4

