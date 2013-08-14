From: Rodolfo =?utf-8?B?R2FyY8OtYSBQZcOxYXM=?= <kix@kix.es>
Subject: [PATCH] suspend-utils: checksum buffer length error
Date: Wed, 14 Aug 2013 19:42:58 +0200
Message-ID: <20130814174258.GA3178@kix.es>
Reply-To: kix@kix.es
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kix.es ([46.105.17.89]:40677 "EHLO what.com.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758324Ab3HNRxZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 14 Aug 2013 13:53:25 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: rjw@sisk.pl


=46rom bd16d8764e7606182f2871dd99b76b10df7ca9be Mon Sep 17 00:00:00 200=
1
=46rom: =3D?UTF-8?q?"Rodolfo=3D20Garc=3DC3=3DADa=3D20Pe=3DC3=3DB1as=3D2=
0(kix)"?=3D <kix@kix.es>
Date: Wed, 14 Aug 2013 19:25:45 +0200
Subject: [PATCH] suspend-utils: checksum buffer length error
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

The length for the checksum buffer csum_buf is 48. The function print_c=
hecksum
uses these 48 bytes to store the checksum. There are no space for '\0'.=
 So, the
'\0' is written on orig_checksum[0] and then the checksum doesn't match=
=2E

This patch was sent to "http://sourceforge.net/projects/suspend/" by ye=
cril71pl:

- - - 8< - - -
=46ile load.c Is: static char csum_buf[48]; Let: static char csum_buf[4=
9];
Because: 49 =3D (2 + 1) * 16 + 1 (for the terminating \0)
Otherwise: orig_checksum [0] =3D 0 and the checksums do not match.
- - - 8< - - -

Signed-off-by: Rodolfo Garc=C3=ADa Pe=C3=B1as (kix) <kix@kix.es>
---
 load.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/load.c b/load.c
index 6d1c6ed..0f7a26f 100644
--- a/load.c
+++ b/load.c
@@ -573,7 +573,7 @@ int read_or_verify(int dev, int fd, struct image_he=
ader_info *header,
 {
 	static struct swap_reader handle;
 	static unsigned char orig_checksum[16], checksum[16];
-	static char csum_buf[48];
+	static char csum_buf[49];
 	int error =3D 0, test_mode =3D (verify || test);
=20
 	error =3D read_page(fd, header, start);
--=20
1.7.10.4

