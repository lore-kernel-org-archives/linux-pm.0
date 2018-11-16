From: Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v2 11/17] dt-bindings: olpc_battery: Add XO-1.5 battery
Date: Fri, 16 Nov 2018 17:23:57 +0100
Message-ID: <20181116162403.49854-12-lkundrak@v3.sk>
References: <20181116162403.49854-1-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20181116162403.49854-1-lkundrak@v3.sk>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Mark Brown <broonie@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, devel@driverdev.osuosl.org, Eric Miao <eric.y.miao@gmail.com>, James Cameron <quozl@laptop.org>, linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, linux-spi@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, platform-driver-x86@vger.kernel.org, Robert Jarzmik <robert.jarzmik@free.fr>, Daniel Mack <daniel@zonque.org>
List-Id: linux-pm@vger.kernel.org

The XO-1 and XO-1.5 batteries apparently differ in an ability to report
ambient temperature.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Pavel Machek <pavel@ucw.cz>

---
Changes since v1:
- Collected Reviewed-by and Acked-by tags

 Documentation/devicetree/bindings/power/supply/olpc_battery.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/power/supply/olpc_battery.txt b/Documentation/devicetree/bindings/power/supply/olpc_battery.txt
index c8901b3992d9..8d87d6b35a98 100644
--- a/Documentation/devicetree/bindings/power/supply/olpc_battery.txt
+++ b/Documentation/devicetree/bindings/power/supply/olpc_battery.txt
@@ -2,4 +2,4 @@ OLPC battery
 ~~~~~~~~~~~~
 
 Required properties:
-  - compatible : "olpc,xo1-battery"
+  - compatible : "olpc,xo1-battery" or "olpc,xo1.5-battery"
-- 
2.19.1
