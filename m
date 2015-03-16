From: Fabian Frederick <fabf@skynet.be>
Subject: [PATCH 03/35 linux-next] thermal: constify of_device_id array
Date: Mon, 16 Mar 2015 20:17:09 +0100
Message-ID: <1426533469-25458-4-git-send-email-fabf@skynet.be>
References: <1426533469-25458-1-git-send-email-fabf@skynet.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426533469-25458-1-git-send-email-fabf@skynet.be>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Fabian Frederick <fabf@skynet.be>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

of_device_id is always used as const.
(See driver.of_match_table and open firmware functions)

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 drivers/thermal/st/st_thermal_memmap.c | 2 +-
 drivers/thermal/st/st_thermal_syscfg.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/st/st_thermal_memmap.c b/drivers/thermal/st/st_thermal_memmap.c
index 067bfcd..bd22339 100644
--- a/drivers/thermal/st/st_thermal_memmap.c
+++ b/drivers/thermal/st/st_thermal_memmap.c
@@ -174,7 +174,7 @@ const struct st_thermal_compat_data st_407_cdata = {
 	.crit_temp		= 120,
 };
 
-static struct of_device_id st_mmap_thermal_of_match[] = {
+static const struct of_device_id st_mmap_thermal_of_match[] = {
 	{ .compatible = "st,stih416-mpe-thermal", .data = &st_416mpe_cdata },
 	{ .compatible = "st,stih407-thermal",     .data = &st_407_cdata },
 	{ /* sentinel */ }
diff --git a/drivers/thermal/st/st_thermal_syscfg.c b/drivers/thermal/st/st_thermal_syscfg.c
index 26d36a2..65eab72 100644
--- a/drivers/thermal/st/st_thermal_syscfg.c
+++ b/drivers/thermal/st/st_thermal_syscfg.c
@@ -143,7 +143,7 @@ const struct st_thermal_compat_data st_127_cdata = {
 	.crit_temp		= 120,
 };
 
-static struct of_device_id st_syscfg_thermal_of_match[] = {
+static const struct of_device_id st_syscfg_thermal_of_match[] = {
 	{ .compatible = "st,stih415-sas-thermal", .data = &st_415sas_cdata },
 	{ .compatible = "st,stih415-mpe-thermal", .data = &st_415mpe_cdata },
 	{ .compatible = "st,stih416-sas-thermal", .data = &st_416sas_cdata },
-- 
2.1.0
