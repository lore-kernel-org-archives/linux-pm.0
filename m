From: =?UTF-8?q?Rodolfo=20Garc=C3=ADa=20Pe=C3=B1as=20=28kix=29?=
	<kix@kix.es>
Subject: [PATCH 0/3] suspend-utils UUID support and other small changes
Date: Wed,  6 Mar 2013 22:51:47 +0100
Message-ID: <1362606710-18089-1-git-send-email-kix@kix.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ks399202.kimsufi.com ([37.59.37.136]:36436 "EHLO
	ks399202.kimsufi.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751757Ab3CFVwN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 6 Mar 2013 16:52:13 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: "=?UTF-8?q? Rodolfo=20Garc=C3=ADa=20Pe=C3=B1as=20(kix) ?=" <kix@kix.es>

=46rom: "Rodolfo Garc=C3=ADa Pe=C3=B1as (kix)" <kix@kix.es>

Hi,

some patches for suspend-utils:

The most interesting patch is 0001-UUID-support.patch, that includes su=
pport for UUID device naming. With this patch is possible to configure =
the suspend device in /etc/suspend.conf as /dev device or UUID:

resume device =3D /dev/sda5
or
resume device =3D UUID=3D331291f8-9fe8-4c09-ad50-74cb99bea223

The other two patches are small changes.

0002-Typecasting-problem-in-vbetoo.c.patch: Is a typecasting to avoid c=
ompiler warnings.
0003-manpages-wrong-section-for-suspend.conf.patch: typos with the manp=
age sections.

Comments are welcome. Thanks for your work in the kernel side :-)

Saludos,
kix

Rodolfo Garc=C3=ADa Pe=C3=B1as (kix) (3):
  UUID support
  Typecasting problem in vbetoo.c
  manpages: wrong section for suspend.conf

 Makefile.am               |    2 ++
 configure.ac              |   11 +++++++++++
 manpages/s2disk.8         |    8 ++++----
 manpages/suspend-keygen.8 |    4 ++--
 manpages/swap-offset.8    |    2 +-
 suspend.c                 |   32 ++++++++++++++++++++++++++++++++
 vbetool/vbetool.c         |    8 ++++----
 7 files changed, 56 insertions(+), 11 deletions(-)

--=20
1.7.10.4

