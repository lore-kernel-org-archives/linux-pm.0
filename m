From: Matheus Castello <matheus@castello.eng.br>
Subject: [PATCH 4/4] power: supply: max17040: Send uevent in SOC changes
Date: Mon, 23 Jul 2018 00:08:16 -0400
Message-ID: <20180723040816.19455-5-matheus@castello.eng.br>
References: <20180723040816.19455-1-matheus@castello.eng.br>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180723040816.19455-1-matheus@castello.eng.br>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org
Cc: robh+dt@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Matheus Castello <matheus@castello.eng.br>
List-Id: linux-pm@vger.kernel.org

Add check for changes in state of charge from delayed work, so
in case of changes we call power_supply_changed to send an uevent.

power_supply_changed send an uevent for alert user space about
changes, is useful for example to user space apps made changes in
UI battery level or made other decisions.

Signed-off-by: Matheus Castello <matheus@castello.eng.br>
---
 drivers/power/supply/max17040_battery.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
index 3efa52d32b44..72915ac9e13b 100644
--- a/drivers/power/supply/max17040_battery.c
+++ b/drivers/power/supply/max17040_battery.c
@@ -202,14 +202,22 @@ static void max17040_get_of_data(struct max17040_chip *chip)
 static void max17040_work(struct work_struct *work)
 {
 	struct max17040_chip *chip;
+	u16 last_soc;
 
 	chip = container_of(work, struct max17040_chip, work.work);
 
+	/* store SOC for check change */
+	last_soc = chip->soc;
+
 	max17040_get_vcell(chip->client);
 	max17040_get_soc(chip->client);
 	max17040_get_online(chip->client);
 	max17040_get_status(chip->client);
 
+	/* check changes and send uevent */
+	if (last_soc != chip->soc)
+		power_supply_changed(chip->battery);
+
 	queue_delayed_work(system_power_efficient_wq, &chip->work,
 			   MAX17040_DELAY);
 }
-- 
2.13.3
