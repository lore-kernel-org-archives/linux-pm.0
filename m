Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DEA37DE98
	for <linux-pm@vger.kernel.org>; Sat, 13 Jun 2026 06:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781333915; cv=none; b=mPZAtrlqGIT058SpAvLVHG6uw6wG+4ZVC3y2OyNfCjK4edyc/HE4f2FnHH9o+gPOd1JF0Vub3/MLMQaafWgagRA7ap165lDPYQRjE8tCqTEpDBvkLrSrvUQw1j2dFHaHKl+lhlg3A2qys/N8iILqiOIpSak3EnllCdUouU25FkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781333915; c=relaxed/simple;
	bh=DeWG1uBjzQKbTfUIz2n8sQDA8/VxiIMWnBV+69O9kJM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O/JLIqwZOeuVvWmPXx4NYNtfHAkOHzff2yjMCYuzhzN/nIbE+AT9Mh3H8nWnOoFoDojtClS06erIS/fd/uZcpr8049mSH12ds0j22RTgOUEHyp444qnBk3XOS3IBz1fiGJhN2W7KOuKVVsN8Bae8OYE8F0hS5fKBaiXPQQSfbA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rOBV4Ux7; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rOBV4Ux7"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4903d730b1fso20770235e9.2
        for <linux-pm@vger.kernel.org>; Fri, 12 Jun 2026 23:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781333912; x=1781938712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q9lCT5hFuQlBjQqDnDlpEFs50IBGKZjmVIr8JFjJQzU=;
        b=rOBV4Ux7O7OU0aqioJCsJ0TWGBU4SARU1gJSSOOYtyveKYE+vFJPFhbwePDd6WSG6w
         0V54rl2RbOysJf9Ich6O/3FIrZqTeACoAHK5zweDBCSAP9r7c1p0LlJSBhfG328UbjFC
         lZusdgLdfMLHFJvQRljkURds5dI1YJK7/A46+O/mkvsKUfpkra1CmdV4YRauMmLNxppk
         quSZAUa0XID16ylBuzEsWIso56lchFAwnC1oLfKW/002t6BEyqYx894CiqNWmSTrAVcq
         n8sm31kvUagmu3p7O5MpfKo3q8eXf8kiG/KWdW5DjUEtTArQI6z6mSmuMS3Xa5Wp5C0Y
         hsqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781333912; x=1781938712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q9lCT5hFuQlBjQqDnDlpEFs50IBGKZjmVIr8JFjJQzU=;
        b=iniObHXiR1f1s8aU1add42zGEW+mP+tsQ19a/Qy5IdCyU4BBKnboSXXyDLsoWgSZWa
         OMvtMZ9HzaV9HYTmGtWlX34jyjB4UrWMh5Rou9qlJCvjnTocdFMD557NWA7BT+HotJra
         6SrjyJXsl7OZHvljoAshHUcykbL9Xb94albrkv2x7Mbq6bcF8LWM8VU5sB9xvyZVx4+b
         78vBzPiDtWpRFMMCBZ/Bu01OAekwfUlcaEH5A1Gq15faqmHLIB+sDSFl3F+v8uVQmCSl
         HJqXgGMGPSVZqUnYZarmQ/gQyaLXZP6RaZRJqJDehdaA97CorguepNz/n2jULSYIEJSh
         Ufuw==
X-Forwarded-Encrypted: i=1; AFNElJ8iK07srXBwC8eUGsie5Ce0NyA+sZexTdasH98c/Xzqk03lmOs28OLX0QFfHrNA1OAA6rROdfhuzQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzHg0cRoA6CRuDue5naUeQeH962US7uxyH8WjL6lkYHHzwbUrhT
	umDY2ZQkpDYeCxRNflST0ndfzp64HpE8k04vdnzUcTbGRdxJb+RF01loFKhRyr9H548=
X-Gm-Gg: Acq92OGNFLXTH+sBthFh+rvjf17dqcLCch5xRL9D5eHUhAQ1tGEcBVXllg9i0swZorO
	43RMcvuzbMkPoMP8nLs5gd1Ip3RLuH0rMIZvctPKFKrKwPd8+8Yi+6IaEECeLwDonSmuqTj/6UV
	yvByx8TwIptDKpgYu0ZdJzlIO0VWb9zsREWA3svK1zSyIABCDz1Wj/vM01gJK9uDV2gejyw4XNa
	NHrhDKVYIq3od4Tf9Log9OYF+cpJvrsZz2wxtnnmOHF/F9//KdG1xOMHC0KIczDdoud0PVMq3FQ
	sneGKvjr4H/Q6fBwZ6rpDGvHkY3Oo0+ehw8M0w+ijstk4qio8NkIIuImZdWWrY4nFLy6lO+2SOY
	6tvpcpQyRGBHkyeqBesfh5z/YNpAO+xoc2PivdlBEIDIMlc9cm3ts60m+knrL2C3I1jjL+RsxFf
	zjj3AfSpxFW1T6x/WOXJb0AL9ggHpGY4xUQQ4BZmObZLPoFb76eeey
X-Received: by 2002:a05:600c:4709:b0:490:5057:f5f7 with SMTP id 5b1f17b1804b1-4922007472cmr28836405e9.11.1781333912286;
        Fri, 12 Jun 2026 23:58:32 -0700 (PDT)
Received: from debian.tailb81abf.ts.net ([2a01:e0a:104a:4d80:14c0:9448:1c38:77df])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492202e5cbasm42917705e9.2.2026.06.12.23.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 23:58:31 -0700 (PDT)
From: MidG971 <midgy971@gmail.com>
To: tomeu@tomeuvizoso.net,
	ogabbay@kernel.org,
	heiko@sntech.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ulf.hansson@linaro.org
Cc: dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	xxm@rock-chips.com,
	chaoyi.chen@rock-chips.com,
	finley.xiao@rock-chips.com,
	diederik@cknow-tech.com,
	jonas@kwiboo.se,
	Midgy BALON <midgy971@gmail.com>
Subject: [RFC PATCH v4 3/9] accel: rocket: Add RK3568 SoC support
Date: Sat, 13 Jun 2026 09:01:10 +0200
Message-Id: <20260613070116.438906-4-midgy971@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260613070116.438906-1-midgy971@gmail.com>
References: <20260613070116.438906-1-midgy971@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Midgy BALON <midgy971@gmail.com>

The RK3568 has a single core of the same NVDLA-derived NPU IP as the
RK3588, with a 32-bit AXI master.  Add rk3568_soc_data and its
compatible.

Unlike the RK3588, the RK3568 NPU's compute clock is a PVTPLL managed by
TF-A via SCMI; start it from an noc_init callback with a real rate change
(an intermediate rate defeats the clock framework's unchanged-rate
shortcut).  Powering on and de-idling the NPU NoC are left to the power
domain (genpd), which performs them when the IOMMU supplier is resumed,
so the driver does not poke the PMU directly.

If noc_init fails, unwind through rocket_core_fini() so the core is torn
down completely rather than leaking the runtime-PM and IOMMU state.

Signed-off-by: Midgy BALON <midgy971@gmail.com>
---
 drivers/accel/rocket/rocket_core.c |  9 +++++++++
 drivers/accel/rocket/rocket_core.h |  3 +++
 drivers/accel/rocket/rocket_drv.c  | 31 ++++++++++++++++++++++++++++++
 3 files changed, 43 insertions(+)

diff --git a/drivers/accel/rocket/rocket_core.c b/drivers/accel/rocket/rocket_core.c
index 09c445af7de73..779e951596a15 100644
--- a/drivers/accel/rocket/rocket_core.c
+++ b/drivers/accel/rocket/rocket_core.c
@@ -88,6 +88,15 @@ int rocket_core_init(struct rocket_core *core)
 		return err;
 	}
 
+	if (core->soc_data->noc_init) {
+		err = core->soc_data->noc_init(core);
+		if (err) {
+			pm_runtime_put_sync(dev);
+			rocket_core_fini(core);
+			return err;
+		}
+	}
+
 	version = rocket_pc_readl(core, VERSION);
 	version += rocket_pc_readl(core, VERSION_NUM) & 0xffff;
 
diff --git a/drivers/accel/rocket/rocket_core.h b/drivers/accel/rocket/rocket_core.h
index d6421251670dc..5a145ba8c5a92 100644
--- a/drivers/accel/rocket/rocket_core.h
+++ b/drivers/accel/rocket/rocket_core.h
@@ -18,10 +18,13 @@ struct rocket_core;
  * struct rocket_soc_data - per-SoC configuration data
  * @num_cores: Number of NPU cores in this SoC.
  * @dma_bits: Physical address width reachable by the NPU's AXI master.
+ * @noc_init: Optional callback to bring up the NPU before it is reachable.
+ *            Used on RK3568 to start the PVTPLL compute clock via SCMI.
  */
 struct rocket_soc_data {
 	unsigned int num_cores;
 	unsigned int dma_bits;
+	int (*noc_init)(struct rocket_core *core);
 };
 
 #define rocket_pc_readl(core, reg) \
diff --git a/drivers/accel/rocket/rocket_drv.c b/drivers/accel/rocket/rocket_drv.c
index f0beed2d522c7..86484110ad6f0 100644
--- a/drivers/accel/rocket/rocket_drv.c
+++ b/drivers/accel/rocket/rocket_drv.c
@@ -10,6 +10,7 @@
 #include <linux/err.h>
 #include <linux/iommu.h>
 #include <linux/of.h>
+#include <linux/of_clk.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 
@@ -223,12 +224,42 @@ static void rocket_remove(struct platform_device *pdev)
 	}
 }
 
+/*
+ * The NPU compute clock is a PVTPLL managed by TF-A via SCMI; spin it up
+ * with a real rate change (an intermediate rate defeats the clock
+ * framework's unchanged-rate shortcut).  Powering on and de-idling the NPU
+ * NoC are handled by the power domain (genpd) before the NPU is accessed.
+ */
+static int rk3568_noc_init(struct rocket_core *core)
+{
+	struct clk *npu_clk;
+
+	npu_clk = of_clk_get_by_name(core->dev->of_node, "npu");
+	if (IS_ERR(npu_clk))
+		return dev_err_probe(core->dev, PTR_ERR(npu_clk),
+				     "failed to get the NPU SCMI clock\n");
+
+	if (clk_set_rate(npu_clk, 600000000UL) ||
+	    clk_set_rate(npu_clk, 1000000000UL))
+		dev_warn(core->dev, "failed to set the NPU compute clock rate\n");
+	clk_put(npu_clk);
+
+	return 0;
+}
+
+static const struct rocket_soc_data rk3568_soc_data = {
+	.num_cores = 1,
+	.dma_bits = 32,
+	.noc_init = rk3568_noc_init,
+};
+
 static const struct rocket_soc_data rk3588_soc_data = {
 	.num_cores = 3,
 	.dma_bits = 40,
 };
 
 static const struct of_device_id dt_match[] = {
+	{ .compatible = "rockchip,rk3568-rknn-core", .data = &rk3568_soc_data },
 	{ .compatible = "rockchip,rk3588-rknn-core", .data = &rk3588_soc_data },
 	{}
 };
-- 
2.39.5

