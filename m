From: Zhang Rui <rui.zhang@intel.com>
Subject: [GIT PULL] Thermal Management fixes for 4.1-rc5
Date: Thu, 21 May 2015 11:24:56 +0800
Message-ID: <1432178696.15830.9.camel@rzhang1-mobl4>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:15199 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753859AbbEUDY6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 20 May 2015 23:24:58 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>

Hi, Linus,

Please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git for-rc

to receive Thermal Management fixes for v4.1-rc5 with top-most
commit e93cd95029c3b8aa628f0204e80e66fc61b57f12:

  Merge branch 'fixes' of
git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal
into for-rc

on top of commit e26081808edadfd257c6c9d81014e3b25e9a6118:

  Linux 4.1-rc4

This pull request includes three fixes for Armada (380) and TI (dra7 and
OMAP5) thermal soc drivers.

thanks,
rui

----------------------------------------------------------------

Keerthy (2):
      thermal: ti-soc-thermal: dra7: Implement Workaround for Errata
i814
      thermal: ti-soc-thermal: OMAP5: Implement Workaround for Errata
i813

Nadav Haklai (1):
      thermal: armada: Update Armada 380 thermal sensor coefficients

Zhang Rui (1):
      Merge branch 'fixes' of
git://git.kernel.org/.../evalenti/linux-soc-thermal into for-rc

 drivers/thermal/armada_thermal.c                   |  6 +-
 .../thermal/ti-soc-thermal/dra752-thermal-data.c   |  3 +-
 .../thermal/ti-soc-thermal/omap5-thermal-data.c    |  3 +-
 drivers/thermal/ti-soc-thermal/ti-bandgap.c        | 78
+++++++++++++++++++++-
 drivers/thermal/ti-soc-thermal/ti-bandgap.h        |  6 ++
 5 files changed, 89 insertions(+), 7 deletions(-)


