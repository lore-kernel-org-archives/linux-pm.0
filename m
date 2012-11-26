From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: [PULL REQUEST for Rafael] PM / devfreq: rebased on pm-devfreq
Date: Mon, 26 Nov 2012 19:31:43 +0900
Message-ID: <1353925903-19557-1-git-send-email-myungjoo.ham@samsung.com>
References: <1562412.gSBZdyfWN8@vostro.rjw.lan>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:43378 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754635Ab2KZKcE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 26 Nov 2012 05:32:04 -0500
In-reply-to: <1562412.gSBZdyfWN8@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, myungjoo.ham@gmail.com


Rafael,

Here goes the pull request rebased on your pm-devfreq branch.
Sorry for all the confusion and mess invoked.


Cheers,
MyungJoo

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

The following changes since commit 1a1357ea176670867f347419c3345e2becc07338:

  PM / devfreq: make devfreq_class static (2012-11-15 00:35:06 +0100)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git tags/pull_req_20121126

Jonghwa Lee (1):
      PM / devfreq: Add sysfs node for representing frequency transition information.

MyungJoo Ham (2):
      PM / devfreq: remove compiler error when a governor is module
      PM / devfreq: missing rcu_read_lock() added for find_device_opp()

Nishanth Menon (9):
      PM / devfreq: documentation cleanups for devfreq header
      PM / devfreq: Add sysfs node to expose available frequencies
      PM / devfreq: export update_devfreq
      PM / devfreq: provide hooks for governors to be registered
      PM / devfreq: register governors with devfreq framework
      PM / devfreq: map devfreq drivers to governor using name
      PM / devfreq: governors: add GPL module license and allow module build
      PM / devfreq: allow sysfs governor node to switch governor
      PM / devfreq: Add sysfs node to expose available governors

Sachin Kamat (3):
      PM / devfreq: Use devm_* functions in exynos4_bus.c
      PM / devfreq: Fix incorrect argument in error message
      PM / devfreq: Fix return value in devfreq_remove_governor()

Sangho Yi (1):
      PM / devfreq: exynos4_bus.c: Fixed an alignment of the func call args.

 Documentation/ABI/testing/sysfs-class-devfreq |   29 ++-
 drivers/devfreq/Kconfig                       |    8 +-
 drivers/devfreq/devfreq.c                     |  413 ++++++++++++++++++++++++-
 drivers/devfreq/exynos4_bus.c                 |   45 +--
 drivers/devfreq/governor.h                    |    4 +
 drivers/devfreq/governor_performance.c        |   22 ++-
 drivers/devfreq/governor_powersave.c          |   22 ++-
 drivers/devfreq/governor_simpleondemand.c     |   22 ++-
 drivers/devfreq/governor_userspace.c          |   22 ++-
 include/linux/devfreq.h                       |   95 +++---
 10 files changed, 581 insertions(+), 101 deletions(-)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJQs0NoAAoJEBOhurvWBoCK2hIQAJuTMnRiWb2BkU30ENAug1FC
oNvoFBTVA2J9vTp1Q1qtoPj+ualfg++auzt4e5U2rbAthQYpB1LYDvc/ycEpGkG0
C+V3aleb9SK0TnqWp/s2i/KLWK1fTxbMGi2nDdCwwglbn59OlY6fVTyUA+jGzk3r
AwpxSCnLhi7jhtbgSWhiQh2F5gehNXGtU6CsK0OebP2VlVK5ZFw6X3eqacfact/h
kabXBsS+jJlrA90+jFFqQ4nSyU69Kgou/+de3rzrMOFYEv+uoGNmzRofh1BRaWM+
ueyKdfF/oUJWmL8fvhMY556xrTBuGpI5btSmfYxSz+VFiDzV8HduIi8ThaVKMmGu
MR77kgFSy0NkasCQ2l6q7LYIRoFJX/MQWnQpxvpZKOi5aqEgWsdCY75juRN3wOGm
kCGecK2Rq/tTj3EzIS2brUPQJPcM1YS4QHKFYq3Oucnpbk6Ym1ojIYxTB7no7fKW
7OhVOf3IHA3C0VMg8DiN9SoOW8ILU3EvknP6BguRRVf+iFjtUWqCoaNj14BOSjUx
Ol/606xgVa6xEsDG1NeoYiEov/lmYDpHG/tnh2g5gF/YrKjbQsvT7uqSBbeFJO2u
ybI2hz37OulNvur4ORFWTCOyNqknX9t+OIFFyQjdGmaPwjnJ+IZ5kWqBwPaHxd3x
Y/8iwxoohO4ROW1pBln0
=5A1F
-----END PGP SIGNATURE-----
