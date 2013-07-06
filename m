From: =?UTF-8?q?Rodolfo=20Garc=C3=ADa=20Pe=C3=B1as=20=28kix=29?=
	<kix@kix.es>
Subject: [PATCH 5/7] The flag "no_kms" doesn't need arguments
Date: Sat,  6 Jul 2013 15:49:14 +0200
Message-ID: <1373118556-27472-6-git-send-email-kix@kix.es>
References: <1373118556-27472-1-git-send-email-kix@kix.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kix.es ([46.105.17.89]:54734 "EHLO what.com.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751058Ab3GFN4j (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 6 Jul 2013 09:56:39 -0400
In-Reply-To: <1373118556-27472-1-git-send-email-kix@kix.es>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: rjw@sisk.pl, "=?UTF-8?q? Rodolfo=20Garc=C3=ADa=20Pe=C3=B1as=20(kix) ?=" <kix@kix.es>

=46rom: "Rodolfo Garc=C3=ADa Pe=C3=B1as (kix)" <kix@kix.es>

The flag "no_kms" doesn't need arguments, but --no_kms ask for it.
With this patch, no_kms doesn't ask for it.

Signed-off-by: Rodolfo Garc=C3=ADa Pe=C3=B1as (kix) <kix@kix.es>
---
 s2ram-x86.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/s2ram-x86.h b/s2ram-x86.h
index 368851d..05a67d4 100644
--- a/s2ram-x86.h
+++ b/s2ram-x86.h
@@ -46,5 +46,5 @@ char bios_version[ITEMSZ], sys_vendor[ITEMSZ], sys_pr=
oduct[ITEMSZ], sys_version[
 	},\
 	{\
 		"no_kms\0\tdo not set KMS (Kernel Mode Set).",\
-		required_argument,	NULL, 9 \
+		no_argument,		NULL, 9 \
 	},
--=20
1.7.10.4

