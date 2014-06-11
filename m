From: Jonghwa Lee <jonghwa3.lee@samsung.com>
Subject: [PATCH 0/3] devfreq: exynos4_bus: Update Exynos4 busfreq driver
Date: Wed, 11 Jun 2014 10:17:53 +0900
Message-ID: <1402449476-6782-1-git-send-email-jonghwa3.lee@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:61587 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752183AbaFKBSN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 10 Jun 2014 21:18:13 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N6Z00KGACY0O7B0@mailout4.samsung.com> for
 linux-pm@vger.kernel.org; Wed, 11 Jun 2014 10:18:00 +0900 (KST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, cw00.choi@samsung.com, Jonghwa Lee <jonghwa3.lee@samsung.com>

Driver updates including devicetree supporting and some fixes.

Jonghwa Lee (3):
  devfreq: exynos4_bus: Enable PPMU's source clock before use.
  devfreq: exynos4_bus: Access memory mapped I/O region via dynamic
    allocation.
  devfreq: exynos4_bus: Support DT in exynos4 busfreq driver.

 .../devicetree/bindings/devfreq/exynos4_bus.txt    |   19 +++++
 drivers/devfreq/exynos/exynos4_bus.c               |   77 +++++++++++++++++---
 2 files changed, 87 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/devfreq/exynos4_bus.txt

-- 
1.7.9.5

