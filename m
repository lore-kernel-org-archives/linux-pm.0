From: =?UTF-8?q?Rodolfo=20Garc=C3=ADa=20Pe=C3=B1as=20=28kix=29?=
	<kix@kix.es>
Subject: [PATCH 3/3] manpages: wrong section for suspend.conf
Date: Wed,  6 Mar 2013 22:51:50 +0100
Message-ID: <1362606710-18089-4-git-send-email-kix@kix.es>
References: <1362606710-18089-1-git-send-email-kix@kix.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ks399202.kimsufi.com ([37.59.37.136]:36440 "EHLO
	ks399202.kimsufi.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753136Ab3CFVwN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 6 Mar 2013 16:52:13 -0500
In-Reply-To: <1362606710-18089-1-git-send-email-kix@kix.es>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: "=?UTF-8?q? Rodolfo=20Garc=C3=ADa=20Pe=C3=B1as=20(kix) ?=" <kix@kix.es>

=46rom: "Rodolfo Garc=C3=ADa Pe=C3=B1as (kix)" <kix@kix.es>

The section for suspend.conf is 5. This patch changes the section 8 to =
5.

Signed-off-by: Rodolfo Garc=C3=ADa Pe=C3=B1as (kix) <kix@kix.es>
---
 manpages/s2disk.8         |    8 ++++----
 manpages/suspend-keygen.8 |    4 ++--
 manpages/swap-offset.8    |    2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/manpages/s2disk.8 b/manpages/s2disk.8
index 3e25150..8d4b0b2 100644
--- a/manpages/s2disk.8
+++ b/manpages/s2disk.8
@@ -43,7 +43,7 @@ This manual page documents briefly the \fBs2disk\fR, =
\fBs2both\fR and \fBresume\
 .PP
 You will need to set up an initramfs which calls the \fBresume\fR prog=
ram for this to work\&. If you use a package distributed with your Linu=
x distribution, the kernel package which was made with the \-\-initrd o=
ption and you use mkinitramfs\-tools, this package should include the n=
ecessary parts on your initramfs\&.
 .PP
-The suspend-utils system supports encrypting the image written to disk=
 and features a splash system, see suspend\&.conf(8) for more informati=
on\&.
+The suspend-utils system supports encrypting the image written to disk=
 and features a splash system, see suspend\&.conf(5) for more informati=
on\&.
 .SH "OPTIONS"
 .PP
 \fB\-f, \-\-config [file]\fR
@@ -73,13 +73,13 @@ Desired size of the image\&.
 .PP
 \fB\-P, \-\-parameter [key=3Dvalue]\fR
 .RS 4
-Override any config file parameter (see suspend\&.conf(8))\&.
+Override any config file parameter (see suspend\&.conf(5))\&.
 .RE
 .PP
-For the meaning and use of the resume_size, resume_offset and image_si=
ze options see suspend\&.conf(8)\&.
+For the meaning and use of the resume_size, resume_offset and image_si=
ze options see suspend\&.conf(5)\&.
 .SH "SEE ALSO"
 .PP
-suspend\&.conf(8), suspend\-keygen(8), s2ram(8)
+suspend\&.conf(5), suspend\-keygen(8), s2ram(8)
 .PP
 For more information see the README file.
 .SH "AUTHOR"
diff --git a/manpages/suspend-keygen.8 b/manpages/suspend-keygen.8
index 7214fa6..835ff5b 100644
--- a/manpages/suspend-keygen.8
+++ b/manpages/suspend-keygen.8
@@ -37,10 +37,10 @@ This manual page documents briefly the \fBsuspend\-=
keygen\fR command\&.
 .PP
 \fBsuspend\-keygen\fR is a program that will generate a RSA key which =
can be used by the \fBs2disk\fR to encrypt the image written to disk\&.=
 The program does not take any options, but will ask to give the size o=
f the key in bits and to supply a passphrase\&. You will have to enter =
this passphrase on \fBresume\fR to decrypt the image\&.
 .PP
-To start using encryption, you will have to point the "RSA key file" o=
ption in suspend\&.conf(8) to the file suspend\-keygen generated\&.
+To start using encryption, you will have to point the "RSA key file" o=
ption in suspend\&.conf(5) to the file suspend\-keygen generated\&.
 .SH "SEE ALSO"
 .PP
-s2disk(8), suspend\&.conf(8)\&.
+s2disk(8), suspend\&.conf(5)\&.
 .PP
 For more information see the README file.
 .SH "AUTHOR"
diff --git a/manpages/swap-offset.8 b/manpages/swap-offset.8
index 775c1c8..015cdd2 100644
--- a/manpages/swap-offset.8
+++ b/manpages/swap-offset.8
@@ -40,7 +40,7 @@ The programs \fBs2disk\fR and \fBs2both\fR can be use=
d to save the state of the
 In the case of using a swap file you will have to specify the location=
 of the swap file\*(Aqs header as the offset from the beginning of the =
partition that contains the swap file\&. The \fBswap\-offset\fR utility=
 can be used to determine this value\&.
 .SH "SEE ALSO"
 .PP
-suspend\&.conf(8), s2disk(8)
+suspend\&.conf(5), s2disk(8)
 .PP
 For more information see the README file.
 .SH "AUTHOR"
--=20
1.7.10.4

