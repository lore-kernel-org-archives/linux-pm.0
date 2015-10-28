From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v2] cpufreq: i.MX6: -EPROBE_DEFER fixes
Date: Wed, 28 Oct 2015 08:59:09 +0100
Message-ID: <1446019154-16384-1-git-send-email-s.hauer@pengutronix.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:33654 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752330AbbJ1H7X (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 28 Oct 2015 03:59:23 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, kernel@pengutronix.de, Heiner Kallweit <hkallweit1@gmail.com>

The i.MX6 cpufreq driver can't cope with -EPROBE_DEFER returned from
regulator_get/clk_get. This series fix that and some other small issues.

Shawn, Could you give me your ack for patch 4/5?

Sascha

Changes since v1:

- Fix Coding style nitpicks
- drop unnecessary platform_device argument from
  imx6q_cpufreq_get_resources
- Add more comments
- Use id_table to distinguish between SoCs
- make PU regulator non optional on SoCs that need it and don't request
  it on SoCs that don't need it

----------------------------------------------------------------
Sascha Hauer (5):
      cpufreq: imx6q: Fix goto wrong error label
      cpufreq: imx6q: Fix wrong device in devm_kzalloc
      cpufreq: imx6q: Fix regulator/clock error handling
      cpufreq: imx6q: Use id_table to distinguish between SoCs
      cpufreq: imx6q: pu regulator is not optional

 arch/arm/mach-imx/mach-imx6sl.c |   2 +-
 arch/arm/mach-imx/mach-imx6sx.c |   2 +-
 arch/arm/mach-imx/mach-imx6ul.c |   2 +-
 drivers/cpufreq/imx6q-cpufreq.c | 213 ++++++++++++++++++++++++++--------------
 4 files changed, 145 insertions(+), 74 deletions(-)
