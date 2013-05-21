From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [ILLUSTRATION v2 2/2] ARM: shmobile: lager: add CPUFreq support
Date: Tue, 21 May 2013 16:08:00 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1305211606170.2863@axis700.grange>
References: <Pine.LNX.4.64.1305211601180.2863@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1305211601180.2863@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-pm@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-arm-kernel@lists.infradead.org, Simon Horman <horms@verge.net.au>
List-Id: linux-pm@vger.kernel.org

Add DT properties, necessary to enable CPUFreq support on Lager.

Not-Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---

v2: no change

Again - not to be applied, an illustration only

 arch/arm/boot/dts/r8a7790-lager.dts |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 8d4c396..0e3198f 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -19,6 +19,14 @@
 		bootargs = "console=ttySC6,115200 ignore_loglevel";
 	};
 
+	cpus {
+		cpu@0 {
+			operating-points = <1300000 1000000
+					     100000  900000>;
+			clock-latency = <1000000>;
+		};
+	};
+
 	memory@40000000 {
 		device_type = "memory";
 		reg = <0 0x40000000 0 0x80000000>;
-- 
1.7.2.5

