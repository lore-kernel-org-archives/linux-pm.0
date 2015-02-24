From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v2 0/2] thermal: exynos: Fix NULL pointer error and bug of
 PD_DET_EN of Exynos7
Date: Tue, 24 Feb 2015 13:56:53 +0900
Message-ID: <1424753815-15113-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:61807 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751812AbbBXE5D (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 23 Feb 2015 23:57:03 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: kgene@kernel.org, b.zolnierkie@samsung.com, amit.daniel@samsung.com, l.majewski@samsung.com, a.kesavan@samsung.com, inki.dae@samsung.com, kyungmin.park@samsung.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>

This patch-set fix the bug of PD_DET_EN bit field of Exynos7 TMU.
And the clean-up the exynos compatible table by making oneline entry.

Changes from v1:
- Rebased it on Linux 4.0-rc1
- Add acked message by Lukasz Majewski
- Drop first patch [1] because NULL poiner error don't happen.
  [1] http://www.spinics.net/lists/linux-samsung-soc/msg42424.html

Chanwoo Choi (2):
  thermal: exynos: Fix wrong control of power down detection mode for Exynos7
  thermal: exynos: Clean-up code to use oneline entry for exynos compatible table

 drivers/thermal/samsung/exynos_tmu.c | 41 +++++++++++-------------------------
 1 file changed, 12 insertions(+), 29 deletions(-)

-- 
1.8.5.5

