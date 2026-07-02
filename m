Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F9047ECDE
	for <linux-pm@vger.kernel.org>; Thu,  2 Jul 2026 09:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782985873; cv=none; b=MqZfMvL6R/NeodsGWzACCQBVn+gddpKhqk6Dg8aa6T+4JqNumEEv2HulpA48l9InC/n7NPG8LgHpiwDjk4nRXe99TunEB/25N2Y1t3k8qX9Y7iWuP+iXT6OroncHkMJyrHhMJD+bAGS5nWTVHOH2LLM0q3pKpM3xxetTSn6ikio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782985873; c=relaxed/simple;
	bh=MG3sAgTxM2yS2k98bs7iCxw+/UEc3/K3gbnTW3sIzdo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W6tx56R3MNXUtb5ZhLMs1rPOd0IHzBpG7t0OBd88lKIp2Ki31ldVsBeQOTvLaY6NJ8g36OuKEgShtppvGxE3SXqC0eSfKlL6FBmclD7N8s595SUHoRGhALIUUp796AbJ3WvHC+wqp3lfDpLvgNKnDBoNEhHledjrBL1bnnDKabM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BmdhPhnQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=he1YoIv7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BmdhPhnQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="he1YoIv7"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6629nXAt4139672
	for <linux-pm@vger.kernel.org>; Thu, 2 Jul 2026 09:51:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	s+HSBk7qe7sm/8M8mPnhytls3w5+cC3ur32RaFcr0Zw=; b=BmdhPhnQusx/1XjK
	I5UvSa4b1T87XegwtC468GWx2FpAHaxBfJqgmSLY6XJbcmHLUP4Cxqm0ybfpl6jH
	fS5wWwOdh/YYqmiAxvo9Haeigt0wTk+H8xYuoZUTzAdjcygMDrK2V3m+ftA5BLnJ
	vmXGgq2/l3khI7h2QHpsIP5F7bz6pL6RTaNOiWN9t0vCMZFM+WcshMrKRJ7DdzqJ
	vuNy8K7n9orBQ8b3/vFXGLVM3abRb7Tf+PeRBMvUmCSDcCIKUSDp5XcWe6/OVhth
	JSJT6WhBFNtJzH5NyBv8FdKUMGrxqIURRcGu+BBM1FBfMgVIve0MCjxENggLuLY7
	igtOdA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5npr8093-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 02 Jul 2026 09:51:11 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8479cc04d8fso2530282b3a.2
        for <linux-pm@vger.kernel.org>; Thu, 02 Jul 2026 02:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782985871; x=1783590671; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s+HSBk7qe7sm/8M8mPnhytls3w5+cC3ur32RaFcr0Zw=;
        b=he1YoIv7EHv528NdSkvaVMbj8LNhLhKWoklwWr170cIVu5hjBNujvnMmfzVy8pKzRu
         Cp/324lnuzrNQk4BDlUuK5EQ2/ScIHpJAzXQAQNG6ZCyPqP8Kcy++1pLj5J/YjYCPRj7
         a0had4rPo+GrQocidLYkGunKYhEtPZ8qtQeRDLFnSSOIWlvFdekExJDqlvmlTpHZIef8
         HXBI3ZWzQ48N1gynIP5SKh3cs9sKVGnYyQHYXrDL1OSUGHRvjPCBKQYU3s1N6wrdve7J
         rqwBVANaTbGU2Oo79sifWhGtGeswE6uMZPdA9M88gt0e3Ot/kh2JpqpGalkb5hwPSgvp
         xeRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782985871; x=1783590671;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s+HSBk7qe7sm/8M8mPnhytls3w5+cC3ur32RaFcr0Zw=;
        b=I7zFwdymotvASgk0WDnn02iZa2fSLX+jxO0C5bpENyZED/fJExjGCrCdAf8q5U7dLS
         eLW62rvlKCfugOU/Bt9sEKtwQPrNYPyiwbbBfrlhxQnElNXp7+5GyVm3vJ/LHvRvlyO0
         WWVNzPCpZJheXJIxtbcfFdEz3fA3e6mrvnXsyH+R4H3PdGaHG4DsV0mgS24SVM2d115g
         5J0+5SvEQRkTy4Dcx5gTKx0UtJUr6b1560lPqrrBLKvH7+HCXBUVMOXWxKgcB/04SDaY
         7eScqO/ZYrLqI3FBxdawHnADBozAOc5AJ/d89g0ogkwV68AB4FwEF4FklO/hDI0YC4BW
         nZZg==
X-Forwarded-Encrypted: i=1; AHgh+Roa8m2ZLpiyLGXUcIrP+UEM8NyZIbTkvFUD838qlLoQ+KTI1ZiUJfF2u8ULvDYeUdc9CAUGeUrocg==@vger.kernel.org
X-Gm-Message-State: AOJu0YybUGxMZJO9zHIhiAmsetZWEcLKKB2i3zj/cLkqDU/AK0Acf7NP
	Hp+WGYIuyalr4gxwwVg0uihB5G1lB8twTmlOo7nfGLcXwmqxrmpDdEovrrI1nsXoNNI3s0jh+s2
	t14I3VIqzhjBl3KW6V6qmVufuv1Y0IX0Z/bsXfWAUEpk2rc3ueVdBKVyc6204OQ==
X-Gm-Gg: AfdE7cnUh1q9S7suo6UoKdSeOs0rgzMPxcQGTxkoIqm3aT2ikIaaxunHy8gJQPaJ1pJ
	VRF85rNT2wz2qff7nCZZDEAkY2TCdCYiW5hUmF+EcOlKOyxyLZz2ZaIUhUIvUq41ynJAF3EzVuk
	bp/ztMGqQK9j+T2xJHrdGTC/n2QlHrTd8KfPAPmq8r1WoxTGwhOdCA3bdj3VF5rrSKDvlTzGMP+
	MAyXH2tVtWQxkA8aWEZTs3tQppTQd4da6LKh0TTaLnTZGoioc9FUklsgvp0ptJa6BdnmOp7zu6M
	TntPxr/dgf7OclUxujJwqFTNS+Obl0ZQDcwZB9FSLhvLRDm6y3PT8hp8rPKm84KwvpSAdeiQ6Q6
	qOVxh44q8+3EjEYWI2h02o5b0wQ==
X-Received: by 2002:a05:6a00:6ca7:b0:845:e0ee:29ec with SMTP id d2e1a72fcca58-847c096d0d7mr5173785b3a.35.1782985871156;
        Thu, 02 Jul 2026 02:51:11 -0700 (PDT)
X-Received: by 2002:a05:6a00:6ca7:b0:845:e0ee:29ec with SMTP id d2e1a72fcca58-847c096d0d7mr5173743b3a.35.1782985870246;
        Thu, 02 Jul 2026 02:51:10 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847cb78ee2esm1110051b3a.24.2026.07.02.02.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 02:51:09 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Thu, 02 Jul 2026 15:20:45 +0530
Subject: [PATCH v5 03/11] arm64: dts: qcom: shikra: Add DDR BWMON support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-shikra-dt-m1-v5-3-f911ac92720c@oss.qualcomm.com>
References: <20260702-shikra-dt-m1-v5-0-f911ac92720c@oss.qualcomm.com>
In-Reply-To: <20260702-shikra-dt-m1-v5-0-f911ac92720c@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Komal Bajaj <komal.bajaj@oss.qualcomm.com>,
        Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782985846; l=1830;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=FgXZj7vad2zgvA0RfnbjlrO8hgDk3pUjpoRSx0IOZh0=;
 b=t9FPDceZlfvNHbbzM0xKA4qbpZi1OETvyq/t2FF7ThWRzfT4PoB2mWMNrJFnS1zY6k5B14AHY
 AUua33tvB5sDpUPT/uzoDAfpTt1KKH9TkT8+23HepTkq37wyP5Cxw6s
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-ORIG-GUID: mOV0riMnr-0YloRvye7xi4ScqKeMZcy7
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDEwMSBTYWx0ZWRfX+XBDuE3gZ6la
 GrtJ2HulUlKaip6/5F8WJ4NQt45d2icg+yvwDXWn2eTrKljZXyU3J0qRED3Dhf/2qGxZrGkwJl2
 AWYx2C0XacKtmbdr5rwJD6RtZJ5FQow=
X-Authority-Analysis: v=2.4 cv=NsvhtcdJ c=1 sm=1 tr=0 ts=6a46348f cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=iYP2JlN40lpobhLRj-8A:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: mOV0riMnr-0YloRvye7xi4ScqKeMZcy7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDEwMSBTYWx0ZWRfX09sbuCUQ1JHf
 OOdPQliJ2tc5ic7t6425g5PA9GvQb4VvVnrhTSKp2dNiREk7aSvK3ieRPw9eXzVv1a6A9Nx8bCU
 98J9aJ3Y80pKKPR5BpD5c/jt79tphbj3B0vIRDqkXxs/vafMvHNHa72tqKdxBtztjgeX6Rk9phe
 ZGKSJ53zwvlaHsU8/e4N/wfZtAwKTxJ/OERewPtu2uQULfZTbmv1jIZ8x6zymoOOmNfZLbcpRZK
 ZSylzuLUx1Duw4DnFBQUNjwqQY1ioKV4oxqyylthz6LIZ0S/WXAeLVMyfqU8Zrt4RTakoMQ2w/5
 1ZuWDRoJJmrkEaicryvuCa9kGPFodw2ZOPwk2Pt5r+CCfMsSOiHzagK8d8o+16JTashVQKdBBcr
 ISJqPfNvgyN9BfOfWPUy5DrOc2h5TtpECCkVQmqaEGAeGGFSzybFUfD2fnVvgEh7wt89FIZQruM
 2P3z+1YMGlPnTxfezSQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0
 malwarescore=0 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020101

From: Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>

Add CPU-to-DDR BWMON nodes and their corresponding opp tables for
Shikra SoC. This is necessary to enable power management and optimize
system performance from the perspective of dynamically changing DDR
frequencies.

Signed-off-by: Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra.dtsi | 40 ++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index f0fb55b9deb9..d66b97dea319 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -661,6 +661,46 @@ rclk-pins {
 			};
 		};
 
+		pmu@c91000 {
+			compatible = "qcom,shikra-cpu-bwmon", "qcom,sc7280-llcc-bwmon";
+			reg = <0x0 0x00c91000 0x0 0x1000>;
+
+			interrupts = <GIC_SPI 468 IRQ_TYPE_LEVEL_HIGH 0>;
+
+			interconnects = <&mem_noc MASTER_AMPSS_M0 RPM_ACTIVE_TAG
+					 &mc_virt SLAVE_EBI_CH0 RPM_ACTIVE_TAG>;
+
+			operating-points-v2 = <&cpu_bwmon_opp_table>;
+
+			cpu_bwmon_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-0 {
+					opp-peak-kBps = <1200000>;
+				};
+
+				opp-1 {
+					opp-peak-kBps = <2188000>;
+				};
+
+				opp-2 {
+					opp-peak-kBps = <3072000>;
+				};
+
+				opp-3 {
+					opp-peak-kBps = <4068000>;
+				};
+
+				opp-4 {
+					opp-peak-kBps = <6220000>;
+				};
+
+				opp-5 {
+					opp-peak-kBps = <7216000>;
+				};
+			};
+		};
+
 		mem_noc: interconnect@d00000 {
 			compatible = "qcom,shikra-mem-noc-core";
 			reg = <0x0 0x00d00000 0x0 0x43080>;

-- 
2.34.1

