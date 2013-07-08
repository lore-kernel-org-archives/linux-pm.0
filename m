From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [GIT PULL 1/3] soc-thermal: Fixes for 3.11
Date: Mon, 8 Jul 2013 11:17:51 -0400
Message-ID: <1373296673-19295-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33782 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752459Ab3GHPSm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 8 Jul 2013 11:18:42 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com
Cc: linux-pm@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>

Rui,

Please pull the following outstanding fixes on thermal tree for 3.11.
These patches have been sent for a while and they need to be in in order
to avoid tree breakage.

The changelog is as it follows:

. There is a compilation build error (this is a fix on 3.10 actually).
. Fix on how ti-soc-thermal driver reads DT node for GPIO.
. Updated MAINTAINERS with linux-thermal-soc tree reference.

Cc: Arnd Bergmann <arnd@arndb.de>

The following changes since commit 9d1968fdabc69981ea98ea82082de1cc12a60385:

  Merge branch 'cpu-package-thermal' of .git into next (2013-06-18 07:26:49 +0800)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal.git next

for you to fetch changes up to e8d39240d635ed9bcaddbec898b1c9f063c5dbb2:

  thermal: cpu_cooling: fix stub function (2013-07-08 10:13:40 -0400)

----------------------------------------------------------------
Arnd Bergmann (1):
      thermal: cpu_cooling: fix stub function

Eduardo Valentin (2):
      thermal: MAINTAINERS: Add git tree path for SoC specific updates
      thermal: ti-soc-thermal: use standard GPIO DT bindings

 Documentation/devicetree/bindings/thermal/ti_soc_thermal.txt | 9 +++++----
 MAINTAINERS                                                  | 1 +
 drivers/thermal/ti-soc-thermal/ti-bandgap.c                  | 8 ++------
 include/linux/cpu_cooling.h                                  | 4 ++--
 4 files changed, 10 insertions(+), 12 deletions(-)
