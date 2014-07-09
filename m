From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCHv3 7/7] ARM: configs: add cpufreq-generic in multi_v7_defconfig
Date: Wed,  9 Jul 2014 17:45:15 +0200
Message-ID: <1404920715-19834-8-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1404920715-19834-1-git-send-email-thomas.petazzoni@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:49295 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756245AbaGIPpc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 9 Jul 2014 11:45:32 -0400
In-Reply-To: <1404920715-19834-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

The cpufreq-generic driver is going to be used by more and more
platforms to support dynamic frequency scaling of the CPU. This commit
enables this driver by default in multi_v7_defconfig.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index be1a345..80c1f60 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -82,6 +82,7 @@ CONFIG_KEXEC=y
 CONFIG_CPU_FREQ=y
 CONFIG_CPU_FREQ_STAT_DETAILS=y
 CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
+CONFIG_CPUFREQ_GENERIC=y
 CONFIG_CPU_IDLE=y
 CONFIG_NET=y
 CONFIG_PACKET=y
-- 
2.0.0

