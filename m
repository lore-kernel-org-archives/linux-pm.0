From: Len Brown <lenb@kernel.org>
Subject: [PATCH 75/76] Disable MCP limit exceeded messages from Intel IPS driver
Date: Fri, 30 Mar 2012 06:14:18 -0400
Message-ID: <2d7bbf008531cfdc353b09ed7cadd6dd3336a948.1333101989.git.len.brown@intel.com>
References: <1333102459-23750-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-reply-to: <1333102459-23750-1-git-send-email-lenb@kernel.org>
In-reply-to: <09f98a825a821f7a3f1b162f9ed023f37213a63b.1333101989.git.len.brown@intel.com>
References: <09f98a825a821f7a3f1b162f9ed023f37213a63b.1333101989.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

On a system on the thermal limit these are quite noisy and flood the logs.
Better would be a counter anyways. But given that we don't even have
anything for normal throttling this doesn't seem to be urgent either.

Reviewed-by: Jesse Barnes <jbarnes@virtuousgeek.org>
Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/intel_ips.c |   13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/platform/x86/intel_ips.c b/drivers/platform/x86/intel_ips.c
index 88a98cf..f7ba316 100644
--- a/drivers/platform/x86/intel_ips.c
+++ b/drivers/platform/x86/intel_ips.c
@@ -609,25 +609,16 @@ static bool mcp_exceeded(struct ips_driver *ips)
 	bool ret = false;
 	u32 temp_limit;
 	u32 avg_power;
-	const char *msg = "MCP limit exceeded: ";
 
 	spin_lock_irqsave(&ips->turbo_status_lock, flags);
 
 	temp_limit = ips->mcp_temp_limit * 100;
-	if (ips->mcp_avg_temp > temp_limit) {
-		dev_info(&ips->dev->dev,
-			"%sAvg temp %u, limit %u\n", msg, ips->mcp_avg_temp,
-			temp_limit);
+	if (ips->mcp_avg_temp > temp_limit)
 		ret = true;
-	}
 
 	avg_power = ips->cpu_avg_power + ips->mch_avg_power;
-	if (avg_power > ips->mcp_power_limit) {
-		dev_info(&ips->dev->dev,
-			"%sAvg power %u, limit %u\n", msg, avg_power,
-			ips->mcp_power_limit);
+	if (avg_power > ips->mcp_power_limit)
 		ret = true;
-	}
 
 	spin_unlock_irqrestore(&ips->turbo_status_lock, flags);
 
-- 
1.7.10.rc2.19.gfae9d

