From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCHv2 00/10] thermal: add COMPILE_TEST (on drivers)
Date: Sun, 13 Sep 2015 19:31:29 -0700
Message-ID: <1442197899-5952-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:36638 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753899AbbINCbu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 13 Sep 2015 22:31:50 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>

Hi,

This is v2. Now I tested the series with bfin as target, to avoid
false positives. The difference from V1:
- Added acked-bys
- Removed patches that could cause compilation issues


BR,

Eduardo Valentin (10):
  thermal: hisi: allow compile test
  thermal: spear: allow compile test
  thermal: rockchip: allow compile test
  thermal: kirkwood: allow compile test
  thermal: dove: allow compile test
  thermal: armada: allow compile test
  thermal: exynos: allow compile test
  thermal: qcom_spmi: allow compile test
  thermal: ti-soc: allow compile test
  thermal: ti-soc: Kconfig fix to avoid menu showing wrongly

 drivers/thermal/Kconfig                | 17 +++++++++--------
 drivers/thermal/ti-soc-thermal/Kconfig |  8 +++-----
 2 files changed, 12 insertions(+), 13 deletions(-)

-- 
2.5.0

