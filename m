From: Eduardo Valentin <edubezval@gmail.com>
Subject: [GIT PULL] thermal-soc: fixes
Date: Tue,  6 May 2014 15:26:52 -0400
Message-ID: <1399404412-29538-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ve0-f174.google.com ([209.85.128.174]:46134 "EHLO
	mail-ve0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751459AbaEFT1A (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 6 May 2014 15:27:00 -0400
Received: by mail-ve0-f174.google.com with SMTP id jw12so4326437veb.5
        for <linux-pm@vger.kernel.org>; Tue, 06 May 2014 12:26:59 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: edubezval@gmail.com, rui.zhang@intel.com
Cc: linux-pm@vger.kernel.org

Hello Rui, linux-pm

First of all, I'd like to apologize for my late radio silence. I have been
dealing with transitional phase here and just now I could get my hands back
to the linux soc tree.

I started by cleaning the fixes out of the linux-pm patchwork. This pull
request has the outstading fixes sent end of 2013. Mainly, I have here
several changes on exynos, adding support to new chips. I also have
one small fix on TI's soc.

I will be looking into new drivers also pretty soon.

For now, please consider this pull request, as it contains pretty old patches
waiting for long time already.

The following changes since commit 9477165ec525d47abb1cb6523698e0cd89d65ddb:

  thermal: rcar-thermal: update thermal zone only when temperature changes (2014-04-08 09:01:39 +0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal.git next

for you to fetch changes up to 923488a53e7890566f298c2f67416af84ba2a21c:

  thermal: samsung: Add TMU support for Exynos5260 SoCs (2014-05-06 14:55:42 -0400)

----------------------------------------------------------------
Bartlomiej Zolnierkiewicz (1):
      thermal: offer Samsung thermal support only when ARCH_EXYNOS is defined

Naveen Krishna Chatradhi (4):
      thermal: samsung: replace inten_ bit fields with intclr_
      thermal: samsung: change base_common to more meaningful base_second
      thermal: samsung: Add TMU support for Exynos5420 SoCs
      thermal: samsung: Add TMU support for Exynos5260 SoCs

Paul Walmsley (1):
      thermal: ti-soc-thermal: clk_round_rate() can return a zero upon error

 .../devicetree/bindings/thermal/exynos-thermal.txt |  50 ++++-
 drivers/thermal/Kconfig                            |   2 +-
 drivers/thermal/samsung/exynos_tmu.c               |  77 ++++++--
 drivers/thermal/samsung/exynos_tmu.h               |  23 ++-
 drivers/thermal/samsung/exynos_tmu_data.c          | 211 ++++++++++++++++++++-
 drivers/thermal/samsung/exynos_tmu_data.h          |  31 ++-
 drivers/thermal/ti-soc-thermal/ti-bandgap.c        |   2 +-
 7 files changed, 355 insertions(+), 41 deletions(-)
