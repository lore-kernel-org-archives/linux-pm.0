From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v3 07/13] pinctrl: samsung: Add missing initconst annotation
Date: Thu, 19 Jan 2017 14:48:47 +0100
Message-ID: <1484833733-16082-8-git-send-email-m.szyprowski@samsung.com>
References: <1484833733-16082-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170119134907eucas1p14be6b994bddf37f8baca669a66acc1d4@eucas1p1.samsung.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-reply-to: <1484833733-16082-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-gpio-owner@vger.kernel.org
To: linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

Exynos5433 support has been added in parallel to adding initconst
annotation to most of the init data structures, so add those
annotations also to Exynos5433 structures.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Acked-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 drivers/pinctrl/samsung/pinctrl-exynos.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.c b/drivers/pinctrl/samsung/pinctrl-exynos.c
index bf753a596209..70b94ad10cc1 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos.c
@@ -1266,7 +1266,7 @@ static void exynos_pinctrl_resume(struct samsung_pinctrl_drv_data *drvdata)
 };
 
 /* pin banks of exynos5433 pin-controller - ALIVE */
-static const struct samsung_pin_bank_data exynos5433_pin_banks0[] = {
+static const struct samsung_pin_bank_data exynos5433_pin_banks0[] __initconst = {
 	EXYNOS5433_PIN_BANK_EINTW(8, 0x000, "gpa0", 0x00),
 	EXYNOS5433_PIN_BANK_EINTW(8, 0x020, "gpa1", 0x04),
 	EXYNOS5433_PIN_BANK_EINTW(8, 0x040, "gpa2", 0x08),
@@ -1279,28 +1279,28 @@ static void exynos_pinctrl_resume(struct samsung_pinctrl_drv_data *drvdata)
 };
 
 /* pin banks of exynos5433 pin-controller - AUD */
-static const struct samsung_pin_bank_data exynos5433_pin_banks1[] = {
+static const struct samsung_pin_bank_data exynos5433_pin_banks1[] __initconst = {
 	EXYNOS5433_PIN_BANK_EINTG(7, 0x000, "gpz0", 0x00),
 	EXYNOS5433_PIN_BANK_EINTG(4, 0x020, "gpz1", 0x04),
 };
 
 /* pin banks of exynos5433 pin-controller - CPIF */
-static const struct samsung_pin_bank_data exynos5433_pin_banks2[] = {
+static const struct samsung_pin_bank_data exynos5433_pin_banks2[] __initconst = {
 	EXYNOS5433_PIN_BANK_EINTG(2, 0x000, "gpv6", 0x00),
 };
 
 /* pin banks of exynos5433 pin-controller - eSE */
-static const struct samsung_pin_bank_data exynos5433_pin_banks3[] = {
+static const struct samsung_pin_bank_data exynos5433_pin_banks3[] __initconst = {
 	EXYNOS5433_PIN_BANK_EINTG(3, 0x000, "gpj2", 0x00),
 };
 
 /* pin banks of exynos5433 pin-controller - FINGER */
-static const struct samsung_pin_bank_data exynos5433_pin_banks4[] = {
+static const struct samsung_pin_bank_data exynos5433_pin_banks4[] __initconst = {
 	EXYNOS5433_PIN_BANK_EINTG(4, 0x000, "gpd5", 0x00),
 };
 
 /* pin banks of exynos5433 pin-controller - FSYS */
-static const struct samsung_pin_bank_data exynos5433_pin_banks5[] = {
+static const struct samsung_pin_bank_data exynos5433_pin_banks5[] __initconst = {
 	EXYNOS5433_PIN_BANK_EINTG(6, 0x000, "gph1", 0x00),
 	EXYNOS5433_PIN_BANK_EINTG(7, 0x020, "gpr4", 0x04),
 	EXYNOS5433_PIN_BANK_EINTG(5, 0x040, "gpr0", 0x08),
@@ -1310,17 +1310,17 @@ static void exynos_pinctrl_resume(struct samsung_pinctrl_drv_data *drvdata)
 };
 
 /* pin banks of exynos5433 pin-controller - IMEM */
-static const struct samsung_pin_bank_data exynos5433_pin_banks6[] = {
+static const struct samsung_pin_bank_data exynos5433_pin_banks6[] __initconst = {
 	EXYNOS5433_PIN_BANK_EINTG(8, 0x000, "gpf0", 0x00),
 };
 
 /* pin banks of exynos5433 pin-controller - NFC */
-static const struct samsung_pin_bank_data exynos5433_pin_banks7[] = {
+static const struct samsung_pin_bank_data exynos5433_pin_banks7[] __initconst = {
 	EXYNOS5433_PIN_BANK_EINTG(3, 0x000, "gpj0", 0x00),
 };
 
 /* pin banks of exynos5433 pin-controller - PERIC */
-static const struct samsung_pin_bank_data exynos5433_pin_banks8[] = {
+static const struct samsung_pin_bank_data exynos5433_pin_banks8[] __initconst = {
 	EXYNOS5433_PIN_BANK_EINTG(6, 0x000, "gpv7", 0x00),
 	EXYNOS5433_PIN_BANK_EINTG(5, 0x020, "gpb0", 0x04),
 	EXYNOS5433_PIN_BANK_EINTG(8, 0x040, "gpc0", 0x08),
@@ -1341,7 +1341,7 @@ static void exynos_pinctrl_resume(struct samsung_pinctrl_drv_data *drvdata)
 };
 
 /* pin banks of exynos5433 pin-controller - TOUCH */
-static const struct samsung_pin_bank_data exynos5433_pin_banks9[] = {
+static const struct samsung_pin_bank_data exynos5433_pin_banks9[] __initconst = {
 	EXYNOS5433_PIN_BANK_EINTG(3, 0x000, "gpj1", 0x00),
 };
 
@@ -1349,7 +1349,7 @@ static void exynos_pinctrl_resume(struct samsung_pinctrl_drv_data *drvdata)
  * Samsung pinctrl driver data for Exynos5433 SoC. Exynos5433 SoC includes
  * ten gpio/pin-mux/pinconfig controllers.
  */
-const struct samsung_pin_ctrl exynos5433_pin_ctrl[] = {
+const struct samsung_pin_ctrl exynos5433_pin_ctrl[] __initconst = {
 	{
 		/* pin-controller instance 0 data */
 		.pin_banks	= exynos5433_pin_banks0,
-- 
1.9.1

