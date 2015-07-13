From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH V3 02/19] memory: tegra: Add MC flush support
Date: Mon, 13 Jul 2015 13:39:40 +0100
Message-ID: <1436791197-32358-3-git-send-email-jonathanh@nvidia.com>
References: <1436791197-32358-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1436791197-32358-1-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Prashant Gaikwad <pgaikwad-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, =?UTF-8?q?Terje=20Bergstr=C3=B6m?= <tbergstrom-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Vince Hsu <vinceh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

The Tegra memory controller implements a flush feature to flush pending
accesses and prevent further accesses from occurring. This feature is
used when powering down IP blocks to ensure the IP block is in a good
state. The flushes are organised by software groups and IP blocks are
assigned in hardware to the different software groups. Add helper
functions for requesting a handle to an MC flush for a given
software group and enabling/disabling the MC flush itself.

This is based upon a change by Vince Hsu <vinceh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>.

Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/memory/tegra/mc.c | 110 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/memory/tegra/mc.h |   2 +
 include/soc/tegra/mc.h    |  34 ++++++++++++++
 3 files changed, 146 insertions(+)

diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index c71ede67e6c8..fb8da3d4caf4 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -71,6 +72,107 @@ static const struct of_device_id tegra_mc_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, tegra_mc_of_match);
 
+const struct tegra_mc_flush *tegra_mc_flush_get(struct tegra_mc *mc,
+						unsigned int swgroup)
+{
+	const struct tegra_mc_flush *flush = NULL;
+	int i;
+
+	mutex_lock(&mc->lock);
+
+	for (i = 0; i < mc->soc->num_flushes; i++) {
+		if (mc->soc->flushes[i].swgroup == swgroup) {
+			if (mc->flush_reserved[i] == false) {
+				mc->flush_reserved[i] = true;
+				flush = &mc->soc->flushes[i];
+			}
+			break;
+		}
+	}
+
+	mutex_unlock(&mc->lock);
+
+	return flush;
+}
+EXPORT_SYMBOL(tegra_mc_flush_get);
+
+static bool tegra_mc_flush_done(struct tegra_mc *mc,
+				const struct tegra_mc_flush *flush)
+{
+	unsigned long timeout = jiffies + msecs_to_jiffies(100);
+	int i;
+	u32 val;
+
+	while (time_before(jiffies, timeout)) {
+		val = mc_readl(mc, flush->status);
+
+		/*
+		 * If the flush bit is still set it
+		 * is not done and so wait then retry.
+		 */
+		if (val & BIT(flush->bit))
+			goto retry;
+
+		/*
+		 * Depending on the tegra SoC, it may be necessary to read
+		 * the status register multiple times to ensure the value
+		 * read is correct. Some tegra devices have a HW issue where
+		 * reading the status register shortly after writing the
+		 * control register (on the order of 5 cycles) may return
+		 * an incorrect value.
+		 */
+		for (i = 0; i < mc->soc->metastable_flush_reads; i++) {
+			if (mc_readl(mc, flush->status) != val)
+				goto retry;
+		}
+
+		/*
+		 * The flush is complete and so return.
+		 */
+		return 0;
+retry:
+		udelay(10);
+	}
+
+	return -ETIMEDOUT;
+}
+
+int tegra_mc_flush(struct tegra_mc *mc, const struct tegra_mc_flush *flush,
+		   bool enable)
+{
+	int ret = 0;
+	u32 val;
+
+	if (!mc || !flush)
+		return -EINVAL;
+
+	mutex_lock(&mc->lock);
+
+	val = mc_readl(mc, flush->ctrl);
+
+	if (enable)
+		val |= BIT(flush->bit);
+	else
+		val &= ~BIT(flush->bit);
+
+	mc_writel(mc, val, flush->ctrl);
+	mc_readl(mc, flush->ctrl);
+
+	/*
+	 * If activating the flush, poll the
+	 * status register until the flush is done.
+	 */
+	if (enable)
+		ret = tegra_mc_flush_done(mc, flush);
+
+	mutex_unlock(&mc->lock);
+
+	dev_dbg(mc->dev, "%s bit %d\n", __func__, flush->bit);
+
+	return ret;
+}
+EXPORT_SYMBOL(tegra_mc_flush);
+
 static int tegra_mc_setup_latency_allowance(struct tegra_mc *mc)
 {
 	unsigned long long tick;
@@ -359,6 +461,12 @@ static int tegra_mc_probe(struct platform_device *pdev)
 	mc->soc = match->data;
 	mc->dev = &pdev->dev;
 
+	mc->flush_reserved = devm_kcalloc(&pdev->dev, mc->soc->num_flushes,
+					  sizeof(mc->flush_reserved),
+					  GFP_KERNEL);
+	if (!mc->flush_reserved)
+		return -ENOMEM;
+
 	/* length of MC tick in nanoseconds */
 	mc->tick = 30;
 
@@ -410,6 +518,8 @@ static int tegra_mc_probe(struct platform_device *pdev)
 		return err;
 	}
 
+	mutex_init(&mc->lock);
+
 	value = MC_INT_DECERR_MTS | MC_INT_SECERR_SEC | MC_INT_DECERR_VPR |
 		MC_INT_INVALID_APB_ASID_UPDATE | MC_INT_INVALID_SMMU_PAGE |
 		MC_INT_SECURITY_VIOLATION | MC_INT_DECERR_EMEM;
diff --git a/drivers/memory/tegra/mc.h b/drivers/memory/tegra/mc.h
index b7361b0a6696..0f59d49b735b 100644
--- a/drivers/memory/tegra/mc.h
+++ b/drivers/memory/tegra/mc.h
@@ -14,6 +14,8 @@
 
 #include <soc/tegra/mc.h>
 
+#define MC_FLUSH_METASTABLE_READS	5
+
 static inline u32 mc_readl(struct tegra_mc *mc, unsigned long offset)
 {
 	return readl(mc->regs + offset);
diff --git a/include/soc/tegra/mc.h b/include/soc/tegra/mc.h
index 1ab2813273cd..b634c6df79eb 100644
--- a/include/soc/tegra/mc.h
+++ b/include/soc/tegra/mc.h
@@ -45,6 +45,13 @@ struct tegra_mc_client {
 	struct tegra_mc_la la;
 };
 
+struct tegra_mc_flush {
+	unsigned int swgroup;
+	unsigned int ctrl;
+	unsigned int status;
+	unsigned int bit;
+};
+
 struct tegra_smmu_swgroup {
 	const char *name;
 	unsigned int swgroup;
@@ -96,6 +103,10 @@ struct tegra_mc_soc {
 	const struct tegra_mc_client *clients;
 	unsigned int num_clients;
 
+	const struct tegra_mc_flush *flushes;
+	unsigned int num_flushes;
+	unsigned int metastable_flush_reads;
+
 	const unsigned long *emem_regs;
 	unsigned int num_emem_regs;
 
@@ -117,9 +128,32 @@ struct tegra_mc {
 
 	struct tegra_mc_timing *timings;
 	unsigned int num_timings;
+
+	bool *flush_reserved;
+
+	struct mutex lock;
 };
 
 void tegra_mc_write_emem_configuration(struct tegra_mc *mc, unsigned long rate);
 unsigned int tegra_mc_get_emem_device_count(struct tegra_mc *mc);
 
+#ifdef CONFIG_TEGRA_MC
+const struct tegra_mc_flush *tegra_mc_flush_get(struct tegra_mc *mc,
+						unsigned int swgroup);
+int tegra_mc_flush(struct tegra_mc *mc, const struct tegra_mc_flush *s,
+		   bool enable);
+#else
+const struct tegra_mc_flush *tegra_mc_flush_get(struct tegra_mc *mc,
+						unsigned int swgroup)
+{
+	return NULL;
+}
+
+int tegra_mc_flush(struct tegra_mc *mc, const struct tegra_mc_flush *s,
+		   bool enable)
+{
+	return -ENOTSUPP;
+}
+#endif
+
 #endif /* __SOC_TEGRA_MC_H__ */
-- 
2.1.4
