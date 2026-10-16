Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E30937EFE9;
	Fri, 16 Oct 2026 06:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792131246; cv=none; b=TqxPlXxJmmmJfg4AmcyZJse9h6AZ8KAlPs/q7C276Ld/3RzvGjqyxPznRrA8rL+B8MhmNR2XBtf7FttfvxnIUTkSFxvV3PSSfhHmXWpl2YeLSiyZcSncgyfF5FRfjCOk6etm69Gzo4K8L7Rg/F0KtJ3LpgVSSSYQoOKf2xRWtm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792131246; c=relaxed/simple;
	bh=k0vJjnS4rETWnQ5pNP37eJT3M6UD9yPU/yzPqyBRbmw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n5keLo7Pd5v4uo7RmZvGD+sTGxjHfyaZmgNjiKriqubypCBkd2+niDVhaNe9uEPZCN+l2fPYAFGBPAaK2pe2EF+fysa2UXLZPhy1/to4cqHc1w2GtNsGmjhxers4JMdDRuKdK80BlUIzhdp9VHfE83jIyWKKSHcTXR3FXLMPi5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GD4KDcjT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GD4KDcjT"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 41048C2BCFC;
	Fri, 16 Oct 2026 06:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792131246;
	bh=k0vJjnS4rETWnQ5pNP37eJT3M6UD9yPU/yzPqyBRbmw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=GD4KDcjTxitjAWuLfQc1qKUlOyTMe8eEIXUja4DlA4EGqtn8zhvGmyrM82hiQ8sZt
	 84tEeUJ9Gba61RvC/g2eSB0H47exDHVcGwjsiMdQCVtoYVIv+mLSxJaFQFwHyIi7E8
	 O2bNZSu7Q+6y8AZwfbn17CZbPO5oe54pPruTgQCwrst76KRsQhw/GHkq9R7BlPpczM
	 wL/4phZcoM/pFY8kfjCrplm0nFJGoM3j9dj8/FjXbnl29K4cxwuph+iJADUScP+buO
	 Te4Sk24ibPVPVG+Q/w5+gkXk48aGdd3wv/fhhw4L1TgGMh7f4R2P13ozy5YuJzSF+g
	 +d2oPqnu/Qfqw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30914CC6B38;
	Fri, 16 Oct 2026 06:14:06 +0000 (UTC)
From: Demeter Barna via B4 Relay <devnull+me.fromdisposition.org@kernel.org>
Date: Fri, 16 Oct 2026 06:13:52 +0000
Subject: [PATCH 2/2] arm64: dts: qcom: sm8350: Add CPU and LLCC BWMON
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-sm8350-bwmon-v1-2-562fe403bf6b@fromdisposition.org>
References: <20261016-sm8350-bwmon-v1-0-562fe403bf6b@fromdisposition.org>
In-Reply-To: <20261016-sm8350-bwmon-v1-0-562fe403bf6b@fromdisposition.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Demeter Barna <me@fromdisposition.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792131248; l=2940;
 i=me@fromdisposition.org; s=20261012; h=from:subject:message-id;
 bh=nXdAocuEjzj92zdGAtIocuJPoJLdBGkW1hoCnioia2M=;
 b=9EgzFOHoBhmQbprXtUAp+sta5mjcoBmCMdWLdxXjmtRYAjSsRJf1Y9chit2BlcctUBCHI1OeP
 +ow0C6vlsBlBvY8LWcpmdgY56vlY56JLg342bJ4OAELDHdVFWafkp+1
X-Developer-Key: i=me@fromdisposition.org; a=ed25519;
 pk=S0QFlGq1BQEaAtPPdAH8YKEOXMeRuSkTgctXuvtU+1Y=
X-Endpoint-Received: by B4 Relay for me@fromdisposition.org/20261012 with
 auth_id=1163
X-Original-From: Demeter Barna <me@fromdisposition.org>
Reply-To: me@fromdisposition.org

From: Demeter Barna <me@fromdisposition.org>

Add the CPU-to-LLCC and LLCC-to-DDR bandwidth monitors, so that the
interconnect votes follow the measured memory traffic.

The levels are those of the downstream llcc-bw-opp-table and
ddr-bw-opp-table. Downstream limits two DDR levels (5161 and 8136 MB/s)
to LPDDR4X; leave them out, as was done for SM8250.

Assisted-by: LLM
Signed-off-by: Demeter Barna <me@fromdisposition.org>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 100 +++++++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 55b32050ce9c..6335c7809d17 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -2476,6 +2476,106 @@ usb_2_qmpphy: phy@88eb000 {
 				      "phy_phy";
 		};
 
+		pmu@9091000 {
+			compatible = "qcom,sm8350-llcc-bwmon", "qcom,sc7280-llcc-bwmon";
+			reg = <0 0x09091000 0 0x1000>;
+			interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
+			interconnects = <&mc_virt MASTER_LLCC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ACTIVE_ONLY>;
+
+			operating-points-v2 = <&llcc_bwmon_opp_table>;
+
+			llcc_bwmon_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-0 {
+					opp-peak-kBps = <762000>;
+				};
+
+				opp-1 {
+					opp-peak-kBps = <1720000>;
+				};
+
+				opp-2 {
+					opp-peak-kBps = <2086000>;
+				};
+
+				opp-3 {
+					opp-peak-kBps = <2597000>;
+				};
+
+				opp-4 {
+					opp-peak-kBps = <2929000>;
+				};
+
+				opp-5 {
+					opp-peak-kBps = <3879000>;
+				};
+
+				opp-6 {
+					opp-peak-kBps = <5931000>;
+				};
+
+				opp-7 {
+					opp-peak-kBps = <6515000>;
+				};
+
+				opp-8 {
+					opp-peak-kBps = <7980000>;
+				};
+
+				opp-9 {
+					opp-peak-kBps = <10437000>;
+				};
+
+				opp-10 {
+					opp-peak-kBps = <12191000>;
+				};
+			};
+		};
+
+		pmu@90b6400 {
+			compatible = "qcom,sm8350-cpu-bwmon", "qcom,sdm845-bwmon";
+			reg = <0 0x090b6400 0 0x600>;
+			interrupts = <GIC_SPI 581 IRQ_TYPE_LEVEL_HIGH>;
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &gem_noc SLAVE_LLCC QCOM_ICC_TAG_ACTIVE_ONLY>;
+
+			operating-points-v2 = <&cpu_bwmon_opp_table>;
+
+			cpu_bwmon_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-0 {
+					opp-peak-kBps = <2288000>;
+				};
+
+				opp-1 {
+					opp-peak-kBps = <4577000>;
+				};
+
+				opp-2 {
+					opp-peak-kBps = <7110000>;
+				};
+
+				opp-3 {
+					opp-peak-kBps = <9155000>;
+				};
+
+				opp-4 {
+					opp-peak-kBps = <12298000>;
+				};
+
+				opp-5 {
+					opp-peak-kBps = <14236000>;
+				};
+
+				opp-6 {
+					opp-peak-kBps = <15258000>;
+				};
+			};
+		};
+
 		dc_noc: interconnect@90c0000 {
 			compatible = "qcom,sm8350-dc-noc";
 			reg = <0 0x090c0000 0 0x4200>;

-- 
2.53.0


