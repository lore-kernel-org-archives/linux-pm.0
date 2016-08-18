From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [RFC/PATCH 1/2] cpuidle: Allow idle-states to be disabled at start
Date: Fri, 19 Aug 2016 03:56:54 +0530
Message-ID: <48afad7788300482c047fc35e70ca8e4bf31a5ac.1471557381.git.ego@linux.vnet.ibm.com>
References: <cover.1471557381.git.ego@linux.vnet.ibm.com>
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <cover.1471557381.git.ego@linux.vnet.ibm.com>
In-Reply-To: <cover.1471557381.git.ego@linux.vnet.ibm.com>
References: <cover.1471557381.git.ego@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Neuling <michael.neuling@au1.ibm.com>, Paul Mackerras <paulus@samba.org>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

Currently all the idle states registered by a cpu-idle driver are
enabled by default. This patch adds a mechanism which allows the
driver to hint if an idle-state should start in a disabled state. The
cpu-idle core will use this hint to appropriately initialize the
usage->disable knob of the CPU device idle state.

The state can be enabled at run time by echo'ing a zero to the sysfs
"disable" control file.

Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 drivers/cpuidle/cpuidle.c | 7 +++++++
 include/linux/cpuidle.h   | 7 ++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index c73207a..b4debc7 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -439,7 +439,14 @@ static void __cpuidle_unregister_device(struct cpuidle_device *dev)
 
 static void __cpuidle_device_init(struct cpuidle_device *dev)
 {
+	struct cpuidle_driver *drv = cpuidle_get_cpu_driver(dev);
+	int i;
+
 	memset(dev->states_usage, 0, sizeof(dev->states_usage));
+	for (i = 0; i < drv->state_count; i++) {
+		if (drv->states[i].disable_use_at_start)
+			dev->states_usage[i].disable = 1;
+	}
 	dev->last_residency = 0;
 }
 
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index bb31373..f3fe855 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -44,7 +44,12 @@ struct cpuidle_state {
 	int		power_usage; /* in mW */
 	unsigned int	target_residency; /* in US */
 	bool		disabled; /* disabled on all CPUs */
-
+	/*
+	 * disable_use_at_start: If true, then this idle state will be
+	 * disabled by default. It can be enabled at runtime using the
+	 * per-cpu cpuidle sysfs control file named "disable".
+	 */
+	bool            disable_use_at_start;
 	int (*enter)	(struct cpuidle_device *dev,
 			struct cpuidle_driver *drv,
 			int index);
-- 
1.9.4
