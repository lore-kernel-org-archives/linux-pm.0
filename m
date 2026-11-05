Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793884085;
	b=Il0LdE97kUVeB+9f7bM/pUEKK4+kYks8g7WTGfUwkQ3CMSPcp6RYdZoECrh2Am0sC390
	 dEqui1IV1J3kgiU2xIvmhFHg2z1TViYqlE9BkDhraRTlxHDR9mxu8ugTQXyS2mVLvb+rR
	 jCGgfoQOgDJlRPcC7jp2bCxAoejTJl0dwD2VO/acro8kwsb/728MoWs5bt/xV+bY19Flr
	 Va+ncfV79GPBhmLVVYMXAPugbrRVJghqHiei6le/I53XOqq9fpykkDyVW3IhxRnBHkvZ7
	 uYTj4PnrT0RNdctEh2MUyV++0jkRHz4Whe1Ir30UunVLWuQ4JyE7Y5LbzSrNN0FzdMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793884085;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=qGXbSeZlkSz4Cin5h1fvK5nVxqBe3jrdrGrRDjDWmYs=;
	b=5CdlidgdkDtMMDnUArop8Xys4wDBJCp5vEs1zE8h1BHyRCs8vKUOvGxCVHYCijFglKNt
	 JeLxMcYyDreCE9P1xvCbC6g3/JQJ5QidnoSMNXZohY1d/50G0ZqDPbZtHv20Llzq52NUS
	 DmcnF0yuiagmbI3oq5yZ6thlO581pM/q1MzHBSXUPWA8/B6V25Q07mXaHYAjBKfHd6aa9
	 GfH+udM2wpjMZ7KHg2E+0uwvUR8ItJu6bTi4ssevyXc+OBcP9CCvgEiO3bimzfoBJM0SA
	 MCVPHGI64HEXXNyAPhEMWFsjwtDRjfplPCkZEC/O2Z55jjBgoPgrPDYYsEf6xZ2Q9jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=f2Xx8w7s;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bB+dvqV2;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1591606EE9F
	for <linux-pm@vger.kernel.org>; Thu,  5 Nov 2026 13:08:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1591606EE9F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=f2Xx8w7s;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bB+dvqV2
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A59tFv5082957
	for <linux-pm@vger.kernel.org>; Thu, 5 Nov 2026 13:08:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qGXbSeZlkSz4Cin5h1fvK5nVxqBe3jrdrGrRDjDWmYs=; b=f2Xx8w7s3yMUKtuF
	IvYhi2RQTzagLYMaqzVa2WnLKnzbYJ+pCUvBQL0UeSziQmcEp+dEWf3WIdDPiumV
	9itzRHLAZNA7wcenN9XD7YcLQMKznGih+FvNUILXUfvXyczJzrOVbnGNC4F7660W
	ugKDI7WSMZIiFcyEtQdbvv6P/FDd/DCLIZMhsNqsGzgg47bqPF7hUx+3DhGeaq2w
	R5AMfiTNc7WaeDafHP86mLPEPUfBwDFoaGHaAoflCelulEtSsFObBk7qMrlc3die
	mqvE6fIgqHyiQcJMx9SD+S+tvnIh8LgaFf0l8LtXxPpwo4BaYVf0aktPeLqTpkx4
	K95S4Q==
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com [74.125.224.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrq1p0wtf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 05 Nov 2026 13:08:03 +0000 (GMT)
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-67bdee091feso2459684d50.3
        for <linux-pm@vger.kernel.org>; Thu, 05 Nov 2026 05:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793884083; x=1794488883; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qGXbSeZlkSz4Cin5h1fvK5nVxqBe3jrdrGrRDjDWmYs=;
        b=bB+dvqV2NXnlZvco1aHuMzn57IqQ8KQ7XxASNn+6tLDbeDmzwIfyPz18pYwddOWH6Y
         1gFXfmpxJQalVLejXhVmuNhmeebz3VrQaNSpdwQylOKYHQPigOPkViwq/4rE7Ab64995
         IwjDNxim2seUyYzHZFjs/nhbS9I0QukaA4+AklE9dMvnOXqd8s5f6c26sdQ46crDxzCc
         EtySKfdsDnNGYHr4nmEEpb8isCRzB4Za3cLDrZ6G2OmFpLFlojyWUCIqbWMhag/kM5uZ
         FcFktBXMhsq2M35/9JZMRVSqm7SPqYWVQsgEyEQOk3olaVEW7kradsrJIG0u2DoJ0XHc
         ERTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793884083; x=1794488883;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qGXbSeZlkSz4Cin5h1fvK5nVxqBe3jrdrGrRDjDWmYs=;
        b=1zN13yDdw/Vzz54oDX8Wy8KIjRcuDK8YEjD4mt07lIQjRYHJRuNYhnTtVYzF3ELzJk
         OP5M9Cr3uCYTwaIdt+dfjA292YYmFUFMgzbvxQf2REo0jeZMp5M/DT6Wm3wrjDUr/vg4
         RCSuyM1SuWWe3gNCKtOhzkQ8eL5uZtLXr+9y3ufTV47NBXu+yqCtn/tUxD4IiyIkc7pH
         dE5q03pQIdb5+N+iDUjPl4POqO9KHLj83DlvI+aBaRz+Px1hSwlOMzIw43x9wd6+9gQ/
         DEalvjhoDdk3e4H08q2QAySik5KZJIuDFakbC5UoWVjmnGOFnYviJNtJbs13/sohSBIo
         Q3jg==
X-Forwarded-Encrypted: i=1; AKwUvByKWPeHsQ4eYIWDZks+npqvb+3x/YJKK4+D29tsRlXGxkvEGZvu8/LFhC7LZw3O1JxRJRLFiIjiZA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+KR5NNvbXXir+sbt45w78tPr1KKX1rglh/fD1XnlZW1upqyWTk
	VNuVu0Kmes640msQ5nKDJoINEkxqwU3eC84/CKCUkPLT0E3r7DaHDofr158KswuMcDEqWTrxfFh
	AorrwneVS8fpvhRotL+xQ/OkaXDN5sE/Oh08+ztsh8KtdWV9qdIL+mQlfkPpCZA==
X-Gm-Gg: AYBFou0XsLuoREuUZKJVZZBvEwbfR+47rq6d/pr4ZKe4AGz6RtU342BHm0dwiltoMWK
	3dfr0W+1zOv35sDZdv0xDtDfZnEl4jzpJN8RHgyMj0pYXLJO3YopFGrkL+r9t4QuB3TousFJrfI
	DPUvO7+zweRAfkoX2w673dQzDwg5LL6CwH+m5MPIta2XrKMnA6h7c95U6SV/47/4PGpedGtxXWm
	VHs2kWQ61Zh9X1hseJrsS2BlvG/yD90PBGQOAvqvuwQNrWGZO0gjsaUANJWyzUUgM26cFCr4Cgg
	OeVIyRBQMN4cm7K7UjgKUqMGOyZ7frgwleDlk68tppbzzZZCHDgDXVLZoaTGTL5142W9+J1cfP/
	qaX98tfLFp8lEwZYmXoSEN+gGtZ2zWtw5GGE8s3KGqUNeCLq4caU6hDgDcPgwe+Qa5XTlf/mEjI
	kWBqPjQAKi7DsZ31p4
X-Received: by 2002:a05:690e:108a:10b0:676:86cc:c3ba with SMTP id 956f58d0204a3-67ba4f54b7fmr6712608d50.68.1793884083003;
        Thu, 05 Nov 2026 05:08:03 -0800 (PST)
X-Received: by 2002:a05:690e:108a:10b0:676:86cc:c3ba with SMTP id 956f58d0204a3-67ba4f54b7fmr6712590d50.68.1793884082464;
        Thu, 05 Nov 2026 05:08:02 -0800 (PST)
Received: from hu-luoj-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b309bb4406sm38915937b3.40.2026.11.05.05.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 05:08:01 -0800 (PST)
From: Luo Jie <jie.luo@oss.qualcomm.com>
Date: Thu, 05 Nov 2026 05:07:15 -0800
Subject: [PATCH 4/5] arm64: dts: qcom: Update IPQ5210 xo_board to use fixed
 factor clock
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-qcom_ipq5210_nsscc-v1-4-d4fcb5c32b51@oss.qualcomm.com>
References: <20261105-qcom_ipq5210_nsscc-v1-0-d4fcb5c32b51@oss.qualcomm.com>
In-Reply-To: <20261105-qcom_ipq5210_nsscc-v1-0-d4fcb5c32b51@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Richard Cochran <richardcochran@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, netdev@vger.kernel.org,
        quic_kkumarcs@quicinc.com, quic_linchen@quicinc.com,
        quic_leiwei@quicinc.com, Luo Jie <jie.luo@oss.qualcomm.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793884066; l=1379;
 i=jie.luo@oss.qualcomm.com; s=20251128; h=from:subject:message-id;
 bh=5TarJGRML2ryvcb/ClCF+1MotlwLtOVZ//s8pIACGiY=;
 b=3mqRC4X34pzKkW88rrjp6qxCP7hp3Ti8ZBVcdSCHjWbioQuMLytsd7ZQFXH9LJDd254AKeU1X
 UORE1rhCVcsCm8iT4fKvmQPNiXsSy4KDI90CKFvid0gAkha3KqfZvpp
X-Developer-Key: i=jie.luo@oss.qualcomm.com; a=ed25519;
 pk=gSsYMDakxtd6UDFYDdA9y9yjIs5Etp5GK/3DoXWPyS0=
X-Authority-Analysis: v=2.4 cv=AaYkjHXG c=1 sm=1 tr=0 ts=6aec7fb3 cx=c_pps
 a=S/uc88zpIJVNbziUnJ6G4Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=oqiXH2A-fwTjus5yMdMA:9 a=QEXdDO2ut3YA:10
 a=nd2WpGr1bMy9NW-iytEl:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA1MiBTYWx0ZWRfX5luMP6P8V+Gk
 DrG/VmEyVZQCh2bPwiVzZ9Mrwxg0vNENvMd8xtXRprahbNyBTsUfD7Cx8xG7l2mQ36u03ivvLfI
 agWXavH86eipIxRFnjC9e8n7rW+fiKt60+thU+KCq7TBiBIgkcCGGswJdmFfRGMvwE83XXL+ixL
 ExcJfP/ouZdwWqeV03dNElY1pNbmMTicGsLY+guFldIJ59YB18nicyGNFHv+ohVb3nM7MV5D/7y
 vrhIpsbsRitFf7frbeSOY7Zcv+lzPi9lXDIk/9Fp7vjJImGKnc6tXfSHHh3AVn/2xxYdHBulwQO
 o17PKAYAOVHztJQGmve0wzlqizRrGJJ7389pskYPQaUZVG+FWQInUZIhvDBS28P8UmfWrImdNOV
 lV13kL0t3PqC01+aanH5i7bSCkhqkN2gM7m9NDNEICTvwILIE2a9YJ5mJgO7rLaopHLZm/RKWXZ
 1JHAnRAdQ/aviUL1LjQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA1MiBTYWx0ZWRfXwqglBT31qP64
 g0SUCgYUxCZZ59oQSfkWcdXBga9q7oOnbZ7rwb4cec3vAF3sOYEhdBWXOib4VXndLkctkdQwG7W
 T/ZpKF1jctoY2hdTFvpybNj6VXmj92M=
X-Proofpoint-ORIG-GUID: zo-aAopXu2k9lyZmcGtg033RCs4j_iN8
X-Proofpoint-GUID: zo-aAopXu2k9lyZmcGtg033RCs4j_iN8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 suspectscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050052

xo_board is fixed to 24 MHz, which is routed from WiFi output clock
48 MHz (also being the reference clock of CMN PLL) divided 2 by analog
block routing channel.

Signed-off-by: Luo Jie <jie.luo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/ipq5210-rdp504.dts | 7 ++++++-
 arch/arm64/boot/dts/qcom/ipq5210.dtsi       | 3 ++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq5210-rdp504.dts b/arch/arm64/boot/dts/qcom/ipq5210-rdp504.dts
index 61a53361138b..519307c6b61e 100644
--- a/arch/arm64/boot/dts/qcom/ipq5210-rdp504.dts
+++ b/arch/arm64/boot/dts/qcom/ipq5210-rdp504.dts
@@ -85,8 +85,13 @@ &uart1 {
 	status = "okay";
 };
 
+/*
+ * The frequency of xo_board is fixed to 24 MHz, which is routed
+ * from WiFi output clock 48 MHz divided by 2.
+ */
 &xo_board {
-	clock-frequency = <24000000>;
+	clock-div = <2>;
+	clock-mult = <1>;
 };
 
 &xo_clk {
diff --git a/arch/arm64/boot/dts/qcom/ipq5210.dtsi b/arch/arm64/boot/dts/qcom/ipq5210.dtsi
index 52d851a0dc2b..0c1ede0f73b2 100644
--- a/arch/arm64/boot/dts/qcom/ipq5210.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5210.dtsi
@@ -26,7 +26,8 @@ sleep_clk: sleep-clk {
 		};
 
 		xo_board: xo-board-clk {
-			compatible = "fixed-clock";
+			compatible = "fixed-factor-clock";
+			clocks = <&xo_clk>;
 			#clock-cells = <0>;
 		};
 

-- 
2.43.0

