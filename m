From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 0/3] Add imx6q-cpufreq driver support
Date: Tue, 8 Jan 2013 14:54:00 +0800
Message-ID: <1357628043-19256-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from tx2ehsobe001.messaging.microsoft.com ([65.55.88.11]:45412 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750990Ab3AHGyi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 8 Jan 2013 01:54:38 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>

The generic cpufreq-cpu0 driver works well for imx6q before.  But it
does not work for 1 GHz and 1.2 GHz operating points the series adds
here.  We ended up with having to add an imx6q specific cpufreq driver
to handle those special frequency and voltage scaling requirements for
the new operating points.

I expect patches #1 and #2 go via cpufreq tree and the #3 through
arm-soc tree.

Shawn Guo (3):
  PM / OPP: Export more symbols for module usage
  cpufreq: add imx6q-cpufreq driver
  ARM: imx: enable imx6q-cpufreq support

 arch/arm/boot/dts/imx6q.dtsi    |   19 ++-
 arch/arm/mach-imx/mach-imx6q.c  |   64 ++++++++
 drivers/base/power/opp.c        |    2 +
 drivers/cpufreq/Kconfig.arm     |    9 ++
 drivers/cpufreq/Makefile        |    1 +
 drivers/cpufreq/imx6q-cpufreq.c |  325 +++++++++++++++++++++++++++++++++++++++
 6 files changed, 414 insertions(+), 6 deletions(-)
 create mode 100644 drivers/cpufreq/imx6q-cpufreq.c

-- 
1.7.9.5


