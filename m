From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH] ds2782_battery: constify ds278x_battery_ops structure
Date: Fri, 13 Nov 2015 19:41:34 +0100
Message-ID: <1447440094-10105-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: kernel-janitors@vger.kernel.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The ds278x_battery_ops structure is never modified, so declare it as const.

Done with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/power/ds2782_battery.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/ds2782_battery.c b/drivers/power/ds2782_battery.c
index ed4d756..a1b7e05 100644
--- a/drivers/power/ds2782_battery.c
+++ b/drivers/power/ds2782_battery.c
@@ -59,7 +59,7 @@ struct ds278x_info {
 	struct i2c_client	*client;
 	struct power_supply	*battery;
 	struct power_supply_desc	battery_desc;
-	struct ds278x_battery_ops  *ops;
+	const struct ds278x_battery_ops *ops;
 	struct delayed_work	bat_work;
 	int			id;
 	int                     rsns;
@@ -361,7 +361,7 @@ enum ds278x_num_id {
 	DS2786,
 };
 
-static struct ds278x_battery_ops ds278x_ops[] = {
+static const struct ds278x_battery_ops ds278x_ops[] = {
 	[DS2782] = {
 		.get_battery_current  = ds2782_get_current,
 		.get_battery_voltage  = ds2782_get_voltage,
