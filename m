From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 3/2] ARM: shmobile: r8a7790: add a "cpufreq-cpu0" platform
 device
Date: Tue, 21 May 2013 12:37:42 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1305211236180.2863@axis700.grange>
References: <Pine.LNX.4.64.1305211202380.2863@axis700.grange>
 <Pine.LNX.4.64.1305211206570.2863@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1305211206570.2863@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-pm@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Add a "cpufreq-cpu0" platform device, needed to activate the equally named
CPUFreq driver.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---

It can actually be merged with patch 1 from this series

 arch/arm/mach-shmobile/setup-r8a7790.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7790.c b/arch/arm/mach-shmobile/setup-r8a7790.c
index eeef5f6..49c3166 100644
--- a/arch/arm/mach-shmobile/setup-r8a7790.c
+++ b/arch/arm/mach-shmobile/setup-r8a7790.c
@@ -166,6 +166,7 @@ void __init r8a7790_timer_init(void)
 #ifdef CONFIG_USE_OF
 void __init r8a7790_add_standard_devices_dt(void)
 {
+	platform_device_register_simple("cpufreq-cpu0", -1, NULL, 0);
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
-- 
1.7.2.5

