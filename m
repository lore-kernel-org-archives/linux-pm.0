From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 4/6][resend] acpi : remove 'time' field in
	acpi_processor_cx
Date: Thu, 17 Nov 2011 11:26:38 +0100
Message-ID: <1321525600-2466-5-git-send-email-daniel.lezcano__14106.1397306204$1321526086$gmane$org@linaro.org>
References: <1321525600-2466-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1321525600-2466-1-git-send-email-daniel.lezcano@linaro.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, rob.lee@linaro.org
List-Id: linux-pm@vger.kernel.org

The 'time' field is used to sum the idle time but it is never
used.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/acpi/processor_idle.c |    2 --
 include/acpi/processor.h      |    1 -
 2 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index dd87355..142af72 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -861,7 +861,6 @@ static int acpi_idle_enter_simple(struct cpuidle_device *dev,
 	cx->usage++;
 
 	lapic_timer_state_broadcast(pr, cx, 0);
-	cx->time += idle_time;
 	return index;
 }
 
@@ -987,7 +986,6 @@ static int acpi_idle_enter_bm(struct cpuidle_device *dev,
 	cx->usage++;
 
 	lapic_timer_state_broadcast(pr, cx, 0);
-	cx->time += idle_time;
 	return index;
 }
 
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index 1b6e65c..46bcf79 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -61,7 +61,6 @@ struct acpi_processor_cx {
 	u32 latency;
 	u32 power;
 	u32 usage;
-	u64 time;
 	u8 bm_sts_skip;
 	char desc[ACPI_CX_DESC_LEN];
 };
-- 
1.7.4.1
