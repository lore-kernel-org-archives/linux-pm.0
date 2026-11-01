Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793521529;
	b=sNBPd+EQG9AimNgngS1zV7iMZhVSezrivhA8yod1fB8q6Dn8c/wYNrSeqrh/7Y1Rq9an
	 dAsE4tKrMs+ECZ6+yKxguDT/mhx6ZAGFRwT7V5XKemWhNbow9TXVefrnEZPK9xjH3vRZ7
	 Q2LyxAfRp3R7QsYe1fWS9OS8VFZBJUHzVQvmyHPdw5rIoSf7Xgn+TX2RqOlpQzQcKRtLG
	 9NK+jF3XqijR80lj1X0gJAkdLkGjmcV82UNNYgvY5zieffpltONvRZPSnM6izlYw1vhEZ
	 f5PpkGPJcdSGbpD0ISzI2QrCH7ioUi7J/8JtgWqTk32EH0ug8QMAwrjUZ9GeGMNf3Hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793521529;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=FHzAQmQpP4sd1jqtxz43dDgFqYq4LQFMwG1/1uaJlXI=;
	b=OMauIwyr2bunejZRQvCoqfiL31r2JOZv17hMZeUD2fNuutlJw/TxQZ/JrgZw+ChDUtF5
	 N5FCfHzX0Er0BvqHnEdj/65jsxPVWZ23ViWGl2k3pZyFPOX+wSsvA0UPbrWVYAb2E8QM4
	 ZTGjARnuUQu5fNq6KQ7UumBSDFKBBBK1EuiCqIg2dQvvpETX82JMtz+vkPacKDTvVPM0/
	 /2Fm+OD8yabbF29UBT4wpCFYoDhlHRJSjYfhpbErwcgr9NHtk6XtlnCa+BV4sZZdePWY3
	 VbqyJgmpO3dQl9FI4PS6pycVDl+BbyB4x6Mics2cqb5VzlcgAZCP1cqiSHj026mZFZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gahingwoo.com;
	spf=pass smtp.mailfrom=gahingwoo.com;
	dkim=pass header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm1 header.b=LPH1fT19;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="dqTe/a8P";
	arc=none smtp.remote-ip=103.168.172.156
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4B6606A327
	for <linux-pm@vger.kernel.org>; Sun,  1 Nov 2026 08:25:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B4B6606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm1 header.b=LPH1fT19;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=dqTe/a8P
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B40681400312
	for <linux-pm@vger.kernel.org>; Sun,  1 Nov 2026 03:25:27 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sun, 01 Nov 2026 03:25:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1793521527; x=
	1793607927; bh=FHzAQmQpP4sd1jqtxz43dDgFqYq4LQFMwG1/1uaJlXI=; b=L
	PH1fT19QM1AZuOF9a/E5FMayFL/9cZaSY4z9kRswAzVyRrRwbG5DzaIN2s/3JTWx
	nd69IEWFhM6gIUi0OOa3WwKmJseSfE3bl4hvBTcJdsVw0jBSwkMwpX/k05db85w4
	hMwBcgN7K+8WoxBKxLQpeYbfeDb3zbIcWdEWLDysZJCgWQfKbGimTaZ2uaICpAeM
	7Yh3WwieOoIItbzKwEHqnyAWmHY322TTzUZ+h3AhrrhOzbQ7jxYjXnjeg+dkvrta
	aL0Nll0wmsbqR7utuROxjenSFJ3d7ZbTrdd9e++cEerwS58l+O+5QsqLUitiBIAt
	1DBGwWPM/tr8Q49X79UEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1793521527; x=1793607927; bh=F
	HzAQmQpP4sd1jqtxz43dDgFqYq4LQFMwG1/1uaJlXI=; b=dqTe/a8PNr2fbZmRa
	OZUBF97cfZrfzAb2+EMrhRDa7k01UnSVYhFlz3+TX/jHzGeUNElw5rbCR6E6TPvF
	ZOe9whbuyLujinSJrx+T+X1UQtwwdeJbM7z+WoKKeR80ixbEu5NjzBPr3jh6+ydp
	KLRTxHb040/S+KkqEDd9MHiJPCmupkFkAAqmQhrmT/9tqAIuUoO35fNgQ417MLV2
	nHCvCLUNfwXuHj41ioBPDlzHa9rqAVVamO4YstaUXuL5cQSh7kUIuHgLw/o419lg
	oWVGi1QSQq10bBEvw0Y36xl3mCNWTHVBoCrGZBCd8+Cmqkb/lpVvgY+A7KBGPx/p
	ZWGsg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=gahingwoo.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793521527; d=gahingwoo.com;
	mf=PGdhaGluZ0BnYWhpbmd3b28uY29tPg==;
	rt=PGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZz4=;
	s=fm1:rsa-sha256:NTI/7MZsODzjIy1WCfDtjcXQyvxlWnMcDamv/DP6E4wEa6i
	IxSMrkE5mpGtgJePhs8e04PV11rDtdGfOpMuUutOq/crGIZjdfjuyOQ+9D7+gchl
	EfVJwx2fPWrGaD0wripaUYf8okGnyslXb+8LfnQZg4bpu4yiUIQO58H13uMZsjVf
	ShlSPvei7tJ9bm67YUcRXJ5Kes6ayxnV/FwLFS6TBrq6Bgw4B/dyX0AEhIIdEVAH
	acMNMti++XLwidddN/qCTex/CCrULaT8bmjtHx0BF7bugK3tameOI7W0k6L9xB4+
	X+hVCSNBKYI5jRRa6hTdtFd8hz5lnwoEpCvV2Cw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:buod84DR8cqWWQhE0E5Q3qFja4zgNoerc5HR648FffI=:v7tdtpGXTVcfBY5x0S1xO51d7P9xYdXQ/Ftzwc78Sok=;
X-ME-Sender: <xms:d_fmavFbf53d4-ntYpzbwfANRpSFhK7TpYwyVFeCOLh6qKo3gMq8Ew>
    <xme:d_fmaupP-tgn2g-cDcejCCWClW800NvUHi9jvATh-nMplG9qDEoE-3wrcu2mva1bH
    TXZOVnsDOTyDd-Cwbhb2UKEBPX5Td3erOgrtJbGz3jVawnt2zQDT_EJ>
X-ME-Received: <xmr:d_fmav2f6_onuawGkYqYV4cok2cMMb3BRZfHzMrUYIb09iAUp5ZFK9mj6cGCFQWKf0WeSkQs>
X-ME-Proxy-Cause: dmFkZTGi9YjOdKQLf+zWxg/w91WzT+uqm2xpgssQcWZohvc6bKLQMeC7D8h8ueUtggTEef
    gAGOa5BbXDUT8EfyZdzcV5ECCD9ruUgqkb0XNLmzoQtHCMQQWwzhBmmDGjBLc2QuGbIehe
    gigYwEf9yRu0Dyr/odqCPMjG++elSCtBPPYQvIuEQpUG4Cv9X2ghHyQMiKv4w8Zf/mIBnz
    51hhh2IZzpCsabRVBg0hrB/mckGnEpXwlBb4joTL6XZ+pp98kXgMfB/+cS6046RbnywFqm
    RaZ0X6Pg5wrWSD4fQzBP2ye/2rEwhEJLxdphz4F4SZwCmq2ijXJ1Q3C5du6Be8U8CKGwcm
    lH3snaWvoGmjyk7uI1Oye8a/diMjPxSE6WG6j9iLnK9/igFhzdv4MSDumLPZt1balDovPb
    iWPNtsi2g+55oOOPIrW1HJZDelkKoTcGxaAmAHQ5wwr33btYnc/Qup2mTj6jg+aTDAMAzo
    7LZTgcVs1JalHV3efD18tVmiyF6F4r0O/wUniEkTr2pMOAepw7AwLC3FCzUgwPieUw0PL2
    40ZNMieHaGFCZ6rNnEidPvrwqRBvlw/KiLbBHk3Ky+FX6FASM+Qb5lbBgvJ58yy19qaFmT
    jy8iJGPc6Y3ddI1eugpvibYI5KzMLtdsnvzg/CbN1qc7AF9EMvqrkE5Bzmmg
X-ME-Proxy: <xmx:d_fmaqCCeeRfczahVTfShV-hplLwq04rpoFVMCRDGtX6kP6xnVT1dA>
    <xmx:d_fmai97KTxFA8hAP2Y3BtncSIfm_2yZvihUIVWTqmvd0yEEREWKJg>
    <xmx:d_fmagNdeWMl5qj_xVM2CYQcUYCeyhT4VhDBQ4H3m8oIoBZ3Y65CPA>
    <xmx:d_fmakFidscMcjH08BKh2DKjyqJ0-gmbntpbhwGyBzmQv1HI1qaRNw>
    <xmx:d_fmaitoaMvC-a8SAEEt1doOtlbKg9H5qA3JYpqbronrMdITDEYeEzvK>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 1 Nov 2026 03:25:19 -0500 (EST)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: tomeu@tomeuvizoso.net,
	heiko@sntech.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	ulfh@kernel.org,
	p.zabel@pengutronix.de,
	ogabbay@kernel.org,
	zhangqing@rock-chips.com
Cc: royalnet026@gmail.com,
	abel.vesa@oss.qualcomm.com,
	sebastian.reichel@collabora.com,
	sidong.yang@furiosa.ai,
	u.kleine-koenig@baylibre.com,
	chaoyi.chen@rock-chips.com,
	diederik@cknow-tech.com,
	alchark@flipper.net,
	leonard@lausen.nl,
	jeff.hugo@oss.qualcomm.com,
	rfoss@kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiaxing Hu <gahing@gahingwoo.com>
Subject: [PATCH v15 12/15] accel/rocket: add RK3576 NPU (RKNN) support
Date: Sun,  1 Nov 2026 21:23:04 +1300
Message-ID: <20261101082307.151957-13-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261101082307.151957-1-gahing@gahingwoo.com>
References: <20261101082307.151957-1-gahing@gahingwoo.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RK3576 has two cores of the RKNN block, with six clocks per core (the
CBUF has its own), one reset instead of two, two power domains attached
explicitly, and a PC_TASK_CON that packs the task number into sixteen bits
instead of twelve. Chaoyi Chen of Rockchip confirmed that layout:

  https://lore.kernel.org/all/4f300b78-d96d-4d98-8819-dc292b0c9b97@rock-chips.com/

Count the cores from the driver's own match table, now in rocket_drv.h, so
the count and the array it sizes cannot disagree.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
---
 drivers/accel/rocket/rocket_core.c   | 20 ++++++++++++++
 drivers/accel/rocket/rocket_core.h   |  8 +++---
 drivers/accel/rocket/rocket_device.c |  7 ++++-
 drivers/accel/rocket/rocket_drv.c    | 16 +++++++++---
 drivers/accel/rocket/rocket_drv.h    |  2 ++
 drivers/accel/rocket/rocket_job.c    | 39 +++++++++++++++++++++++++---
 6 files changed, 81 insertions(+), 11 deletions(-)

diff --git a/drivers/accel/rocket/rocket_core.c b/drivers/accel/rocket/rocket_core.c
index b202d15816a3..91f6901764f9 100644
--- a/drivers/accel/rocket/rocket_core.c
+++ b/drivers/accel/rocket/rocket_core.c
@@ -8,6 +8,7 @@
 #include <linux/err.h>
 #include <linux/iommu.h>
 #include <linux/platform_device.h>
+#include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
 
@@ -21,6 +22,7 @@ int rocket_core_init(struct rocket_core *core)
 	u32 version;
 	int err = 0;
 
+	/* RK3576 has no per-core hclk reset, so it takes srst_a alone. */
 	core->resets[0].id = "srst_a";
 	core->resets[1].id = "srst_h";
 	err = devm_reset_control_bulk_get_exclusive(&pdev->dev, core->soc->num_resets,
@@ -32,6 +34,9 @@ int rocket_core_init(struct rocket_core *core)
 	core->clks[1].id = "hclk";
 	core->clks[2].id = "npu";
 	core->clks[3].id = "pclk";
+	/* RK3576 clocks the CBUF separately; the compute path stalls without these. */
+	core->clks[4].id = "aclk_cbuf";
+	core->clks[5].id = "hclk_cbuf";
 	err = devm_clk_bulk_get(dev, core->soc->num_clks, core->clks);
 	if (err)
 		return dev_err_probe(dev, err, "failed to get clocks for core %d\n", core->index);
@@ -60,6 +65,21 @@ int rocket_core_init(struct rocket_core *core)
 	if (err)
 		return err;
 
+	/*
+	 * RK3576 spans two power domains, and a multi-domain device is skipped
+	 * by the driver-core single-domain auto-attach, so attach the list here.
+	 * This goes before the first thing that would have to be unwound, so a
+	 * failure can simply return.
+	 */
+	if (core->soc->multi_power_domain) {
+		struct dev_pm_domain_list *pd_list;
+
+		err = devm_pm_domain_attach_list(dev, NULL, &pd_list);
+		if (err < 0)
+			return dev_err_probe(dev, err,
+					     "failed to attach NPU power domains\n");
+	}
+
 	core->iommu_group = iommu_group_get(dev);
 
 	err = rocket_job_init(core);
diff --git a/drivers/accel/rocket/rocket_core.h b/drivers/accel/rocket/rocket_core.h
index ba74c5339b94..8c8d1f4532e0 100644
--- a/drivers/accel/rocket/rocket_core.h
+++ b/drivers/accel/rocket/rocket_core.h
@@ -29,8 +29,10 @@
 
 /* Per-SoC differences, selected by the of_device_id match data. */
 struct rocket_soc_data {
-	unsigned int num_clks;		/* clk_bulk count */
-	unsigned int num_resets;	/* reset_bulk count */
+	unsigned int num_clks;		/* clk_bulk count: 4 base, 6 with CBUF */
+	unsigned int num_resets;	/* reset_bulk count: 2 base, 1 on RK3576 */
+	bool multi_power_domain;	/* device spans more than one PM domain */
+	bool task_con_16bit;		/* PC_TASK_CON uses the 16-bit task number */
 };
 
 struct rocket_core {
@@ -43,7 +45,7 @@ struct rocket_core {
 	void __iomem *pc_iomem;
 	void __iomem *cna_iomem;
 	void __iomem *core_iomem;
-	struct clk_bulk_data clks[4];
+	struct clk_bulk_data clks[6];
 	struct reset_control_bulk_data resets[2];
 
 	struct iommu_group *iommu_group;
diff --git a/drivers/accel/rocket/rocket_device.c b/drivers/accel/rocket/rocket_device.c
index efd004194c1a..9b8d6fd60941 100644
--- a/drivers/accel/rocket/rocket_device.c
+++ b/drivers/accel/rocket/rocket_device.c
@@ -9,6 +9,7 @@
 #include <linux/of.h>
 
 #include "rocket_device.h"
+#include "rocket_drv.h"
 
 struct rocket_device *rocket_device_init(struct platform_device *pdev,
 					 const struct drm_driver *rocket_drm_driver)
@@ -27,7 +28,11 @@ struct rocket_device *rocket_device_init(struct platform_device *pdev,
 	ddev = &rdev->ddev;
 	dev_set_drvdata(dev, rdev);
 
-	for_each_compatible_node(core_node, NULL, "rockchip,rk3588-rknn-core")
+	/*
+	 * Count over the same match table the platform driver binds with, so
+	 * that a core added there is counted here without a second edit.
+	 */
+	for_each_matching_node(core_node, rocket_dt_match)
 		if (of_device_is_available(core_node))
 			num_cores++;
 
diff --git a/drivers/accel/rocket/rocket_drv.c b/drivers/accel/rocket/rocket_drv.c
index 284af027f398..cc1903b87b25 100644
--- a/drivers/accel/rocket/rocket_drv.c
+++ b/drivers/accel/rocket/rocket_drv.c
@@ -234,13 +234,23 @@ static void rocket_remove(struct platform_device *pdev)
 static const struct rocket_soc_data rk3588_soc_data = {
 	.num_clks = 4,
 	.num_resets = 2,
+	.multi_power_domain = false,
+	.task_con_16bit = false,
 };
 
-static const struct of_device_id dt_match[] = {
+static const struct rocket_soc_data rk3576_soc_data = {
+	.num_clks = 6,
+	.num_resets = 1,
+	.multi_power_domain = true,
+	.task_con_16bit = true,
+};
+
+const struct of_device_id rocket_dt_match[] = {
 	{ .compatible = "rockchip,rk3588-rknn-core", .data = &rk3588_soc_data },
+	{ .compatible = "rockchip,rk3576-rknn-core", .data = &rk3576_soc_data },
 	{}
 };
-MODULE_DEVICE_TABLE(of, dt_match);
+MODULE_DEVICE_TABLE(of, rocket_dt_match);
 
 static int find_core_for_dev(struct device *dev)
 {
@@ -299,7 +309,7 @@ static struct platform_driver rocket_driver = {
 	.driver	 = {
 		.name = "rocket",
 		.pm = pm_ptr(&rocket_pm_ops),
-		.of_match_table = dt_match,
+		.of_match_table = rocket_dt_match,
 	},
 };
 
diff --git a/drivers/accel/rocket/rocket_drv.h b/drivers/accel/rocket/rocket_drv.h
index 2c673bb99ccc..0cd692a66b85 100644
--- a/drivers/accel/rocket/rocket_drv.h
+++ b/drivers/accel/rocket/rocket_drv.h
@@ -6,10 +6,12 @@
 
 #include <drm/drm_mm.h>
 #include <drm/gpu_scheduler.h>
+#include <linux/device-id/of.h>
 
 #include "rocket_device.h"
 
 extern const struct dev_pm_ops rocket_pm_ops;
+extern const struct of_device_id rocket_dt_match[];
 
 struct rocket_iommu_domain {
 	struct iommu_domain *domain;
diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index 417d5ef06c09..0ba3c66ff3e1 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -31,6 +31,30 @@
 /* Bits 3:0 of PC_BASE_ADDRESS hold the mode selection bit and reserved bits */
 #define ROCKET_REGCMD_ALIGN	16
 
+/*
+ * PC_TASK_CON packs the task number with control bits above it, and neither
+ * the width of the number nor the count of the controls is the same on every
+ * SoC. rocket_registers.h is generated from the RK3588 description, where the
+ * task number is twelve bits and there are two:
+ *
+ *   RK3588   BIT[11:0] task_number, BIT[12] pp_en, BIT[13] count_clear
+ *   RK3576   BIT[15:0] task_number, BIT[16] pp_en, BIT[17] count_clear,
+ *            BIT[18] last_layer_clear
+ *
+ * The RK3576 layout was confirmed by Chaoyi Chen of Rockchip:
+ * https://lore.kernel.org/all/4f300b78-d96d-4d98-8819-dc292b0c9b97@rock-chips.com/
+ *
+ * Writing the RK3588 layout to an RK3576 therefore asks for task_number
+ * 0x7001, that is 28673 tasks: the count clear at BIT(13) lands inside the
+ * sixteen-bit task number and inflates the count instead of clearing it.
+ * The task counter is then only ever cleared by a reset, so the block runs
+ * one task per reset.
+ */
+#define RK3576_PC_TASK_CON_TASK_NUMBER(n)	((n) & 0xffff)
+#define RK3576_PC_TASK_CON_PP_EN		BIT(16)
+#define RK3576_PC_TASK_CON_COUNT_CLEAR		BIT(17)
+#define RK3576_PC_TASK_CON_LAST_LAYER_CLEAR	BIT(18)
+
 static struct rocket_job *
 to_rocket_job(struct drm_sched_job *sched_job)
 {
@@ -166,10 +190,17 @@ static void rocket_job_hw_submit(struct rocket_core *core, struct rocket_job *jo
 	rocket_pc_writel(core, INTERRUPT_MASK, PC_INTERRUPT_MASK_DPU_0 | PC_INTERRUPT_MASK_DPU_1);
 	rocket_pc_writel(core, INTERRUPT_CLEAR, PC_INTERRUPT_CLEAR_DPU_0 | PC_INTERRUPT_CLEAR_DPU_1);
 
-	rocket_pc_writel(core, TASK_CON, PC_TASK_CON_RESERVED_0(1) |
-					 PC_TASK_CON_TASK_COUNT_CLEAR(1) |
-					 PC_TASK_CON_TASK_NUMBER(1) |
-					 PC_TASK_CON_TASK_PP_EN(1));
+	if (core->soc->task_con_16bit)
+		rocket_pc_writel(core, TASK_CON,
+				 RK3576_PC_TASK_CON_LAST_LAYER_CLEAR |
+				 RK3576_PC_TASK_CON_COUNT_CLEAR |
+				 RK3576_PC_TASK_CON_PP_EN |
+				 RK3576_PC_TASK_CON_TASK_NUMBER(1));
+	else
+		rocket_pc_writel(core, TASK_CON, PC_TASK_CON_RESERVED_0(1) |
+						 PC_TASK_CON_TASK_COUNT_CLEAR(1) |
+						 PC_TASK_CON_TASK_NUMBER(1) |
+						 PC_TASK_CON_TASK_PP_EN(1));
 
 	rocket_pc_writel(core, TASK_DMA_BASE_ADDR, PC_TASK_DMA_BASE_ADDR_DMA_BASE_ADDR(0x0));
 
-- 
2.43.0

