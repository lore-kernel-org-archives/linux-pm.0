From: Colin Cross <ccross@android.com>
Subject: [PATCH 1/2] cpuidle: coupled: fix count of online cpus
Date: Fri, 18 May 2012 11:05:23 -0700
Message-ID: <1337364324-12171-2-git-send-email-ccross@android.com>
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

online_count was never incremented on boot, and was also counting
cpus that were not part of the coupled set.  Fix both issues by
introducting a new function that counts online coupled cpus, and
call it from register as well as the hotplug notifier.

Signed-off-by: Colin Cross <ccross@android.com>
---
 drivers/cpuidle/coupled.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/drivers/cpuidle/coupled.c b/drivers/cpuidle/coupled.c
index 3e65de1..b02810a 100644
--- a/drivers/cpuidle/coupled.c
+++ b/drivers/cpuidle/coupled.c
@@ -532,6 +532,13 @@ int cpuidle_enter_state_coupled(struct cpuidle_device *dev,
 	return entered_state;
 }
 
+static void cpuidle_coupled_update_online_cpus(struct cpuidle_coupled *coupled)
+{
+	cpumask_t cpus;
+	cpumask_and(&cpus, cpu_online_mask, &coupled->coupled_cpus);
+	coupled->online_count = cpumask_weight(&cpus);
+}
+
 /**
  * cpuidle_coupled_register_device - register a coupled cpuidle device
  * @dev: struct cpuidle_device for the current cpu
@@ -570,6 +577,8 @@ int cpuidle_coupled_register_device(struct cpuidle_device *dev)
 	if (WARN_ON(!cpumask_equal(&dev->coupled_cpus, &coupled->coupled_cpus)))
 		coupled->prevent++;
 
+	cpuidle_coupled_update_online_cpus(coupled);
+
 	coupled->refcnt++;
 
 	csd = &per_cpu(cpuidle_coupled_poke_cb, dev->cpu);
@@ -668,7 +677,7 @@ static int cpuidle_coupled_cpu_notify(struct notifier_block *nb,
 		break;
 	case CPU_ONLINE:
 	case CPU_DEAD:
-		dev->coupled->online_count = num_online_cpus();
+		cpuidle_coupled_update_online_cpus(dev->coupled);
 		/* Fall through */
 	case CPU_UP_CANCELED:
 	case CPU_DOWN_FAILED:
-- 
1.7.7.3
