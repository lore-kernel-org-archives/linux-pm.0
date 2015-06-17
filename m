From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 7/7] ARM: shmobile: armadillo800eva dts: Add pinctrl and
 gpio-hog for lcdc0
Date: Wed, 17 Jun 2015 10:38:56 +0200
Message-ID: <1434530336-15073-8-git-send-email-geert+renesas@glider.be>
References: <1434530336-15073-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <1434530336-15073-1-git-send-email-geert+renesas@glider.be>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms+renesas@verge.net.au>, Magnus Damm <damm+renesas@opensource.se>
Cc: devel@driverdev.osuosl.org, devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-sh@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Configure pinctrl and a GPIO-controller board mux for LCD use.
This allows the armadillo800eva board staging code to enable lcdc0.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - New.
---
 arch/arm/boot/dts/r8a7740-armadillo800eva.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
index 2e31d8c01cbf6a74..105d9c95de4af611 100644
--- a/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
@@ -224,6 +224,9 @@
 };
 
 &pfc {
+	pinctrl-0 = <&lcd0_pins>;
+	pinctrl-names = "default";
+
 	ether_pins: ether {
 		renesas,groups = "gether_mii", "gether_int";
 		renesas,function = "gether";
@@ -259,6 +262,16 @@
 				 "fsia_data_in_1", "fsia_data_out_0";
 		renesas,function = "fsia";
 	};
+
+	lcd0_pins: lcd0 {
+		renesas,groups = "lcd0_data24_0", "lcd0_lclk_1", "lcd0_sync";
+		renesas,function = "lcd0";
+
+		/* DBGMD/LCDC0/FSIA MUX */
+		gpio-hog;
+		gpios = <176 0>;
+		output-high;
+	};
 };
 
 &tpu {
-- 
1.9.1
