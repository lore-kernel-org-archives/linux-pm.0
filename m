From: Zhang Rui <rui.zhang@intel.com>
Subject: [GIT PULL] Thermal Management fixes for 4.1-rc4
Date: Sat, 16 May 2015 08:29:31 +0800
Message-ID: <1431736171.5639.57.camel@rzhang1-mobl4>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:14923 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423064AbbEPA3k (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 15 May 2015 20:29:40 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>

Hi, Linus,

Please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git for-rc

to receive Thermal Management fixes for v4.1-rc4 with top-most
commit b100e77f179c15a072df571b2a253b3bc2308486:

  tools/thermal: tmon: fixed the 'make install' command

on top of commit b787f68c36d49bb1d9236f403813641efa74a031:

  Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)

Specifics:

- fix an issue in intel_powerclamp driver that idle injection target
  is not accurately maintained on newer Intel CPUs. Because Package
  C8 to C10 states are introduced on these CPUs but they are not
  included in the package c-state residency calculation.
  From Jacob Pan.

- fix a problem that package c-state idle injection was missing on
  Broadwell server, by adding its id to intel_powerclamp driver.
  From Jacob Pan.

- a couple of small fixes and cleanups from Joe Perches, Mathias Krause,
  Dan carpenter and Anand Moon.

thanks,
rui

----------------------------------------------------------------
Anand Moon (1):
      tools/thermal: tmon: fixed the 'make install' command

Dan Carpenter (1):
      thermal: rockchip: fix an error code

Jacob Pan (2):
      thermal/intel_powerclamp: add id for broadwell server
      thermal/powerclamp: fix missing newer package c-states

Joe Perches (1):
      thermal: Use bool function return values of true/false not 1/0

Mathias Krause (1):
      thermal/intel_powerclamp: add __init / __exit annotations

 drivers/thermal/intel_powerclamp.c | 89 ++++++++++++++++++++------------------
 drivers/thermal/rockchip_thermal.c |  2 +-
 drivers/thermal/thermal_core.h     |  2 +-
 tools/thermal/tmon/Makefile        |  8 ----
 4 files changed, 50 insertions(+), 51 deletions(-)


