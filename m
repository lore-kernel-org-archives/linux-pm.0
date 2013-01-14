From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v3 0/2] Add imx6q-cpufreq driver support
Date: Mon, 14 Jan 2013 23:02:11 +0800
Message-ID: <1358175733-13475-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from co1ehsobe005.messaging.microsoft.com ([216.32.180.188]:16203
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752679Ab3ANPCB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 14 Jan 2013 10:02:01 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Shawn Guo <shawn.guo@linaro.org>

Changes since v2:
 - Fix typo in commit log
 - Put all OPPs in dts and disable 1.2 GHz one for Si revs that do not
   support it in kernel.

Shawn Guo (2):
  cpufreq: add imx6q-cpufreq driver
  ARM: imx: enable imx6q-cpufreq support

 arch/arm/boot/dts/imx6q.dtsi    |   20 ++-
 arch/arm/mach-imx/mach-imx6q.c  |   65 +++++++++
 drivers/cpufreq/Kconfig.arm     |    9 ++
 drivers/cpufreq/Makefile        |    1 +
 drivers/cpufreq/imx6q-cpufreq.c |  296 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 385 insertions(+), 6 deletions(-)
 create mode 100644 drivers/cpufreq/imx6q-cpufreq.c

-- 
1.7.9.5


