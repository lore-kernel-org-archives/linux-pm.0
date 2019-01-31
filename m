From: Joseph Lo <josephl@nvidia.com>
Subject: [PATCH] cpuidle: dt: bail out if the idle-state DT node is not
 compatible
Date: Thu, 31 Jan 2019 10:27:49 +0800
Message-ID: <20190131022749.19046-1-josephl@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-tegra@vger.kernel.org, Joseph Lo <josephl@nvidia.com>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Currently, the DT of the idle states will be parsed first whether it's
compatible or not. This could cause a warning message that comes from if
the CPU doesn't support identical idle states. E.g. Tegra186 can run
with 2 Cortex-A57 and 2 Denver cores with different idle states on
different types of these cores.

We fix it to check the compatible string before the parsing procedures.
So it can make sure it only goes through the idle states that the CPU
supported.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
 drivers/cpuidle/dt_idle_states.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/cpuidle/dt_idle_states.c b/drivers/cpuidle/dt_idle_states.c
index 53342b7f1010..4a528908abb3 100644
--- a/drivers/cpuidle/dt_idle_states.c
+++ b/drivers/cpuidle/dt_idle_states.c
@@ -180,6 +180,11 @@ int dt_init_idle_driver(struct cpuidle_driver *drv,
 		if (!state_node)
 			break;
 
+		if (!of_device_is_compatible(state_node, matches->compatible)) {
+			err = -EINVAL;
+			break;
+		}
+
 		if (!of_device_is_available(state_node)) {
 			of_node_put(state_node);
 			continue;
-- 
2.20.1
