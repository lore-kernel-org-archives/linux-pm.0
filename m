From: Colin Cross <ccross@android.com>
Subject: [PATCH 2/2] cpuidle: coupled: fix decrementing ready
	count
Date: Fri, 18 May 2012 11:05:24 -0700
Message-ID: <1337364324-12171-3-git-send-email-ccross@android.com>
References: <1337364324-12171-1-git-send-email-ccross@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1337364324-12171-1-git-send-email-ccross@android.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <len.brown@intel.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-kernel@vger.kernel.org, Amit Kucheria <amit.kucheria@linaro.org>, Colin Cross <ccross@android.com>, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@linux.intel.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

cpuidle_coupled_set_not_ready sometimes refuses to decrement the
ready count in order to prevent a race condition.  This makes it
unsuitable for use when finished with idle.  Add a new function
cpuidle_coupled_set_done that decrements both the ready count and
waiting count, and call it after idle is complete.

Signed-off-by: Colin Cross <ccross@android.com>
---
 drivers/cpuidle/coupled.c |   18 ++++++++++++++++--
 1 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/coupled.c b/drivers/cpuidle/coupled.c
index b02810a..fc427fa 100644
--- a/drivers/cpuidle/coupled.c
+++ b/drivers/cpuidle/coupled.c
@@ -388,6 +388,21 @@ static void cpuidle_coupled_set_not_waiting(int cpu,
 }
 
 /**
+ * cpuidle_coupled_set_done - mark this cpu as leaving the ready loop
+ * @cpu: the current cpu
+ * @coupled: the struct coupled that contains the current cpu
+ *
+ * Marks this cpu as no longer in the ready and waiting loops.  Decrements
+ * the waiting count first to prevent another cpu looping back in and seeing
+ * this cpu as waiting just before it exits idle.
+ */
+static void cpuidle_coupled_set_done(int cpu, struct cpuidle_coupled *coupled)
+{
+	cpuidle_coupled_set_not_waiting(cpu, coupled);
+	atomic_sub(MAX_WAITING_CPUS, &coupled->ready_waiting_counts);
+}
+
+/**
  * cpuidle_coupled_clear_pokes - spin until the poke interrupt is processed
  * @cpu - this cpu
  *
@@ -501,8 +516,7 @@ int cpuidle_enter_state_coupled(struct cpuidle_device *dev,
 
 	entered_state = cpuidle_enter_state(dev, drv, next_state);
 
-	cpuidle_coupled_set_not_waiting(dev->cpu, coupled);
-	cpuidle_coupled_set_not_ready(coupled);
+	cpuidle_coupled_set_done(dev->cpu, coupled);
 
 out:
 	/*
-- 
1.7.7.3
