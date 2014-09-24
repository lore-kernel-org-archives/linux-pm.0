From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH on mfd-regulator-power-v3.17] charger: max14577: Fix build
 breakage when compiled as module
Date: Wed, 24 Sep 2014 14:00:06 +0200
Message-ID: <1411560006-16471-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
List-Id: linux-pm@vger.kernel.org

The charger's module device table used the same name as regulator drive=
r
causing a build break when charger was compiled as a module:

drivers/power/max14577_charger.c:598:1: error: =E2=80=98__mod_platform_=
_max14577_regulator_id_device_table=E2=80=99 aliased to undefined symbo=
l =E2=80=98max14577_regulator_id=E2=80=99
make[2]: *** [drivers/power/max14577_charger.o] Error 1

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Reported-by: kbuild test robot <fengguang.wu@intel.com>
---
 drivers/power/max14577_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/max14577_charger.c b/drivers/power/max14577_=
charger.c
index c2e87c41d853..0a2bc7277026 100644
--- a/drivers/power/max14577_charger.c
+++ b/drivers/power/max14577_charger.c
@@ -595,7 +595,7 @@ static const struct platform_device_id max14577_cha=
rger_id[] =3D {
 	{ "max77836-charger", MAXIM_DEVICE_TYPE_MAX77836, },
 	{ }
 };
-MODULE_DEVICE_TABLE(platform, max14577_regulator_id);
+MODULE_DEVICE_TABLE(platform, max14577_charger_id);
=20
 static struct platform_driver max14577_charger_driver =3D {
 	.driver =3D {
--=20
1.9.1
