From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Subject: [PATCH v10 9/9] regulator: bd70528: drop struct bd70528
Date: Thu, 14 Feb 2019 15:15:50 +0200
Message-ID: <540fde29249cb6417fb484d0f0f6ebf8a4ac4dd2.1550148989.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1550148989.git.matti.vaittinen@fi.rohmeurope.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1550148989.git.matti.vaittinen@fi.rohmeurope.com>
Sender: linux-kernel-owner@vger.kernel.org
To: matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc: Guenter Roeck <linux@roeck-us.net>, heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com, lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, broonie@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, linus.walleij@linaro.org, bgolaszewski@baylibre.com, sre@kernel.org, lgirdwood@gmail.com, a.zummo@towertech.it, alexandre.belloni@bootlin.com, wim@linux-watchdog.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

As a result of exporting the bd70528 specific locking functions
we no longer need struct bd70528. Remove references to
struct bd70528 from bd70528 regulator.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---

Mark, I proposed to hide the struct bd70528 from sub drivers
as the RTC lock no longer needs to be visible for sub drivers. So
please consider applying this to your tree in order to avoid breaking
it when (if) this series goes via MFD.

 drivers/regulator/bd70528-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/bd70528-regulator.c b/drivers/regulator/bd70528-regulator.c
index 72c7f9aa84f3..30e3ed430a8a 100644
--- a/drivers/regulator/bd70528-regulator.c
+++ b/drivers/regulator/bd70528-regulator.c
@@ -246,7 +246,7 @@ static const struct regulator_desc bd70528_desc[] = {
 
 static int bd70528_probe(struct platform_device *pdev)
 {
-	struct bd70528 *bd70528;
+	struct rohm_regmap_dev *bd70528;
 	int i;
 	struct regulator_config config = {
 		.dev = pdev->dev.parent,
@@ -258,7 +258,7 @@ static int bd70528_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	config.regmap = bd70528->chip.regmap;
+	config.regmap = bd70528->regmap;
 
 	for (i = 0; i < ARRAY_SIZE(bd70528_desc); i++) {
 		struct regulator_dev *rdev;
-- 
2.14.3


-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
