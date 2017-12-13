From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH v3 2/4] MAINTAINERS: add new entries for Armada 37xx cpufreq driver
Date: Wed, 13 Dec 2017 18:51:17 +0100
Message-ID: <20171213175119.9441-3-gregory.clement@free-electrons.com>
References: <20171213175119.9441-1-gregory.clement@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:43218 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753130AbdLMRvh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Dec 2017 12:51:37 -0500
In-Reply-To: <20171213175119.9441-1-gregory.clement@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Antoine Tenart <antoine.tenart@free-electrons.com>, =?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@free-electrons.com>, Nadav Haklai <nadavh@marvell.com>, Victor Gu <xigu@marvell.com>, Marcin Wojtas <mw@semihalf.com>, Wilson Ding <dingwei@marvell.com>, Hua Jing <jinghua@marvell.com>, Neta Zur Hershkovits <neta@marvell.com>, Evan Wang <xswang@marvell.com>, Andre Heider <a.heider@gmail.com>

This new driver belongs to the mvebu family, update the MAINTAINER file
to document it.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index aa71ab52fd76..98dcee849481 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1582,6 +1582,7 @@ F:	arch/arm/boot/dts/kirkwood*
 F:	arch/arm/configs/mvebu_*_defconfig
 F:	arch/arm/mach-mvebu/
 F:	arch/arm64/boot/dts/marvell/armada*
+F:	drivers/cpufreq/armada-37xx-cpufreq.c
 F:	drivers/cpufreq/mvebu-cpufreq.c
 F:	drivers/irqchip/irq-armada-370-xp.c
 F:	drivers/irqchip/irq-mvebu-*
-- 
2.15.1
