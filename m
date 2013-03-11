From: =?UTF-8?q?Rodolfo=20Garc=C3=ADa=20Pe=C3=B1as=20=28kix=29?=
	<kix@kix.es>
Subject: [PATCH 1/3] The flag "no_kms" doesn't need arguments
Date: Mon, 11 Mar 2013 11:46:19 +0100
Message-ID: <1362998781-4651-2-git-send-email-kix@kix.es>
References: <1362998781-4651-1-git-send-email-kix@kix.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ks399202.kimsufi.com ([37.59.37.136]:49896 "EHLO
	ks399202.kimsufi.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753593Ab3CKKqi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 11 Mar 2013 06:46:38 -0400
In-Reply-To: <1362998781-4651-1-git-send-email-kix@kix.es>
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
index 7149100..b4c46c7 100644
--- a/s2ram-x86.h
+++ b/s2ram-x86.h
@@ -57,5 +57,5 @@ int flags, force, fb_nosuspend, no_kms_flag;
 	},\
 	{\
 		"no_kms\0\tdo not set KMS (Kernel Mode Set).",\
-		required_argument,	NULL, 9 \
+		no_argument,		NULL, 9 \
 	},
--=20
1.7.10.4

