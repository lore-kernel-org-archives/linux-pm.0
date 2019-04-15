From: Matheus Castello <matheus@castello.eng.br>
Subject: [PATCH v2 4/4] power: supply: max17040: Send uevent in SOC changes
Date: Sun, 14 Apr 2019 22:26:35 -0300
Message-ID: <20190415012635.6369-5-matheus@castello.eng.br>
References: <CAJKOXPfvs=uETF0-xpwCWc5khSpWjpz2zz354Jcx1bVjm9cG2A@mail.gmail.com>
 <20190415012635.6369-1-matheus@castello.eng.br>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190415012635.6369-1-matheus@castello.eng.br>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org, krzk@kernel.org, robh+dt@kernel.org
Cc: mark.rutland@arm.com, cw00.choi@samsung.com, b.zolnierkie@samsung.com, lee.jones@linaro.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Matheus Castello <matheus@castello.eng.br>
List-Id: linux-pm@vger.kernel.org

Notify core through power_supply_changed() in case of changes in state
of charge. This is useful for user-space to efficiently update current
battery level.

Signed-off-by: Matheus Castello <matheus@castello.eng.br>
---
 drivers/power/supply/max17040_battery.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
index f036f272d52f..db901ebf495d 100644
--- a/drivers/power/supply/max17040_battery.c
+++ b/drivers/power/supply/max17040_battery.c
@@ -208,10 +208,17 @@ static void max17040_check_changes(struct i2c_client *client)
 static void max17040_work(struct work_struct *work)
 {
 	struct max17040_chip *chip;
+	int last_soc;
 
 	chip = container_of(work, struct max17040_chip, work.work);
+	/* store SOC for check change */
+	last_soc = chip->soc;
 	max17040_check_changes(chip->client);
 
+	/* check changes and send uevent */
+	if (last_soc != chip->soc)
+		power_supply_changed(chip->battery);
+
 	queue_delayed_work(system_power_efficient_wq, &chip->work,
 			   MAX17040_DELAY);
 }
-- 
2.17.0
