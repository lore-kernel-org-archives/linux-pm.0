From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH] power_supply: 88pm860x_charger: Fix possible NULL pointer
 dereference and use of initialized variable
Date: Fri, 20 Mar 2015 10:26:02 +0100
Message-ID: <1426843562-6415-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:63445 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750913AbbCTJ0s (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 20 Mar 2015 05:26:48 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Do not put reference to power supply in early exit paths of
pm860x_done_handler() because:
1. it is not yet initialized,
2. it is NULL.

This fixes possible NULL pointer dereference and following build
warning:
drivers/power/88pm860x_charger.c: In function =E2=80=98pm860x_done_hand=
ler=E2=80=99:
drivers/power/88pm860x_charger.c:516:18: warning: =E2=80=98psy=E2=80=99=
 may be used uninitialized in this function [-Wmaybe-uninitialized]

Additionally this puts the power supply reference before unlocking
mutex. This actually is not needed (there is no race here) but has
logical sense and makes the exit paths cleaner.

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/power/88pm860x_charger.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/power/88pm860x_charger.c b/drivers/power/88pm860x_=
charger.c
index bf822aa00c14..0e448c68c02b 100644
--- a/drivers/power/88pm860x_charger.c
+++ b/drivers/power/88pm860x_charger.c
@@ -495,7 +495,7 @@ static irqreturn_t pm860x_done_handler(int irq, voi=
d *data)
 	ret =3D power_supply_get_property(psy, POWER_SUPPLY_PROP_VOLTAGE_NOW,
 			&val);
 	if (ret)
-		goto out;
+		goto out_psy_put;
 	vbatt =3D val.intval / 1000;
 	/*
 	 * CHG_DONE interrupt is faster than CHG_DET interrupt when
@@ -506,14 +506,15 @@ static irqreturn_t pm860x_done_handler(int irq, v=
oid *data)
 	 */
 	ret =3D pm860x_reg_read(info->i2c, PM8607_STATUS_2);
 	if (ret < 0)
-		goto out;
+		goto out_psy_put;
 	if (vbatt > CHARGE_THRESHOLD && ret & STATUS2_CHG)
 		power_supply_set_property(psy, POWER_SUPPLY_PROP_CHARGE_FULL,
 				&val);
=20
+out_psy_put:
+	power_supply_put(psy);
 out:
 	mutex_unlock(&info->lock);
-	power_supply_put(psy);
 	dev_dbg(info->dev, "%s, Allowed: %d\n", __func__, info->allowed);
 	set_charging_fsm(info);
=20
--=20
1.9.1

