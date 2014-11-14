From: Abhilash Kesavan <a.kesavan@samsung.com>
Subject: [PATCH 0/4] Add TMU support for Exynos7
Date: Fri, 14 Nov 2014 16:47:58 +0530
Message-ID: <1415963882-3460-1-git-send-email-a.kesavan@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:57574 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965121AbaKNLSq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 14 Nov 2014 06:18:46 -0500
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NF100EFC0R8VJA0@mailout1.samsung.com> for
 linux-pm@vger.kernel.org; Fri, 14 Nov 2014 20:18:44 +0900 (KST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com, linux-pm@vger.kernel.org
Cc: b.zolnierkie@samsung.com, amit.daniel@samsung.com, kesavan.abhilash@gmail.com

The Thermal Management Unit (TMU) in Exynos7 provides software-controlled
(thermal throttling) and hardware-controlled (thermal tripping) management
schemes.
There are several changes in terms of the register and bit offsets in the
Exynos7 TMU from that in older SoCs. There are also new bits, more trigger
levels and a special clock for TMU that has been introduced in Exynos7.
This patchset modifies the thermal driver to handle all these changes.

This series is based on linux-next(20141114) and tested on an Exynos7-based
espresso board.
Abhilash Kesavan (4):
  thermal: exynos: add optional sclk support
  thermal: exynos: add a triminfo_mask field in exynos_tmu_register
    structure
  thermal: exynos: modify the prototype for code_to_temp function
  thermal: exynos: Add TMU support for Exynos7 SoC

 .../devicetree/bindings/thermal/exynos-thermal.txt |    4 +
 drivers/thermal/samsung/exynos_tmu.c               |  106 ++++++++++++++----
 drivers/thermal/samsung/exynos_tmu.h               |   13 ++-
 drivers/thermal/samsung/exynos_tmu_data.c          |  117 ++++++++++++++++++++
 drivers/thermal/samsung/exynos_tmu_data.h          |   27 +++++
 5 files changed, 247 insertions(+), 20 deletions(-)

-- 
1.7.9.5

