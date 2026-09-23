Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCF3446BFC;
	Wed, 23 Sep 2026 07:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790148243; cv=none; b=VctqkSImm+aUnnKjNI1EpzQZBKpcYny3UfyvMbji+sjyobuhrY/Da6soLvhMhyMUuyyG3Lx00s218JV5RomcDg9VxX0zuIv3toyE3Cls3rjGZhKRTK0YZSL2wmBXZ0hz4TAm4bI4O8K/zH/GUh5bETlWAKiZoFnVICBuNMqezq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790148243; c=relaxed/simple;
	bh=Yyi0dnUJzZFsu3n5Q4Sx1ZVuAY4ijHrDfpKarQMVXtk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QVrmJAr3HDTMB5/rawK4VPcLYm8ZWI/G1yUG9Ry0HV6TbVScwwe96nSJBsBa1lZyVkQI4is7EAAawH0wKraMN2YE42p5W7wWMkw+GY87BdCLyfDTBVChZKLiBRy1yuqSJ2lcUqWheJzPddK+j1ncSg5MOob2H26F1dK3wsRSj0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=brFuQ060; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="brFuQ060"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A12F5C2BCB8;
	Wed, 23 Sep 2026 07:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790148242;
	bh=Yyi0dnUJzZFsu3n5Q4Sx1ZVuAY4ijHrDfpKarQMVXtk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=brFuQ060ViymlB+6l9K6xBNSfM1OfCCVpjVjB5ZZnHi2MvIvP/84/tDCfdOZNfW2a
	 dowung1cgjuCbU4gi9bsf7pOsFO3zk+sBq4CEUv80r2w8QMExAybLYCqxdn1b2uGCm
	 8f/z+PuDZ4EX1Ggw/x82t3glsottQCQPxP1ZPPucWYCDuiP31fcoWe4/waQYrIIbCO
	 N5pcKI0jsxXD+libuNZ2tzIbPaBg6IWBRtYkyF/hfxuSeXA5JPlyWcMIrdotBdXVNE
	 QL4u86MnJOkXNzRo2w+clT6Ov3gtFIknDLR/Tx1oSVof+H3GeDkWAXApch7fTDHmpm
	 ff/Y4VfWOSQ7Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CEDCC982EA;
	Wed, 23 Sep 2026 07:24:02 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Date: Wed, 23 Sep 2026 10:23:34 +0300
Subject: [PATCH 1/3] cpufreq: mediatek: add support for CPU speedbin
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-6572-cpufreq-v1-1-41f7af6d6d1a@protonmail.com>
References: <20260923-6572-cpufreq-v1-0-41f7af6d6d1a@protonmail.com>
In-Reply-To: <20260923-6572-cpufreq-v1-0-41f7af6d6d1a@protonmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Roman Vivchar <rva333@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790148240; l=3928;
 i=rva333@protonmail.com; s=20260510; h=from:subject:message-id;
 bh=8tS94U3qBY49lvfguXSecw1ZTRCCy8SxaUh/N0EXNSM=;
 b=GUglGD2ChmpxWy33le1togwI5locLZbOfUL2d63rF+2bFHVGo6eeNOMh4ujDuxgOTj5WYJ2Fr
 pXfvyLmrqiNClHhk/iqMkD4Y+xRZnUuUihx5rnaDPGh0rBlOQWgrot/
X-Developer-Key: i=rva333@protonmail.com; a=ed25519;
 pk=zww/nWjBGoQ4POXCG0BV6fx2iuXK6jx77rsKPA5YK5Y=
X-Endpoint-Received: by B4 Relay for rva333@protonmail.com/20260510 with
 auth_id=777
X-Original-From: Roman Vivchar <rva333@protonmail.com>
Reply-To: rva333@protonmail.com

From: Roman Vivchar <rva333@protonmail.com>

MediaTek SoCs are often released under the same marketing name, but with
different suffix for the speedbin. For example, mt6572m has 1 GHz limit,
mt6572a - 1.2 GHz, mt6572w - 1.4 GHz.

Add code to support per-cluster 'opp-supported-hw' property. The DT is
expected to pass a CPU speedbin using standard 'nvmem-cells' property
under the CPU node.

Signed-off-by: Roman Vivchar <rva333@protonmail.com>
---
 drivers/cpufreq/mediatek-cpufreq.c | 50 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 48 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
index 052ca7cd2f4f..f15135b2898b 100644
--- a/drivers/cpufreq/mediatek-cpufreq.c
+++ b/drivers/cpufreq/mediatek-cpufreq.c
@@ -10,6 +10,7 @@
 #include <linux/cpumask.h>
 #include <linux/minmax.h>
 #include <linux/module.h>
+#include <linux/nvmem-consumer.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
@@ -57,6 +58,7 @@ struct mtk_cpu_dvfs_info {
 	const struct mtk_cpufreq_platform_data *soc_data;
 	int vtrack_max;
 	bool ccifreq_bound;
+	int opp_token;
 };
 
 static struct platform_device *cpufreq_pdev;
@@ -381,6 +383,38 @@ static struct device *of_get_cci(struct device *cpu_dev)
 	return &pdev->dev;
 }
 
+static int mtk_cpu_parse_speedbin(struct mtk_cpu_dvfs_info *info, int cpu)
+{
+	struct device *cpu_dev = get_cpu_device(cpu);
+	struct dev_pm_opp_config config = {};
+	u32 val, opp_hw_ver;
+	int ret;
+
+	ret = nvmem_cell_read_variable_le_u32(cpu_dev, "speed_grade", &val);
+	if (ret) {
+		if (ret == -ENOENT)
+			/* speedbin is optional */
+			return 0;
+		return dev_err_probe(cpu_dev, ret, "cpu%d: failed to read speedbin\n", cpu);
+	}
+
+	/* Convert the raw value to a bitmask */
+	if (val >= 32)
+		return dev_err_probe(cpu_dev, -EINVAL,
+				     "cpu%d: invalid speedbin value %u\n", cpu, val);
+	opp_hw_ver = BIT(val);
+
+	config.supported_hw = &opp_hw_ver;
+	config.supported_hw_count = 1;
+
+	info->opp_token = dev_pm_opp_set_config(cpu_dev, &config);
+	if (info->opp_token < 0)
+		return dev_err_probe(cpu_dev, info->opp_token,
+				     "cpu%d: failed to set OPP config\n", cpu);
+
+	return 0;
+}
+
 static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
 {
 	struct device *cpu_dev;
@@ -450,18 +484,22 @@ static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
 		}
 	}
 
+	ret = mtk_cpu_parse_speedbin(info, cpu);
+	if (ret)
+		goto out_disable_sram_reg;
+
 	/* Get OPP-sharing information from "operating-points-v2" bindings */
 	ret = dev_pm_opp_of_get_sharing_cpus(cpu_dev, &info->cpus);
 	if (ret) {
 		dev_err_probe(cpu_dev, ret,
 			"cpu%d: failed to get OPP-sharing information\n", cpu);
-		goto out_disable_sram_reg;
+		goto out_free_speedbin;
 	}
 
 	ret = dev_pm_opp_of_cpumask_add_table(&info->cpus);
 	if (ret) {
 		dev_err_probe(cpu_dev, ret, "cpu%d: no OPP table\n", cpu);
-		goto out_disable_sram_reg;
+		goto out_free_speedbin;
 	}
 
 	ret = clk_prepare_enable(info->cpu_clk);
@@ -533,6 +571,10 @@ static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
 out_free_opp_table:
 	dev_pm_opp_of_cpumask_remove_table(&info->cpus);
 
+out_free_speedbin:
+	if (info->opp_token > 0)
+		dev_pm_opp_clear_config(info->opp_token);
+
 out_disable_sram_reg:
 	if (info->sram_reg)
 		regulator_disable(info->sram_reg);
@@ -573,6 +615,10 @@ static void mtk_cpu_dvfs_info_release(struct mtk_cpu_dvfs_info *info)
 	clk_disable_unprepare(info->inter_clk);
 	clk_put(info->inter_clk);
 	dev_pm_opp_of_cpumask_remove_table(&info->cpus);
+
+	if (info->opp_token > 0)
+		dev_pm_opp_clear_config(info->opp_token);
+
 	dev_pm_opp_unregister_notifier(info->cpu_dev, &info->opp_nb);
 	if (info->soc_data->ccifreq_supported)
 		put_device(info->cci_dev);

-- 
2.55.0


