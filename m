Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3099E4E5332;
	Wed, 14 Oct 2026 12:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791980559; cv=none; b=D83ePCDVLEIoRSpehMQwotyk7rw6crleJ3AFKgTd1zZpqoH2h2KcHLveP0USZfOMp6KksTo9q6NkGYDKRMByAzwisST4H9eczn0AcEdi4yLNeEfoHo8FQkE2D4ZVRkeeeiCXYsLP9VH5+iTrgv3inMy4+ncIkdNVWGnf0Tk6dRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791980559; c=relaxed/simple;
	bh=gLdl4NyPhx3iE61bFk6URcG2ftDR3r1iqlZ/wKg3810=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lHw42H3jAjWqRZiIuBj2meb9zqh8+fBzKRzHLsUrtoaWpUs+kc9OwtT8CqkUySmka3SRKsDUjWyM62kYMFwNWJKmDctDR55QLe9y+9RA0Y+cnsD3T6hg9DzjKU2uJ9oUOe9Lm9SKc3QTamSnPkU5As9bEYlTVeF3egou4sZXd/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iv++WLCy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iv++WLCy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F2661F00893;
	Wed, 14 Oct 2026 12:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791980557;
	bh=3GblhorFS5zw9HSV4hQVMrFH0axWGqmUxMy23umvQsw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Iv++WLCypzMRJ6WREN7UHP5GQlffl13j6KSZC8ULTBRC/Gf6hFVXbAAhP6zBKhHV5
	 A8ItzMWNhd+wTgqDjXcZgyXNGynin4P+kF7JacgGWHPsXcaCk1HtpGTGMn5lEW01rK
	 iv1olFlUSNzNX1ke5/QXhD4hWU5cqZ4b3Hr51YwhBE0Vbs5dkZQ6AuiWkQF3LwOb/r
	 5J3A8+xnIGHd58kxQmJwa+Oi7cIqm6WhyIN8KS5IMqfEO+Vgdz1HB1HFYmrSnMeWsw
	 gt859NlLsL6gZD07Ve/OLvO4Hgjb3OBUI6ybjiS/66tzoytnGH+a41lIOOcz4TCU1v
	 XAyqmIKxLkJ7w==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Wed, 14 Oct 2026 14:19:15 +0200
Subject: [PATCH DNM RFC 15/16] arm64: dts: qcom: sm8650: Drop required-opps
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-topic-qc_clk_dvfs-v1-15-3041b788e9f7@oss.qualcomm.com>
References: <20261014-topic-qc_clk_dvfs-v1-0-3041b788e9f7@oss.qualcomm.com>
In-Reply-To: <20261014-topic-qc_clk_dvfs-v1-0-3041b788e9f7@oss.qualcomm.com>
To: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Viresh Kumar <vireshk@kernel.org>, 
 Nishanth Menon <nm@ti.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>, 
 Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Abel Vesa <abelvesa@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Mike Tipton <mike.tipton@oss.qualcomm.com>, 
 Taniya Das <taniya.das@oss.qualcomm.com>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, driver-core@lists.linux.dev, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791980431; l=8074;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=25KFHDcVRFbVrsQERlgz3TTX9OaGkKb/JBVGDijpsAU=;
 b=8mX5Y+PS9dSwaThXhIFZfBP0ifggWywSLVfeZ9ivuo9ruBrefhOaVMsKoeDqL7cYgXX0lqUP2
 3ZztaH/xjGBC+NTfEYOmXnZOuHDSQigX3yYTcEJTIyYpUWGhaXzgIl+
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Now that the clock controllers take care of their power requirements,
drop the required-opps that were only there because they previously
hadn't.

Assisted-by: LLM
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
DFS clocks (for QUPs) are left out for now, as they need some more
code changes.
---
 arch/arm64/boot/dts/qcom/sm8650.dtsi | 46 ------------------------------------
 1 file changed, 46 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index 0847cfb35954..47d7be98128e 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -3717,7 +3717,6 @@ pcie0_opp_table: opp-table {
 				/* 2.5 GT/s x1 */
 				opp-2500000-1 {
 					opp-hz = /bits/ 64 <2500000>;
-					required-opps = <&rpmhpd_opp_low_svs>;
 					opp-peak-kBps = <250000 1>;
 					opp-level = <1>;
 				};
@@ -3725,7 +3724,6 @@ opp-2500000-1 {
 				/* 2.5 GT/s x2 */
 				opp-5000000-1 {
 					opp-hz = /bits/ 64 <5000000>;
-					required-opps = <&rpmhpd_opp_low_svs>;
 					opp-peak-kBps = <500000 1>;
 					opp-level = <1>;
 				};
@@ -3733,7 +3731,6 @@ opp-5000000-1 {
 				/* 5 GT/s x1 */
 				opp-5000000-2 {
 					opp-hz = /bits/ 64 <5000000>;
-					required-opps = <&rpmhpd_opp_low_svs>;
 					opp-peak-kBps = <500000 1>;
 					opp-level = <2>;
 				};
@@ -3741,7 +3738,6 @@ opp-5000000-2 {
 				/* 5 GT/s x2 */
 				opp-10000000-2 {
 					opp-hz = /bits/ 64 <10000000>;
-					required-opps = <&rpmhpd_opp_low_svs>;
 					opp-peak-kBps = <1000000 1>;
 					opp-level = <2>;
 				};
@@ -3749,7 +3745,6 @@ opp-10000000-2 {
 				/* 8 GT/s x1 */
 				opp-8000000-3 {
 					opp-hz = /bits/ 64 <8000000>;
-					required-opps = <&rpmhpd_opp_nom>;
 					opp-peak-kBps = <984500 1>;
 					opp-level = <3>;
 				};
@@ -3757,7 +3752,6 @@ opp-8000000-3 {
 				/* 8 GT/s x2 */
 				opp-16000000-3 {
 					opp-hz = /bits/ 64 <16000000>;
-					required-opps = <&rpmhpd_opp_nom>;
 					opp-peak-kBps = <1969000 1>;
 					opp-level = <3>;
 				};
@@ -3909,7 +3903,6 @@ pcie1_opp_table: opp-table {
 				/* 2.5 GT/s x1 */
 				opp-2500000-1 {
 					opp-hz = /bits/ 64 <2500000>;
-					required-opps = <&rpmhpd_opp_low_svs>;
 					opp-peak-kBps = <250000 1>;
 					opp-level = <1>;
 				};
@@ -3917,7 +3910,6 @@ opp-2500000-1 {
 				/* 2.5 GT/s x2 */
 				opp-5000000-1 {
 					opp-hz = /bits/ 64 <5000000>;
-					required-opps = <&rpmhpd_opp_low_svs>;
 					opp-peak-kBps = <500000 1>;
 					opp-level = <1>;
 				};
@@ -3925,7 +3917,6 @@ opp-5000000-1 {
 				/* 5 GT/s x1 */
 				opp-5000000-2 {
 					opp-hz = /bits/ 64 <5000000>;
-					required-opps = <&rpmhpd_opp_low_svs>;
 					opp-peak-kBps = <500000 1>;
 					opp-level = <2>;
 				};
@@ -3933,7 +3924,6 @@ opp-5000000-2 {
 				/* 5 GT/s x2 */
 				opp-10000000-2 {
 					opp-hz = /bits/ 64 <10000000>;
-					required-opps = <&rpmhpd_opp_low_svs>;
 					opp-peak-kBps = <1000000 1>;
 					opp-level = <2>;
 				};
@@ -3941,7 +3931,6 @@ opp-10000000-2 {
 				/* 8 GT/s x1 */
 				opp-8000000-3 {
 					opp-hz = /bits/ 64 <8000000>;
-					required-opps = <&rpmhpd_opp_nom>;
 					opp-peak-kBps = <984500 1>;
 					opp-level = <3>;
 				};
@@ -3949,7 +3938,6 @@ opp-8000000-3 {
 				/* 8 GT/s x2 */
 				opp-16000000-3 {
 					opp-hz = /bits/ 64 <16000000>;
-					required-opps = <&rpmhpd_opp_nom>;
 					opp-peak-kBps = <1969000 1>;
 					opp-level = <3>;
 				};
@@ -3957,7 +3945,6 @@ opp-16000000-3 {
 				/* 16 GT/s x1 */
 				opp-16000000-4 {
 					opp-hz = /bits/ 64 <16000000>;
-					required-opps = <&rpmhpd_opp_nom>;
 					opp-peak-kBps = <1969000 1>;
 					opp-level = <4>;
 				};
@@ -3965,7 +3952,6 @@ opp-16000000-4 {
 				/* 16 GT/s x2 */
 				opp-32000000-4 {
 					opp-hz = /bits/ 64 <32000000>;
-					required-opps = <&rpmhpd_opp_nom>;
 					opp-peak-kBps = <3938000 1>;
 					opp-level = <4>;
 				};
@@ -4073,7 +4059,6 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
 					     "cpu-ufs";
 
 			power-domains = <&gcc UFS_PHY_GDSC>;
-			required-opps = <&rpmhpd_opp_nom>;
 
 			operating-points-v2 = <&ufs_opp_table>;
 
@@ -4103,7 +4088,6 @@ opp-100000000 {
 						 /bits/ 64 <0>,
 						 /bits/ 64 <0>,
 						 /bits/ 64 <0>;
-					required-opps = <&rpmhpd_opp_low_svs>;
 				};
 
 				opp-201500000 {
@@ -4115,7 +4099,6 @@ opp-201500000 {
 						 /bits/ 64 <0>,
 						 /bits/ 64 <0>,
 						 /bits/ 64 <0>;
-					required-opps = <&rpmhpd_opp_svs>;
 				};
 
 				opp-403000000 {
@@ -4127,7 +4110,6 @@ opp-403000000 {
 						 /bits/ 64 <0>,
 						 /bits/ 64 <0>,
 						 /bits/ 64 <0>;
-					required-opps = <&rpmhpd_opp_nom>;
 				};
 			};
 		};
@@ -5057,22 +5039,18 @@ sdhc2_opp_table: opp-table {
 
 				opp-19200000 {
 					opp-hz = /bits/ 64 <19200000>;
-					required-opps = <&rpmhpd_opp_min_svs>;
 				};
 
 				opp-50000000 {
 					opp-hz = /bits/ 64 <50000000>;
-					required-opps = <&rpmhpd_opp_low_svs>;
 				};
 
 				opp-100000000 {
 					opp-hz = /bits/ 64 <100000000>;
-					required-opps = <&rpmhpd_opp_svs>;
 				};
 
 				opp-202000000 {
 					opp-hz = /bits/ 64 <202000000>;
-					required-opps = <&rpmhpd_opp_svs_l1>;
 				};
 			};
 		};
@@ -5200,7 +5178,6 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
 			iommus = <&apps_smmu 0x40 0>;
 
 			power-domains = <&gcc USB30_PRIM_GDSC>;
-			required-opps = <&rpmhpd_opp_nom>;
 
 			snps,hird-threshold = /bits/ 8 <0x0>;
 			snps,usb2-gadget-lpm-disable;
@@ -5296,38 +5273,26 @@ iris_opp_table: opp-table {
 
 				opp-196000000 {
 					opp-hz = /bits/ 64 <196000000>;
-					required-opps = <&rpmhpd_opp_low_svs_d1>,
-							<&rpmhpd_opp_low_svs_d1>;
 				};
 
 				opp-300000000 {
 					opp-hz = /bits/ 64 <300000000>;
-					required-opps = <&rpmhpd_opp_svs>,
-							<&rpmhpd_opp_low_svs>;
 				};
 
 				opp-380000000 {
 					opp-hz = /bits/ 64 <380000000>;
-					required-opps = <&rpmhpd_opp_svs_l1>,
-							<&rpmhpd_opp_svs>;
 				};
 
 				opp-435000000 {
 					opp-hz = /bits/ 64 <435000000>;
-					required-opps = <&rpmhpd_opp_svs_l1>,
-							<&rpmhpd_opp_svs_l1>;
 				};
 
 				opp-480000000 {
 					opp-hz = /bits/ 64 <480000000>;
-					required-opps = <&rpmhpd_opp_svs_l1>,
-							<&rpmhpd_opp_nom>;
 				};
 
 				opp-533333334 {
 					opp-hz = /bits/ 64 <533333334>;
-					required-opps = <&rpmhpd_opp_svs_l1>,
-							<&rpmhpd_opp_turbo>;
 				};
 			};
 		};
@@ -5745,22 +5710,18 @@ mdp_opp_table: opp-table {
 
 					opp-200000000 {
 						opp-hz = /bits/ 64 <200000000>;
-						required-opps = <&rpmhpd_opp_low_svs>;
 					};
 
 					opp-325000000 {
 						opp-hz = /bits/ 64 <325000000>;
-						required-opps = <&rpmhpd_opp_svs>;
 					};
 
 					opp-375000000 {
 						opp-hz = /bits/ 64 <375000000>;
-						required-opps = <&rpmhpd_opp_svs_l1>;
 					};
 
 					opp-514000000 {
 						opp-hz = /bits/ 64 <514000000>;
-						required-opps = <&rpmhpd_opp_nom>;
 					};
 				};
 			};
@@ -5827,17 +5788,14 @@ mdss_dsi_opp_table: opp-table {
 
 					opp-187500000 {
 						opp-hz = /bits/ 64 <187500000>;
-						required-opps = <&rpmhpd_opp_low_svs>;
 					};
 
 					opp-300000000 {
 						opp-hz = /bits/ 64 <300000000>;
-						required-opps = <&rpmhpd_opp_svs>;
 					};
 
 					opp-358000000 {
 						opp-hz = /bits/ 64 <358000000>;
-						required-opps = <&rpmhpd_opp_svs_l1>;
 					};
 				};
 			};
@@ -5991,22 +5949,18 @@ dp_opp_table: opp-table {
 
 					opp-162000000 {
 						opp-hz = /bits/ 64 <162000000>;
-						required-opps = <&rpmhpd_opp_low_svs_d1>;
 					};
 
 					opp-270000000 {
 						opp-hz = /bits/ 64 <270000000>;
-						required-opps = <&rpmhpd_opp_low_svs>;
 					};
 
 					opp-540000000 {
 						opp-hz = /bits/ 64 <540000000>;
-						required-opps = <&rpmhpd_opp_svs_l1>;
 					};
 
 					opp-810000000 {
 						opp-hz = /bits/ 64 <810000000>;
-						required-opps = <&rpmhpd_opp_nom>;
 					};
 				};
 

-- 
2.56.0

