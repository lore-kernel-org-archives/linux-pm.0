From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: cpufreq: i.MX6: -EPROBE_DEFER fixes
Date: Thu, 22 Oct 2015 10:47:28 +0200
Message-ID: <1445503652-777-1-git-send-email-s.hauer@pengutronix.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:44217 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756936AbbJVIrm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 22 Oct 2015 04:47:42 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, kernel@pengutronix.de, Heiner Kallweit <hkallweit1@gmail.com>

The i.MX6 cpufreq driver can't cope with -EPROBE_DEFER returned from
regulator_get/clk_get. This series fix that and some other small issues.

This series supersedes
[PATCH 1/2] cpufreq: imx: fix regulator_get error handling
[PATCH 2/2] cpufreq: imx: fix regulator_get_optional error handling
from Heiner Kallweit.

Sascha

----------------------------------------------------------------
Sascha Hauer (4):
      cpufreq: imx6q: Fix goto wrong error label
      cpufreq: imx6q: Fix wrong device in devm_kzalloc
      cpufreq: imx6q: Fix regulator/clock error handling
      cpufreq: imx6q: check regulator_get_optional return value

 drivers/cpufreq/imx6q-cpufreq.c | 182 +++++++++++++++++++++++++---------------
 1 file changed, 113 insertions(+), 69 deletions(-)
