Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E05F396590
	for <linux-pm@vger.kernel.org>; Sat, 13 Jun 2026 06:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781333926; cv=none; b=Sch2p2kTq9731X+8vR1kUcQIhPG8n5bgsD3v/kWQVLlRIP3QIvvOw1255jhfH7Fl4PP3NC5HDaoNlfE66MwnVFQgSMwlsc/EHpenzMkmHTMbKijESCU8JDG2m/jLk/Yb7qD6dO9WfNy9ZBV4FsYg3HloK0V3ep4YzjWmcMV94aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781333926; c=relaxed/simple;
	bh=zamBZHvXT+SrkZYZqomb0TPLxTZiVMFSO+6rV6o1c+s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RHh15gKsKQqKEcgL5fKuPmHN/ybOLpx0S9lCqvzjaK8+ig1hzGXCKX4VBnJLrpDLMkHSP0odOGNu3ER6i+5/RBDHf1BBpRnykSfk6/eAluDoj64gwAWowmCf4qTjUYU3LlxpCd6B4SFP0DokR6x39JCwL9ykiqZO4XR5AP/bXyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E+pqKl3r; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+pqKl3r"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-490b64c8311so17694655e9.3
        for <linux-pm@vger.kernel.org>; Fri, 12 Jun 2026 23:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781333921; x=1781938721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ExjVQvO4/iWqbTjsUJjExpq/Pad0yGuPxgZEv8g/Xlo=;
        b=E+pqKl3rIT9k60v9M78O5W038+7/3FkhnidutvlLT2NignySnGVjWStw6hXsYISClt
         QzwI9jVigAxaLaAL0JQZ/wL4C4QIty+GSays1YWxaYmjxe0qMArxkXqB0e4ckz+rrRXi
         KnmaDSID2K3/mVVDa3mAdC81RBmrbVZaZhUnd5zTN2iwd3jtlLCd6FeBdb75by0dXg/5
         bD8fekeMWaQe9gXIYVyPzVFr7cH+LwwjEFMb+4qePW8OU21SBeX6fTO7nZ+slnkK/2+J
         Dzk0fo0sRywr17XGM2EL2G6uRlB3x5N28Up46nSHvypH2ope45QlHgc3Z18Omhgjvc3l
         LLhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781333921; x=1781938721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ExjVQvO4/iWqbTjsUJjExpq/Pad0yGuPxgZEv8g/Xlo=;
        b=qEdOZ+c7udn7DPGKPUHEfHTh2wD1GPB4bSRottwpOnZ4W/1Res3MfS5m0/b8Zk4niQ
         gwrTx0OrFhLVKYU3jHt9Rl8Vjc7DTvKOrwWEqG3pek07QBJhLloKhO4RSIk56C0/g5pn
         5FytVKx0McllcTE2Icl1r5j5ueq1PNeW1YuBrh17vAsxXoiyuhiosSZDax+xIU1LUOLQ
         Dslw4jqNNs0H6419yT/dDyMP06Dq+UsNqf+BandZXtPUd76qSOi/McQL3NdiEYljFnBk
         6bUScoMehbSuC+rEbztoKtUQpmlXOq+qMU0OdjOBRraiIpyauWDsqSykuAfPdzVBHd0f
         RO4w==
X-Forwarded-Encrypted: i=1; AFNElJ/na8NpBXiiHT699wZxsuGR7yxvUbQmWv8wJl+hsz/ZWnfDXoYjqkS1F1sEF4dSMTzLCI+cMepdjQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp5QnSMlzkglyHG71R1Lx0qVRiy957lUXbd5wnmkB1pcB5hdBh
	Nu4AobFkXfS2LTa0W8pGRJlLcpD+ggxsZ7gGZp6EJ/0PYP3gQ3B9fkbu
X-Gm-Gg: Acq92OHvZqXoCOHcO0dLL4DrZZAFi2bPtIYWTNT5HjzOfIssghIdsTfRIu0LjcPxYWc
	9EX/AvmcwNIE7kRvnAy7SQ7mw7hWlcfhN/i5AD+GNOUTUs0b5M2bnL07f978lsgAn53I8j/wOvT
	eFS5x66GnRLvBbhyRx52DV9Jru0SxLRhKRVltO/GAF8S1Avexnkfk77pljqq1kbtTk8GWE8Apeh
	RyFU79E/Hy043PL27d7qC3Zyve7piT3d0EGcxkcErcNakTs+zk/uNeTG0Xna5jnb0c009BIwcs9
	2vJgxddbVVXl6SDGEX3c9qgGe/2xfHU9cYQmDZJi3XynVy0TiJtsSpLNmqD+lqzzlkWjxhj/5YM
	JkzRBpzhvvniUfWwGxURpEcQ/PXRxy/UlmfABqk0VnyUq0C61I2it0kPzSYO/bb56P/olZQ2ZJX
	KDcrn4xwngNrowKB773NYhdpOc4r6v/wBOlA8IkV1Dhg==
X-Received: by 2002:a05:600c:a47:b0:490:52c0:744c with SMTP id 5b1f17b1804b1-490ec4ee63cmr73748795e9.20.1781333920798;
        Fri, 12 Jun 2026 23:58:40 -0700 (PDT)
Received: from debian.tailb81abf.ts.net ([2a01:e0a:104a:4d80:14c0:9448:1c38:77df])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492202e5cbasm42917705e9.2.2026.06.12.23.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 23:58:40 -0700 (PDT)
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
Subject: [RFC PATCH v4 7/9] arm64: dts: rockchip: rk356x: Add the NPU and its IOMMU
Date: Sat, 13 Jun 2026 09:01:14 +0200
Message-Id: <20260613070116.438906-8-midgy971@gmail.com>
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

The RK3568 has an NVDLA-derived NPU at fde40000 with its own IOMMU at
fde4b000. Add both nodes (disabled by default) and the NPU power-domain
child under the PMU power-controller, and point rockchip,pmu at the PMU
syscon that controls the NPU NoC bus-idle.

Besides the SCMI compute clock, assign the CRU CLK_NPU so the NPU AXI
bus clock comes up at 200 MHz rather than the 12 MHz boot default.

The power-domain deliberately carries no pm_qos: qos_npu sits behind the
NPU NoC, which is gated until the NPU is brought up, so a genpd power-off
QoS save would fault reading it.

Signed-off-by: Midgy BALON <midgy971@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk356x-base.dtsi | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi b/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
index 64bdd8b7754b5..313db59c1aed8 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
@@ -512,6 +512,13 @@ power-domain@RK3568_PD_GPU {
 				#power-domain-cells = <0>;
 			};
 
+			pd_npu: power-domain@RK3568_PD_NPU {
+				reg = <RK3568_PD_NPU>;
+				clocks = <&cru ACLK_NPU_PRE>,
+					 <&cru HCLK_NPU_PRE>;
+				#power-domain-cells = <0>;
+			};
+
 			/* These power domains are grouped by VD_LOGIC */
 			power-domain@RK3568_PD_VI {
 				reg = <RK3568_PD_VI>;
@@ -572,6 +579,37 @@ power-domain@RK3568_PD_RKVENC {
 		};
 	};
 
+	rknn_core_0: npu@fde40000 {
+		compatible = "rockchip,rk3568-rknn-core";
+		reg = <0x0 0xfde40000 0x0 0x1000>,
+		      <0x0 0xfde41000 0x0 0x1000>,
+		      <0x0 0xfde43000 0x0 0x1000>;
+		reg-names = "pc", "cna", "core";
+		interrupts = <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru ACLK_NPU>, <&cru HCLK_NPU>,
+			 <&scmi_clk SCMI_CLK_NPU>, <&cru PCLK_NPU_PRE>;
+		clock-names = "aclk", "hclk", "npu", "pclk";
+		assigned-clocks = <&scmi_clk SCMI_CLK_NPU>, <&cru CLK_NPU>;
+		assigned-clock-rates = <200000000>, <600000000>;
+		resets = <&cru SRST_A_NPU>, <&cru SRST_H_NPU>;
+		reset-names = "srst_a", "srst_h";
+		power-domains = <&power RK3568_PD_NPU>;
+		rockchip,pmu = <&pmu>;
+		iommus = <&rknn_mmu_0>;
+		status = "disabled";
+	};
+
+	rknn_mmu_0: iommu@fde4b000 {
+		compatible = "rockchip,iommu";
+		reg = <0x0 0xfde4b000 0x0 0x40>;
+		interrupts = <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>;
+		clock-names = "aclk", "iface";
+		clocks = <&cru ACLK_NPU>, <&cru HCLK_NPU>;
+		power-domains = <&power RK3568_PD_NPU>;
+		#iommu-cells = <0>;
+		status = "disabled";
+	};
+
 	gpu: gpu@fde60000 {
 		compatible = "rockchip,rk3568-mali", "arm,mali-bifrost";
 		reg = <0x0 0xfde60000 0x0 0x4000>;
-- 
2.39.5

