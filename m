From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4/9] PM / Domains: Drop unused parameter in
 genpd_allocate_dev_data()
Date: Fri, 18 May 2018 12:31:25 +0200
Message-ID: <1526639490-12167-5-git-send-email-ulf.hansson@linaro.org>
References: <1526639490-12167-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1526639490-12167-1-git-send-email-ulf.hansson@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>, Todor Tomov <todor.tomov@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, linux-tegra@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

The in-parameter struct generic_pm_domain *genpd to
genpd_allocate_dev_data() is unused, so let's drop it.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index f08fa15..050ce07 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1316,7 +1316,6 @@ EXPORT_SYMBOL_GPL(pm_genpd_syscore_poweron);
 #endif /* CONFIG_PM_SLEEP */
 
 static struct generic_pm_domain_data *genpd_alloc_dev_data(struct device *dev,
-					struct generic_pm_domain *genpd,
 					struct gpd_timing_data *td)
 {
 	struct generic_pm_domain_data *gpd_data;
@@ -1385,7 +1384,7 @@ static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 	if (IS_ERR_OR_NULL(genpd) || IS_ERR_OR_NULL(dev))
 		return -EINVAL;
 
-	gpd_data = genpd_alloc_dev_data(dev, genpd, td);
+	gpd_data = genpd_alloc_dev_data(dev, td);
 	if (IS_ERR(gpd_data))
 		return PTR_ERR(gpd_data);
 
-- 
2.7.4
