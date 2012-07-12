From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 4/5] acpi : remove power from acpi_processor_cx
	structure
Date: Thu, 12 Jul 2012 17:30:02 +0200
Message-ID: <1342107003-9811-4-git-send-email-daniel.lezcano@linaro.org>
References: <1342107003-9811-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1342107003-9811-1-git-send-email-daniel.lezcano@linaro.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: rjw@sisk.pl
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Remove the power field as it is not used.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/acpi/processor_idle.c |    2 --
 include/acpi/processor.h      |    1 -
 2 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 4c06939..9845739 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -482,8 +482,6 @@ static int acpi_processor_get_power_info_cst(struct acpi_processor *pr)
 		if (obj->type != ACPI_TYPE_INTEGER)
 			continue;
 
-		cx.power = obj->integer.value;
-
 		current_count++;
 		memcpy(&(pr->power.states[current_count]), &cx, sizeof(cx));
 
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index 6ee4c06..3a675f4 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -58,7 +58,6 @@ struct acpi_processor_cx {
 	u32 address;
 	u8 entry_method;
 	u32 latency;
-	u32 power;
 	u64 time;
 	u8 bm_sts_skip;
 	char desc[ACPI_CX_DESC_LEN];
-- 
1.7.5.4
