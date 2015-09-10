From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 00/17] thermal: add COMPILE_TEST (on drivers)
Date: Wed,  9 Sep 2015 21:10:56 -0700
Message-ID: <1441858273-4017-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:33693 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750727AbbIJELi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 10 Sep 2015 00:11:38 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>

Hello all,

This is a simple series to add the COMPILE_TEST on thermal drivers.
The idea is to help compiling and maintaining.

Split into smaller patches so people can have their own voices on their drivers.

Let me know if this is a problem.

BR,

Eduardo Valentin (17):
  thermal: hisi: allow compile test
  thermal: spear: allow compile test
  thermal: rockchip: allow compile test
  thermal: kirkwood: allow compile test
  thermal: dove: allow compile test
  thermal: u8500: allow compile test
  thermal: armada: allow compile test
  thermal: tegra: allow compile test
  thermal: powerclamp: allow compile test
  thermal: intel_soc_dts_iosf: allow compile test
  thermal: intel_soc_dts: allow compile test
  thermal: intel_quark: allow compile test
  thermal: int340x: allow compile test
  thermal: exynos: allow compile test
  thermal: st: allow compile test
  thermal: qcom_spmi: allow compile test
  thermal: ti-soc: allow compile test

 drivers/thermal/Kconfig                | 34 +++++++++++++++++-----------------
 drivers/thermal/ti-soc-thermal/Kconfig |  8 ++++----
 2 files changed, 21 insertions(+), 21 deletions(-)

-- 
2.5.0

