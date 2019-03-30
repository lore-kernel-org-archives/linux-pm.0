From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 39/52] PM / Domains: Avoid a potential deadlock
Date: Fri, 29 Mar 2019 20:52:46 -0400
Message-ID: <20190330005301.26868-39-sashal@kernel.org>
References: <20190330005301.26868-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190330005301.26868-1-sashal@kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Jiada Wang <jiada_wang@mentor.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Jiada Wang <jiada_wang@mentor.com>

[ Upstream commit 2071ac985d37efe496782c34318dbead93beb02f ]

Lockdep warns that prepare_lock and genpd->mlock can cause a deadlock
the deadlock scenario is like following:
First thread is probing cs2000
cs2000_probe()
  clk_register()
    __clk_core_init()
      clk_prepare_lock()                            ----> acquires prepare_lock
        cs2000_recalc_rate()
          i2c_smbus_read_byte_data()
            rcar_i2c_master_xfer()
              dma_request_chan()
                rcar_dmac_of_xlate()
                  rcar_dmac_alloc_chan_resources()
                    pm_runtime_get_sync()
                      __pm_runtime_resume()
                        rpm_resume()
                          rpm_callback()
                            genpd_runtime_resume()   ----> acquires genpd->mlock

Second thread is attaching any device to the same PM domain
genpd_add_device()
  genpd_lock()                                       ----> acquires genpd->mlock
    cpg_mssr_attach_dev()
      of_clk_get_from_provider()
        __of_clk_get_from_provider()
          __clk_create_clk()
            clk_prepare_lock()                       ----> acquires prepare_lock

Since currently no PM provider access genpd's critical section
in .attach_dev, and .detach_dev callbacks, so there is no need to protect
these two callbacks with genpd->mlock.
This patch avoids a potential deadlock by moving out .attach_dev and .detach_dev
from genpd->mlock, so that genpd->mlock won't be held when prepare_lock is acquired
in .attach_dev and .detach_dev

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/power/domain.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 4b5714199490..bf5be0bfaf77 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1388,12 +1388,12 @@ static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 	if (IS_ERR(gpd_data))
 		return PTR_ERR(gpd_data);
 
-	genpd_lock(genpd);
-
 	ret = genpd->attach_dev ? genpd->attach_dev(genpd, dev) : 0;
 	if (ret)
 		goto out;
 
+	genpd_lock(genpd);
+
 	dev_pm_domain_set(dev, &genpd->domain);
 
 	genpd->device_count++;
@@ -1401,9 +1401,8 @@ static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 
 	list_add_tail(&gpd_data->base.list_node, &genpd->dev_list);
 
- out:
 	genpd_unlock(genpd);
-
+ out:
 	if (ret)
 		genpd_free_dev_data(dev, gpd_data);
 	else
@@ -1452,15 +1451,15 @@ static int genpd_remove_device(struct generic_pm_domain *genpd,
 	genpd->device_count--;
 	genpd->max_off_time_changed = true;
 
-	if (genpd->detach_dev)
-		genpd->detach_dev(genpd, dev);
-
 	dev_pm_domain_set(dev, NULL);
 
 	list_del_init(&pdd->list_node);
 
 	genpd_unlock(genpd);
 
+	if (genpd->detach_dev)
+		genpd->detach_dev(genpd, dev);
+
 	genpd_free_dev_data(dev, gpd_data);
 
 	return 0;
-- 
2.19.1
