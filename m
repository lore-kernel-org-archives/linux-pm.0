From: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [RFC 4/4] cpuidle: replace the 'disable' field by a flag
Date: Fri,  8 Jun 2012 18:02:45 +0200
Message-ID: <1339171365-4098-4-git-send-email-daniel.lezcano@linaro.org>
References: <1339171365-4098-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <1339171365-4098-1-git-send-email-daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

We have a flag field for each cpuidle state but we don't use it
for the 'disabled' states. Let's remove the integer field and use
the flag field.

Signed-off-by: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/cpuidle/cpuidle.c        |    1 -
 drivers/cpuidle/governors/menu.c |    5 +++--
 drivers/cpuidle/sysfs.c          |    4 ++--
 include/linux/cpuidle.h          |    4 +++-
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 68bf115..3068b65 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -267,7 +267,6 @@ static void poll_idle_init(struct cpuidle_driver *drv)
 	state->power_usage = -1;
 	state->flags = 0;
 	state->enter = poll_idle;
-	state->disable = 0;
 }
 #else
 static void poll_idle_init(struct cpuidle_driver *drv) {}
diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index 0633575..c1fe87b 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -281,7 +281,8 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 	 * unless the timer is happening really really soon.
 	 */
 	if (data->expected_us > 5 &&
-		drv->states[CPUIDLE_DRIVER_STATE_START].disable == 0)
+	    !(drv->states[CPUIDLE_DRIVER_STATE_START].flags &
+	      CPUIDLE_FLAG_DISABLED))
 		data->last_state_idx = CPUIDLE_DRIVER_STATE_START;
 
 	/*
@@ -291,7 +292,7 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 	for (i = CPUIDLE_DRIVER_STATE_START; i < drv->state_count; i++) {
 		struct cpuidle_state *s = &drv->states[i];
 
-		if (s->disable)
+		if (s->flags & CPUIDLE_FLAG_DISABLED)
 			continue;
 		if (s->target_residency > data->predicted_us)
 			continue;
diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
index 88032b4..a9a5f05 100644
--- a/drivers/cpuidle/sysfs.c
+++ b/drivers/cpuidle/sysfs.c
@@ -245,9 +245,9 @@ static ssize_t store_state_##_name(struct cpuidle_state *state, \
 	if (err) \
 		return err; \
 	if (value) \
-		state->disable = 1; \
+		state->flags |= CPUIDLE_FLAG_DISABLED; \
 	else \
-		state->disable = 0; \
+		state->flags &= ~CPUIDLE_FLAG_DISABLED; \
 	return size; \
 }
 
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index aafacd4..65f4c52 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -46,7 +46,6 @@ struct cpuidle_state {
 	unsigned int	exit_latency; /* in US */
 	int		power_usage; /* in mW */
 	unsigned int	target_residency; /* in US */
-	unsigned int    disable;
 
 	int (*enter)	(struct cpuidle_device *dev,
 			 struct cpuidle_driver *drv,
@@ -70,10 +69,13 @@ struct cpuidle_state {
  *                            flushes the TLB, so even if the HW doesn't do the *
  *                            flushing, this flag is safe to use.               *
  *                                                                              *
+ * CPUIDLE_FLAG_DISABLE     : the state is disabled if this flag is set         *
+ *                                                                              *
  *******************************************************************************/
 #define CPUIDLE_FLAG_TIME_VALID  0x01
 #define CPUIDLE_FLAG_DEAD_VALID  0x02
 #define CPUIDLE_FLAG_TLB_FLUSHED 0x04
+#define CPUIDLE_FLAG_DISABLED    0x08
 
 /**
  * cpuidle_get_statedata - retrieves private driver state data
-- 
1.7.5.4
