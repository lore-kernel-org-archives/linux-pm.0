Received: from flow-b8-smtp.messagingengine.com (flow-b8-smtp.messagingengine.com [202.12.124.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0C0415F3B;
	Wed, 12 Aug 2026 09:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786527794; cv=none; b=MVX0rewBlsFePiNtBHHymVdSHLbRFTx0u/BdcF3bAjEa9wbl71Yu0YNuoILOAlijQ11/dc0lRzW1+67eLGEm67V9+IgJKxr7jVBFpnIgrErKkpVvzr+jgEI0HTqKQ7GUkoHtPGnAEMUHYbkP56Lr+yXGlUcruXZC4IepGn302tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786527794; c=relaxed/simple;
	bh=U4X+rhj/sXR+vtuG+XLMw3JDpabQzZVg4RMgkgdiYpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WM5WHRChNAR1wJt54nr0rzX2N3y8pZwxpbr4ibCC9S9giJuXZcHE1rPxQTbpNosPwv/CjFAcnO1FW52UNJI9XQWA8ke5splVVrqWVCqKw1y7AUgXcF2kLB+/9RFePTbf/3AFQI6x7qIYiCQ9e5z+2RTeWbhgN0z+iIAAVWig2Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=kZrsis23; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fj9Wn+op; arc=none smtp.client-ip=202.12.124.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="kZrsis23";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fj9Wn+op"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailflow.stl.internal (Postfix) with ESMTP id ED79A1300228;
	Wed, 12 Aug 2026 05:43:11 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 12 Aug 2026 05:43:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1786527791; x=
	1786531391; bh=sgu7nAbq8Yx5koaOMKJWboxHdobCAGSow6z6pMfKPGU=; b=k
	Zrsis232bZfkHFr1KDQEA5RwQSh3Y+f3GqvVYV7nKQF+6G0Db3fpwDhWBdtp3lDq
	51zIJWwgEXcvKId6UezziixDbqKveDd6V1ji4kHTgSOF26xGwYCj0PcUHFEZa71k
	iTH8ZYcceh7LhhvZwL41kxlsdVUgIP2Be8z0ESAYFnC2DexiqoU3EcreOKbm8Uj/
	CICkhL73XQ2G1xyhOtKjLVvNHT9VLmqDB+npmjB3hwgkItvYSxAUMAaWIRRLgPK2
	tccFNYPinP0Y2ZihHkYA9cAlXoYPw3fk267y+9RCWiXz3K1/w/PAkyAIQq5h9jMU
	bLQiOC7C/anypjjDOKaFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1786527791; x=1786531391; bh=s
	gu7nAbq8Yx5koaOMKJWboxHdobCAGSow6z6pMfKPGU=; b=fj9Wn+optE2/3n76F
	GwQmq0VW+w7empB07ErfPqBxlWq9ur47tekxJR6whVcMUm1hAmYtmqN4yM4+99jq
	xirk16UW8EvC2ZjyK0EzOFKZaGg8I3j84XXmvFYl2dera6KFC0HgA/TS7NI/wTxf
	RG5xxr/Kkj4NB+NmgIgxy+gfczwrRE6ljtMWREL9fxY7cScuIoSCuwUqdAM1ahdI
	X5w099A9V9iCdYhr5XBONEUrsd/GY5fb3FnO1mm769rUsuRJBwTxJ7h7SvQABjc7
	KDnoc+dctpJpQ3eoNBB+W0nq63hciWa4hAjo1UKinI/AxGIAN29fdMJlbqV3UIgJ
	EqAPw==
X-ME-Sender: <xms:L0B8avEboDPCuuC1vC6rHrdMuJAwgWObuGZMhvp_hQy_jbf_VuLPSg>
    <xme:L0B8avG3vLxS4qsQn3BmC1HPTUN5QCRUknKRpqgXHaJCqg4vAY05jjzzgql0sH_SO
    lVNvleNwk3M834kTt0vzDEf3ArwU9_M3kSU3rJAG_S3AXrTJmUuBKk0>
X-ME-Received: <xmr:L0B8auByJQ0UwO1i8P4tZmcAU4RCegwsYb6-K9vWezrJExzQkJdr-NQzDz9ADiZva2h3d5wgIg>
X-ME-Proxy-Cause: dmFkZTF94piGrtEjR6BqnUD01iAoRBrq3noUWIXMrqVxBmNdzc8ysXT9N2YVYtRNqawTRu
    5Tl3rQYplDYkQz64yVDsKNFMVYgL9BKpjjZZz3bLRD/+XGC1BZ3Esv0AwJfhbuLnvweNXe
    XninG/a9vIk48teTHN+BtpEclMrlsHF+QX/6PBrRNtzjC6rQ0Gl0MN/erogFMCvHGI9gfF
    BkOzoGqrWELCUvV5BiizkhvRpEK4YW2BzI/XolsWW1gtttmqOJiC2cJo6UXJpqakqxIwIs
    8bcD7GpDqISPzyFOIa2Ga/vPqf873UUD6g1hGqz8oQ9p48/ytHS5CEh/RcSEIGrpol2DrH
    6wED6MbxOsSxo5qHTy3DjNvG9D1ESABJOX1YgrTau1f828XznckthGzgOJFm/VJerZ2KRh
    6MYj74k9l/GCR+f5kepX73FH4E4lIhikDx1yVrlQzT8cnR6Qg4t5bOfaxDulRH3zgGGY4Z
    qdQmvzP+L8MZyiqj1/viBgy3hq0FbbB6zuhmk/7mOIITFHjCVIvKwV4Ure2tXfpUiyk69M
    CGKgSuV5whQWF3SlRMam8TUpON6jdVgzZuAWsTJey+xSYXzXSA2Iq4fqo0AxIGV0kOHTsK
    ob0JPKE7vP38iddd4Xe8UTkkvVRsKIVtBc6I5J3qyAKvUkmBRHB6Y1Gu/TUw
X-ME-Proxy: <xmx:L0B8aknapWHNDYy-lykpU4VpX1VcEj89pCqPIQaPLFiymg_lcb9N7A>
    <xmx:L0B8as58dnhA0EYKPuIKa9qT1EC1Vm4a6-u9viGmkFHx-8KrxnWK9w>
    <xmx:L0B8aruU6HSOJVMjWMxP2KhRI-FCaGW8ITLPtuwTxIN5nJoVTBFyQw>
    <xmx:L0B8asXU7SM92QV2sioCS1CcbdVP6W0K_T8oxC3ZutGfPjSUyh5Ptw>
    <xmx:L0B8asX937CmQv-iufcxbRbnjgnUzebdvMbfh13BSfUvG4TzdGZYsrV2>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 05:43:04 -0400 (EDT)
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
	alchark@flipper.net,
	chaoyi.chen@rock-chips.com,
	diederik@cknow-tech.com,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiaxing Hu <gahing@gahingwoo.com>
Subject: [PATCH v7 10/10] arm64: dts: rockchip: rk3576-rock-4d: enable NPU
Date: Wed, 12 Aug 2026 21:41:05 +1200
Message-ID: <20260812094106.1391698-11-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812094106.1391698-1-gahing@gahingwoo.com>
References: <20260812094106.1391698-1-gahing@gahingwoo.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable rknn_core_0 and its IOMMU on the Radxa ROCK 4D and supply the
core from vdd_npu_s0.

The supply is marked always-on because the NPU power domains are what
gate the block here, and dropping the rail underneath them takes an
async SError on the next power-on rather than a clean retry. Only
rknn_core_0 is enabled: the driver binds one core per node and the
second core is left to whoever can test it.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
---
 arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts b/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts
index 272af1012..965e0906b 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts
@@ -442,6 +442,7 @@ regulator-state-mem {
 			};
 
 			vdd_npu_s0: dcdc-reg2 {
+				regulator-always-on;
 				regulator-boot-on;
 				regulator-enable-ramp-delay = <400>;
 				regulator-min-microvolt = <550000>;
@@ -869,3 +870,12 @@ vp0_out_hdmi: endpoint@ROCKCHIP_VOP2_EP_HDMI0 {
 		remote-endpoint = <&hdmi_in_vp0>;
 	};
 };
+
+&rknn_core_0 {
+	npu-supply = <&vdd_npu_s0>;
+	status = "okay";
+};
+
+&rknn_mmu_0 {
+	status = "okay";
+};
-- 
2.43.0

