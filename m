From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v8 01/26] PM / Domains: Don't treat zero found compatible idle
 states as an error
Date: Wed, 20 Jun 2018 19:22:01 +0200
Message-ID: <20180620172226.15012-2-ulf.hansson@linaro.org>
References: <20180620172226.15012-1-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180620172226.15012-1-ulf.hansson@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@kernel.org>, Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-kernel@vger.kernel.org, Lina Iyer <ilina@codeaurora.org>, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>, Lina Iyer <lina.iyer@linaro.org>
List-Id: linux-pm@vger.kernel.org

Instead of returning -EINVAL from of_genpd_parse_idle_states() in case none
compatible states was found, let's return 0 to indicate success. Assign
also the out-parameter *states to NULL and *n to 0, to indicate to the
caller that zero states have been found/allocated.

This enables the caller of of_genpd_parse_idle_states() to easier act on
the returned error code.

Cc: Lina Iyer <ilina@codeaurora.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Lina Iyer <ilina@codeaurora.org>
---
 drivers/base/power/domain.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 4925af5c4cf0..62969c3d5d04 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2452,8 +2452,8 @@ static int genpd_iterate_idle_states(struct device_node *dn,
  *
  * Returns the device states parsed from the OF node. The memory for the states
  * is allocated by this function and is the responsibility of the caller to
- * free the memory after use. If no domain idle states is found it returns
- * -EINVAL and in case of errors, a negative error code.
+ * free the memory after use. If any or zero compatible domain idle states is
+ * found it returns 0 and in case of errors, a negative error code is returned.
  */
 int of_genpd_parse_idle_states(struct device_node *dn,
 			struct genpd_power_state **states, int *n)
@@ -2462,8 +2462,14 @@ int of_genpd_parse_idle_states(struct device_node *dn,
 	int ret;
 
 	ret = genpd_iterate_idle_states(dn, NULL);
-	if (ret <= 0)
-		return ret < 0 ? ret : -EINVAL;
+	if (ret < 0)
+		return ret;
+
+	if (!ret) {
+		*states = NULL;
+		*n = 0;
+		return 0;
+	}
 
 	st = kcalloc(ret, sizeof(*st), GFP_KERNEL);
 	if (!st)
-- 
2.17.1
