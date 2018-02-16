From: Carlo Caione <carlo@caione.org>
Subject: [PATCH v2 3/3] power: supply: axp288_fuel_gauge: Do not register FG on ECS EF20EA
Date: Fri, 16 Feb 2018 08:26:16 +0000
Message-ID: <20180216082616.25084-4-carlo@caione.org>
References: <20180216082616.25084-1-carlo@caione.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180216082616.25084-1-carlo@caione.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux@endlessm.com, hdegoede@redhat.com, rjw@rjwysocki.net, lenb@kernel.org, sre@kernel.org, wens@csie.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Carlo Caione <carlo@endlessm.com>
List-Id: linux-pm@vger.kernel.org

From: Carlo Caione <carlo@endlessm.com>

The ECS EF20EA laptop ships an AXP288 but it is actually using a
different, separate FG chip for AC and battery monitoring. On this
laptop we need to keep using the regular ACPI driver and disable the
AXP288 FG to avoid reporting two batteries to userspace.

Signed-off-by: Carlo Caione <carlo@endlessm.com>
---
 drivers/power/supply/axp288_fuel_gauge.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/power/supply/axp288_fuel_gauge.c b/drivers/power/supply/axp288_fuel_gauge.c
index 4cc6e038dfdd..903891a9bcf0 100644
--- a/drivers/power/supply/axp288_fuel_gauge.c
+++ b/drivers/power/supply/axp288_fuel_gauge.c
@@ -708,6 +708,12 @@ static const struct dmi_system_id axp288_fuel_gauge_blacklist[] = {
 			DMI_MATCH(DMI_BOARD_VERSION, "V1.1"),
 		},
 	},
+	{
+		/* ECS EF20EA */
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "EF20EA"),
+		},
+	},
 	{}
 };
 
-- 
2.14.1
