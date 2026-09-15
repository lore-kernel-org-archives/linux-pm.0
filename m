Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84B3485CD6;
	Tue, 15 Sep 2026 10:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789469039; cv=none; b=WMnPZdBTVbjjPpc2eXU9sXCdF51EncLYY7dcGx57cr2O607SQPExC0QsaBwbyObslfqZBFI5hDgfvF72kR9/Pmb3tBRSxxvkonBbNR18KwM+6didtNIEkT6NwpSexF7GbVEVYuGZ9ExuPZiRs1YZyE0qj+/8Jay3uk2W63nWHrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789469039; c=relaxed/simple;
	bh=NzFBEuKw+edBTPRDPqk05HVymcwE1+Hsrc/T5KLMj4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y0ukRaWqp6lVOoTyGJNFK62mr6Ss06wfLOXQgE0Ot7Eleh6fBRYGeNN5XDaZhJxxmugJxD9k/QqHvC9sBm5goxlPhRkxbJ6zXAFwO4/JWp4CVMGOv69o6948ptQQwMXu1zMsltUpnn+/1w0qxyT2C4DFpi1SC4tf7UNTs17RYqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=JOwYt+Oa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R1y2D1kk; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="JOwYt+Oa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R1y2D1kk"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailflow.stl.internal (Postfix) with ESMTP id 4C11C130050A;
	Tue, 15 Sep 2026 06:43:55 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 15 Sep 2026 06:43:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1789469035; x=
	1789476235; bh=bhEwuQXKYWMYM7UfAE9zXDC7PfmHACUKFcOafx5HkO8=; b=J
	OwYt+OafxXCRMaXL1Qq2O3plf7gkfpdplNbl9LltZI6ZSLhJ2bQRIGroTFNVZDy5
	BVYkdbBzSGQZRW76BPvu1tW1MW/Fq4GtPmslBhctlmf9L+fDnUb1aKcSFcJY+HG3
	tY0VHYKtj7ytNkkIVyjSR0Bn+FNjFDlkFzayF7W/yZOgjVQxGq4KTogdCXNvgqja
	6kLvPbFq074I0l8Tysp3w9MgRMYlab73baS9gnOwMWfKRaAZtkpTPSIGEvKqWbnl
	itdGEp8D0Fdic2HT7hPAyy6oQbN20gw71Vk4EFa30NLU3TqAwm64U0j3oPkxYDyc
	tloIZtI4B9Wnktew/pifg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1789469035; x=1789476235; bh=b
	hEwuQXKYWMYM7UfAE9zXDC7PfmHACUKFcOafx5HkO8=; b=R1y2D1kkxLklhMTaa
	uDNn62OcZ3YDUmtF7Axiupfb07Ud8AhHOSQVgybZQEldFjNXYkWZ7MhM4rRWKVBR
	C1mLYuY2uDch1Rex4XgrRJF5xkcGJbNoW9/gOLfjrOkYV0iX7S9dTs1nc+7FIyx+
	DaNWemG9ChCdkBL6Nl2XJ4NGTSaZQQsOw/iYmKDMIyjn9B0YjtIqbEhwqdZUIsNK
	MzeoO82dgIrNP7+rHD/RWpFFnNLi4JlD8LxkIwE3DEu2Uu6M7GK6b8eLRFOCoi2b
	SfN7tbzXRabOcX1sGZFoTmJ/HXDOghNPklqQ9JNKPUX1rHZy/iFa6xTKq9AHcpuE
	jj/fg==
X-ME-Sender: <xms:aiGpatG_1GwtJ10R9yGLP9yO4hzBPcaJXAkHkCQBSZLiniyMDfRNGA>
    <xme:aiGpaidSn_unZ8GXrwoOUaE-Msr7tNI7foWfqwBBv0PnFzu-QcxxfxkmrXsFZq6ly
    KyvwzgRZK1lo6fEjlEECJ7R7bPRV3pZSWB-Cw-2uuTIOgSEG38nFQ>
X-ME-Received: <xmr:aiGpas9ib8-Wu__Lx3Eb1sCVuq2kFYbh7oivnQH1CmXtHMod-u2--oAaobd2Q55oMiiCGKdEgg>
X-ME-Proxy-Cause: dmFkZTEJ7lsNMc5MXcmK0yAby6zAyahnp/o+BLQRTsAUuD6zUFYE1mfayW4ARlNvxFxbHL
    RViSXklp2Mvqoh7nMl9WcpZxcA5zX09aM17WbnSDD1mVdJoa+dDoRGgFZ+ZZgzctt5mn//
    Fi1Mt6BzxdDiSZyXddMkKr5ZuKnhcJKMT/Ww41HfwQaAux+0BU99FP+g6srkBweq+0Pyu4
    FpApM0KD75gdC3rQ4X6qbPGbs1ABgnV9cF7lajdZo5Ix2shyw0qolijI7Y4mlyGIz0nhlc
    sJGrQ0glbm4LA0H4VdiK+uhUvmoFkp3adh0VEvVmG9UeMUF3kO5gMGvK351yi5uht+G8ce
    DI7/ZiNybPTuBoz++yjJPRGtS44vvbyjusqOT9iol7emrB4kj7YhT9UdW604rLiJ/Shmi8
    JBTltnyRRqh0h+4rhdebi6ygPNLMmHn1hBORW4tfXhCVQ+DEnkk/JloYpdyEWCG1ehWuld
    gOtJRMEapgatlm+E2j7VEY1x5ljIgDaiTIVALzGirBGxdKsnpaU4yWgnbr1U9KYEx3i/Vp
    ASLpc53MK7MsdnqDjG4sjcnOWI1g36X4NRCP/8iuJtEhrb5U+LDPG4VqNpXQaGvyU8HHT2
    QzVVllk3jxuHCFrEJgEO4YqoHhkcDjazkIiw6vM7TAC0jOgZt3cTImBwMPew
X-ME-Proxy: <xmx:aiGpanVL_JEZlLkozTegQAx1k7J-fiYymaxikdQXzc9hpdkIDqlZNQ>
    <xmx:aiGpahjtLDTbES2rS_n-mCJ88TBua4YjjHigjl4Oen0rzrHVuZ4eeQ>
    <xmx:aiGpatx2yqV8b5qxgVioii32ntVKcyLCmWaSfZM1ccooe8MBFq89mA>
    <xmx:aiGpavppQLxsmTzRVLO0baXJonaOZvB_WdGDgz1RiEhQKqJlnvvJjg>
    <xmx:ayGpaspYgO9V1-KD8pYnrasL9MX7gZ8xVHBMzY_mMbYz-iC13xCU75Oj>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Sep 2026 06:43:46 -0400 (EDT)
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
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiaxing Hu <gahing@gahingwoo.com>
Subject: [PATCH v13 01/14] accel/rocket: request the core clocks by name
Date: Tue, 15 Sep 2026 22:43:15 +1200
Message-ID: <20260915104328.45901-2-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915104328.45901-1-gahing@gahingwoo.com>
References: <20260915104328.45901-1-gahing@gahingwoo.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Igor Paunovic <royalnet026@gmail.com>

rocket_core_init() hands core->clks to devm_clk_bulk_get() without ever
setting the .id members. The rocket_core array is allocated with
devm_kcalloc() in rocket_device_init(), and rocket_probe() only fills in
.rdev, .dev and .index, so all four clk_bulk_data entries are requested
with a NULL con_id (unlike core->resets, whose ids are set a few lines
above).

clk_get(dev, NULL) ends up in of_clk_get_hw(np, 0, NULL), and
of_parse_clkspec() only consults "clock-names" when a name was passed, so
the index stays 0 for all four entries. Every entry therefore ends up
holding a handle to the *first* clock of the DT "clocks" property, i.e.
ACLK_NPUn. Nothing fails: probe succeeds and the driver believes it owns
four different clocks.

The consequence is that rocket_device_runtime_resume() prepares and enables
the AXI clock four times, while hclk, pclk and - most importantly - the NPU
compute clock ("npu", SCMI_CLK_NPU on RK3588) are never prepared or enabled
by this driver at all. The NPU still works only because the Rockchip
power-domain driver sets GENPD_FLAG_PM_CLK and its attach_dev() callback
walks the device node with of_clk_get() and adds every clock to the pm_clk
list, so genpd happens to keep the remaining clocks running. The bug is
therefore latent today, but it means the driver holds no reference to the
clock that actually feeds the NPU, which stands in the way of any future
frequency scaling (OPP/devfreq) work.

Found on an Orange Pi 5 Plus (RK3588) by reading the live clock tree:
/sys/kernel/debug/clk/clk_summary shows four "fdab0000.npu" consumer
handles on aclk_npu0 (and likewise on aclk_npu1/aclk_npu2 for the other two
cores), while hclk_npu0, pclk_npu_root and scmi_clk_npu have no
"fdab0000.npu" consumer at all - their only consumers are the
"npu@fdab0000" handles created by the power-domain driver via of_clk_get().

Set the ids explicitly, in the order mandated by the binding
(Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml):
aclk, hclk, npu, pclk. After the change the driver holds one handle per
distinct clock and clk_bulk_prepare_enable() covers all four.

Note that this is a user-visible tightening for out-of-tree DTs: the old
NULL-id requests resolved by index and succeeded no matter what
"clock-names" contained, while the named requests fail probe with -ENOENT
when one of the four names is missing. That is the right outcome for
in-tree users - the binding requires exactly these four clock-names and
rk3588-base.dtsi carries them on all three cores - but a DT that relied on
the permissive lookup goes from silently running on the wrong clock handles
to not probing at all, so record the change here where git log will find
it.

Fixes: ed98261b4168 ("accel/rocket: Add a new driver for Rockchip's NPU")
Signed-off-by: Igor Paunovic <royalnet026@gmail.com>
Tested-by: Sidong Yang <sidong.yang@furiosa.ai>
Tested-by: Diederik de Haas <diederik@cknow-tech.com>  # NanoPC-T6 LTS, NanoPC-T6 Plus
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Reviewed-by: Jiaxing Hu <gahing@gahingwoo.com>
Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
---
 drivers/accel/rocket/rocket_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/accel/rocket/rocket_core.c b/drivers/accel/rocket/rocket_core.c
index b3b2fa9ba..5dd260bac 100644
--- a/drivers/accel/rocket/rocket_core.c
+++ b/drivers/accel/rocket/rocket_core.c
@@ -28,6 +28,10 @@ int rocket_core_init(struct rocket_core *core)
 	if (err)
 		return dev_err_probe(dev, err, "failed to get resets for core %d\n", core->index);
 
+	core->clks[0].id = "aclk";
+	core->clks[1].id = "hclk";
+	core->clks[2].id = "npu";
+	core->clks[3].id = "pclk";
 	err = devm_clk_bulk_get(dev, ARRAY_SIZE(core->clks), core->clks);
 	if (err)
 		return dev_err_probe(dev, err, "failed to get clocks for core %d\n", core->index);
-- 
2.43.0

