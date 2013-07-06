From: =?UTF-8?q?Rodolfo=20Garc=C3=ADa=20Pe=C3=B1as=20=28kix=29?=
	<kix@kix.es>
Subject: [PATCH 0/7] suspend-utils PPC FTBFS patches
Date: Sat,  6 Jul 2013 15:49:09 +0200
Message-ID: <1373118556-27472-1-git-send-email-kix@kix.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kix.es ([46.105.17.89]:54725 "EHLO what.com.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751058Ab3GFN4h (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 6 Jul 2013 09:56:37 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: rjw@sisk.pl, "=?UTF-8?q? Rodolfo=20Garc=C3=ADa=20Pe=C3=B1as=20(kix) ?=" <kix@kix.es>

=46rom: "Rodolfo Garc=C3=ADa Pe=C3=B1as (kix)" <kix@kix.es>

Hi,

these patches replace the patches I sent some time ago, because the old
patches have problems to build from source in Power PC architecture.

The patch "s2ram: Support quirks from configuration file"
(uploaded as f63b384ad07396502d0cf54fa5f264a9dccc50ec) cannot build for=
 PPC.
The first new patch  (quirks support in config file PPC FTBFS) moves so=
me
functions between files, to allow the PPC building.

The other patches are mainly the same that I sent (they have the same t=
itle,
and the same code).

Rodolfo Garc=C3=ADa Pe=C3=B1as (kix) (7):
  quirks support in config file PPC FTBFS
  This patch includes support for UUID tags.
  Typecasting problem in vbetoo.c
  manpages: wrong section for suspend.conf
  The flag "no_kms" doesn't need arguments
  Support to disable KMS using config file
  README: Documentation for s2ram options

 Makefile.am               |    2 +
 README                    |   50 ++++++++++++++++++++++---
 configure.ac              |   11 ++++++
 manpages/s2disk.8         |    8 ++--
 manpages/suspend-keygen.8 |    4 +-
 manpages/swap-offset.8    |    2 +-
 s2ram-main.c              |    8 ++--
 s2ram-ppc.c               |    5 +++
 s2ram-x86.c               |   89 +++++++++++++++++++++++++++++++++++++=
++++++++
 s2ram-x86.h               |   13 +------
 s2ram.c                   |   77 -------------------------------------=
--
 s2ram.h                   |    2 +
 suspend.c                 |   32 ++++++++++++++++
 vbetool/vbetool.c         |    8 ++--
 whitelist.h               |    9 +++++
 15 files changed, 211 insertions(+), 109 deletions(-)

--=20
1.7.10.4

