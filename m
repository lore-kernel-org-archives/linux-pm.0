From: Chen Gang <gang.chen.5i5j@gmail.com>
Subject: [PATCH] kernel/power/hibernate.c: be sure of 'start' is not bigger
 than 'stop'
Date: Mon, 21 Apr 2014 21:40:27 +0800
Message-ID: <53551FCB.3030109@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:62629 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750775AbaDUNki (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 21 Apr 2014 09:40:38 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Guan Xuetao <gxt@mprc.pku.edu.cn>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, len.brown@intel.com, pavel@ucw.cz
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

=46or do_div(), it need 'u64' type, which means the outside must be sur=
e
of 'start' is not bigger than 'stop', or it will report warning.

The related warning (with allmodconfig for unicore32):

    CC      kernel/power/hibernate.o
  kernel/power/hibernate.c: In function =91swsusp_show_speed=92:
  kernel/power/hibernate.c:237: warning: comparison of distinct pointer=
 types lacks a cast

Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
---
 kernel/power/hibernate.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index f4f2073..0dec9b7 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -228,12 +228,17 @@ static void platform_recover(int platform_mode)
 void swsusp_show_speed(struct timeval *start, struct timeval *stop,
 			unsigned nr_pages, char *msg)
 {
-	s64 elapsed_centisecs64;
+	u64 elapsed_centisecs64;
 	int centisecs;
 	int k;
 	int kps;
=20
 	elapsed_centisecs64 =3D timeval_to_ns(stop) - timeval_to_ns(start);
+	if ((s64)elapsed_centisecs64 < 0) {
+		printk(KERN_ERR "PM: stop: %llu < start %llu\n",
+			timeval_to_ns(stop), timeval_to_ns(start));
+		return;
+	}
 	do_div(elapsed_centisecs64, NSEC_PER_SEC / 100);
 	centisecs =3D elapsed_centisecs64;
 	if (centisecs =3D=3D 0)
--=20
1.9.2.459.g68773ac
