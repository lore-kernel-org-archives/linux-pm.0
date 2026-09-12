Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A218E3603EB;
	Sat, 12 Sep 2026 06:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789195880; cv=none; b=scAv5z4R4Yh1p4taZOzn7HqSIRG06EQaq1XEcC8bpyteejZXdzyx13AbhFmnH0+LgZO3QFZLSZSKT/xo3RdgeWkj72a0FKC/Bi3cH9O5WPiyJqAAZYoMLushEo1ScGh24flGvc5sVgDViEQlx/YgazU9g42fw5MeYQQOQc5bvDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789195880; c=relaxed/simple;
	bh=NzFBEuKw+edBTPRDPqk05HVymcwE1+Hsrc/T5KLMj4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QIPD8JAlRy+nXOtpBYaXrrU3BncjYXVqvWer/wHQXZR8x+NbNujlkcVNY5AajpemBfyn4npI7MNpyZORaDLUEwSBjnpA9WQp0D/OZi75RrwgWFZOy3HsXWsA96LQYBGbstFxBXCBQxfkaHzRAVi/JoxlnzN8Jz7+tf/S9WtvE1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=plxZdsK2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C6SAYQ4G; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="plxZdsK2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C6SAYQ4G"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5B35E7A00D2;
	Sat, 12 Sep 2026 02:51:17 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sat, 12 Sep 2026 02:51:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1789195877; x=
	1789282277; bh=bhEwuQXKYWMYM7UfAE9zXDC7PfmHACUKFcOafx5HkO8=; b=p
	lxZdsK2iSvV5FW1MdCY6tEokp983VtNTVCeChB06QUL7IURbDbPjIl/ACiDyyzdH
	hEu5cy9aDujp7G5km1DNBFvlzAgpBLsP6BBcYJvYpboPZp+bzayOUbz9cqldaWDH
	kcP63TVItmRMzorcPzd2vOBSwftv6krxdeYhY7rt6mAMMYips+IozOGhT0lFpY0A
	j/5sYzCn1pzyRZUmmJKs+SfXMXPssTORqPc3rtYs9MiVqS02/S8vZC6c/LQjwTm8
	NovqQgpdQLn1vx63+Cv4sU5ZZhVaJdfYxCWMNzrnEy7oKiUAy8lI1cI1/zJaHaHd
	ormn/ieXnm1dUpl9v2tYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1789195877; x=1789282277; bh=b
	hEwuQXKYWMYM7UfAE9zXDC7PfmHACUKFcOafx5HkO8=; b=C6SAYQ4GT8ChY1FVu
	3xVvaqjQpCK1Iv2Jg4BG5D/d+DKnHpuDaMn9xEsCiNquww3OjaDiWYKXeOz+jLZa
	qcWYID63FsjiN26rV6tKT8de4ssm+wbN5BcuCAQZ4gGYeJ8V7uttv5vxhk39If/6
	ubPY6CNPM1wZHTxlvUDn0i80xZJ+XdhrJsAyoEjZIKB/VkXnBi5Gp7H+3eo2Ikxv
	tjFe2i+YEzhuGb35kXtCgyR9rhTQCkLOZsdigicQ7GGKRQG94t6c9eZeX76zYc8V
	j0UmoRALtZ/yy1espElBfLFO+y1PzRnHLp4l5ANoiHgdWEfrHU1CetyYao+vPrLj
	2mzEA==
X-ME-Sender: <xms:ZPakatkLDzEOqtFAhO3RSx9Nu4DndYre3ixIpdhj4hk8amEvf0ZB-w>
    <xme:ZPakao_hIPBTzmf-9kXsIbnr9P93GV_dw4Y82JMQsZv7DSpMZ2zCMWjayozPns0iz
    LnCSwSC5vI7u4_KLuQFqnuA5_Gr93ygWDCghDysIUQle8k7ZHdwwzU>
X-ME-Received: <xmr:ZPakahfiULXKFHQ8WfKc6GWCUb9SGthORUAhfPlNNNBHSIk9NrxKwt1sLcZSVEFoNgvmK15imw>
X-ME-Proxy-Cause: dmFkZTEPb8qUI/Bch63DUv9Os4CRaZnJidcR38w4lyHY6iaGmzqubjANrD0SeN/gjpgWtD
    9JpSgLNav7upxo5UY8BD+gTgneuYvtjdT7xUeoI37l3u3ANYgfWTUMIQPTBe+0FGjKZ893
    EmiED4E9ABLDGP636x+3BNPL+06gHQG63VHM2tKDilhH/OyX7+TagruxeFKd93pQCYj32B
    BeiQF2P6k05N47Few9BlXMbV3J128+kb4hnRL4hf+Yoc0wDQXXqOQeonbIg1B1tOCqO85x
    XB7Y9LiCcE2oZkETEXdiacCDRMuKmK7OMtWiJEvsJa8P7QUcJM2B6xHrJPAU/2XBsLk7LU
    MpW+EDDQJ2Ssp/huf9O4ilhDarGGDooD/tPvjmxA3kV4YuBLbU0NgpsKcM2c3FTAKYnEg0
    jq5IGrTkmY47BXIoNJPhqR+oduqMGcqhz9nGiw6JhE/5cQUuLXQYPDV/lhGTFsq01TSQ0+
    D0Rd5roncpHx5JToGc+FO/+IyrU4ThcP5qdZL0/9k0YZQesYtIDta4uUVindQa19N+8vMU
    ghKOp7XxGNAE2QzZbXQ1G24VOw7zkmCgza6Abzr7xYJij1+jA8wedKIl3szVqlWrKvTM9O
    LxBTeYBqYWt04zJFlH8p53hyWTHycR1oaZ9Cn2KNybLme2DHZyJfL52F+mzg
X-ME-Proxy: <xmx:ZPakah0tutHbDPMLwPphicliFXKSa_YsuNNP7uWFogHY6SoDM25-tw>
    <xmx:ZPakaqDxoqfmHTMMN4A_au1mYEpfBFJDicVbh3HEinj5DPRSPKoZGg>
    <xmx:ZPakasSUfPRbPWHU0GWPX1LEhskvwO9WNjCx8HP0eUyQgs2b3cAeNA>
    <xmx:ZPakasKV1QZc6g25RY560Pui9qvHbNmNQtWVWhGCNvQzpAUR8qFmcg>
    <xmx:Zfakargh2M3UgUp5Rv-BhlcuPy5COn89vsG2A_eu4ssx8mmpg-59lN1p>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 12 Sep 2026 02:51:08 -0400 (EDT)
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
Subject: [PATCH v12 01/14] accel/rocket: request the core clocks by name
Date: Sat, 12 Sep 2026 18:50:40 +1200
Message-ID: <20260912065053.1519165-2-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260912065053.1519165-1-gahing@gahingwoo.com>
References: <20260912065053.1519165-1-gahing@gahingwoo.com>
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

