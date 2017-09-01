From: Colin King <colin.king@canonical.com>
Subject: [PATCH][next] Thermal: int3406_thermal: fix unused variable warning
Date: Fri,  1 Sep 2017 10:58:09 +0100
Message-ID: <20170901095809.16787-1-colin.king@canonical.com>
Mime-Version: 1.0
Return-path: <kernel-janitors-owner@vger.kernel.org>
Sender: kernel-janitors-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable index was introduced by an earlier commit and is not
used, and hence should be removed.

Cleans up warning: "unused variable 'index'"

Fixes: c658894562ba ("Thermal: int3406_thermal: fix thermal sysfs I/F")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/thermal/int340x_thermal/int3406_thermal.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/thermal/int340x_thermal/int3406_thermal.c b/drivers/thermal/int340x_thermal/int3406_thermal.c
index e31509ead1c9..f69ab026ba24 100644
--- a/drivers/thermal/int340x_thermal/int3406_thermal.c
+++ b/drivers/thermal/int340x_thermal/int3406_thermal.c
@@ -113,7 +113,6 @@ static void int3406_thermal_get_limit(struct int3406_thermal_data *d)
 {
 	acpi_status status;
 	unsigned long long lower_limit, upper_limit;
-	int index;
 
 	status = acpi_evaluate_integer(d->handle, "DDDL", NULL, &lower_limit);
 	if (ACPI_SUCCESS(status))
-- 
2.14.1

