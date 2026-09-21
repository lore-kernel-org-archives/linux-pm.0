Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFF850AC09;
	Mon, 21 Sep 2026 21:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790025310; cv=none; b=twjcAA3eUCrR4fML7se7AGNvdJVmRkhtDMxhiJTArmbvEK8ghkxobHl+I8pHWGvMEXB4xCAurLtZs3V7iwQhb125nS+eq09OYmEJZPMlIY0na5MgysY7ZLBXKee8FebWmGW8BPDKEYwpct5kMz3byMbOumcB7T/equyyMz196wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790025310; c=relaxed/simple;
	bh=vMgJeIbDY4gfZKXLLhtV9STSMmBqMwbwlOznf1gK9P0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b6p++J9U5PCgHPtA9jSfgoYiD3tfebjQbpminzExhiUGZKwDYVGoxFZrVZuZ4IilDuHFNBiMrq5EWyR0XTvs9IIGSxAyVm/rp/CDRoSLczld7ZGNPTjMGGt0T/yPQV2wFoATATQsGRKq5Rz+ypzm8ylvHhAkKqvlS3XGQEloSD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=jNt2o1Vv; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="jNt2o1Vv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1790025306;
	bh=vMgJeIbDY4gfZKXLLhtV9STSMmBqMwbwlOznf1gK9P0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jNt2o1Vv2tCeQC9rWc00B2bqwZZ/kf4tWo3IY1HbX/LFLQebwc17Q+XepLSvHQdse
	 PHaCwKDWNmXNZQWAVc77F9m6RgDXRJhKqz4/la9rHtJ1wESHql0+MFijwxbGJ/fdN7
	 EznEdejbA1s8mGCRH92b3t+Yides6Xhgfu9oDZfoV+qZtKkaWCrCtnulE14SoDVOvB
	 aq0qbi2rhdQ8rfKVLGYfiZi40W51kQ1o7dHscVtU77MT6/zIxq2m28FS2fCu7uycZy
	 SLPZ5Q7PrBoDpHNK3BlnDqysxO99le9aBUqCMx3GxkUkHK0O0ElS/f+bg9wIOlHxdp
	 0YjxW2RZMJCpQ==
Received: from jupiter.universe (unknown [100.64.1.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9F86C17E0FB7;
	Mon, 21 Sep 2026 23:15:06 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 57969480031; Mon, 21 Sep 2026 23:15:06 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Mon, 21 Sep 2026 23:15:06 +0200
Subject: [PATCH v2 4/7] arm64: dts: rockchip: add DFI node to RK3576
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-b4-rockchip-dfi-rk3576-support-v2-4-04f847016321@collabora.com>
References: <20260921-b4-rockchip-dfi-rk3576-support-v2-0-04f847016321@collabora.com>
In-Reply-To: <20260921-b4-rockchip-dfi-rk3576-support-v2-0-04f847016321@collabora.com>
To: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Chanwoo Choi <cw00.choi@samsung.com>, 
 MyungJoo Ham <myungjoo.ham@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 kernel@collabora.com, Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1234;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=TXuERcBa3lyF5yru0hC/lwhYh6FDQ895W7w6eKt3Ed8=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGqxnlpTaK1WGqKIfj9CyRu3SmbzDFOtQ6RwR
 YukDdKpAZ+MVYkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJqsZ5aAAoJENju1/PI
 O/qamHAP+QFSPWUF/svr4wGcxpuH0VlMAAlQlbFJWZcGUcZ5xAm8BdROICo4LJn6dRaAX8R2kMH
 DjVu7op1Clee0V73X7xIRj3YvFNjIlyw+1azKWgBVtAmFxtU7jEgaEHSbDG8cz7OoLvq/KOufTQ
 I87FKKtVeuorKkHZLFlz/Vcnq5tmflbTTsGcdSGv1NrUVqzjSjm6sJHr6v1M/UKhJUV2NN3GA+2
 yohSXJjzo1pPKCrNyKSgvUYUsJdAhGbeATdxeGqSJK1lK5EJi+vFKidm2lVSehBE7xk5ZzIO07Z
 aNqlxQPler0buSrcRnN7sbbwUDCQ2x6DJqmPT4/anXLSsDLp68SJlyCo27KfU3b+6GaZzg1x/eK
 5/2CkFEPpPLvwreQx7B1COB3qyPh3KvNgNlZ6R395i6qOu1PnJvD31W+ahvt84jYIy8Sa27I47x
 aJTbgqWBtn9+LE1Cg44YLdFWF9ljxY4VWcfqjqcAL8JJjWL5EZEsuDOR1nXsHAbk58SQWRWuUTF
 GF5uZcu/9lws51cvaQTWC1U8txSnNBXrDF2TrtRlKwMeWYE5Y2RQwwsix3b3yCDQWzMpfhKZeWZ
 9q9TpHrw/Fryk0IUiOvWC2b4s9t5hJ4HSCm4UljJ/o9cI8P9HxNnNF9rUl1HWTfCzPes2oMwQno
 FeWPRWKWb+Ff2QJL7vAwxaw==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

Like previous Rockchip SoCs RK3576 has DFI hardware to measure DDR
bandwidth utilisation. Add the node for it to the SoC's DT.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3576.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576.dtsi b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
index b0c0d3c8b1b1..197b8c3b76b4 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
@@ -1832,6 +1832,17 @@ qos_npu_m1ro: qos@27f22100 {
 			reg = <0x0 0x27f22100 0x0 0x20>;
 		};
 
+		dfi: dfi@2a000000 {
+			compatible = "rockchip,rk3576-dfi";
+			reg = <0x0 0x2a000000 0x0 0x20000>;
+			clocks = <&cru PCLK_DDR_MON_CH0>,
+				 <&cru PCLK_DDR_MON_CH1>;
+			clock-names = "pclk_ddr_mon_ch0", "pclk_ddr_mon_ch1";
+			interrupts = <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 233 IRQ_TYPE_LEVEL_HIGH>;
+			rockchip,pmu = <&pmu1_grf>;
+		};
+
 		gmac0: ethernet@2a220000 {
 			compatible = "rockchip,rk3576-gmac", "snps,dwmac-4.20a";
 			reg = <0x0 0x2a220000 0x0 0x10000>;

-- 
2.53.0

