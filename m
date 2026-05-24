Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED14431A56C
	for <linux-pm@vger.kernel.org>; Sun, 24 May 2026 19:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779652192; cv=none; b=m7iIwevGLeAmjVVKK0wLUPgcwFx7VW3+rCCJwMN4KkWDj0kCGZKsWa5n0dAruudfEvK15b0d0gvViBMxNxIwVgbyzi+BqLnk5usi8o/sBgwKhq+3bEooF4x7T70YxAKqrWTQQNkhrtNm+C8jd1F5guRAdyKHA+LLqmXI7ZJHM4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779652192; c=relaxed/simple;
	bh=BIGk9NUVoNDrOtt6d4N1Uq4IdfPUi7mT/rywQ2ssYKo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fclWz/0UdIJrHAml6Em61tHvX4JQCIf0/fGjW3FD643luNVI0zpWKUMCrs+y5vwZRk/OMZ//kiH7WEEUTcCZYUBNOPkMeS0PsoMl2nCvxSEVnVnnmE90LaxyFJ1gVFuq6vzajxxEJeK2FUYcuRvyJgCpotaSW8iIct4issHTfd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f11KwDAH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DLzv2EHr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f11KwDAH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DLzv2EHr"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64OJ6gxH1510034
	for <linux-pm@vger.kernel.org>; Sun, 24 May 2026 19:49:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dn3fvC+mkNY1uNxo3o5q69xFB3+G2i+dm6Pos/3JyeU=; b=f11KwDAHJGu31tiS
	Kz8lwsS4BECL1KzQ55FgxdQ8k7m0zLCLf4XOcX3MMb8fQB8mNZirDkOvzAt5k3vY
	UGWbwn/v1ENp/5ZhRDEbElW4VxOnCoAS5y+hemT3XV0x9Z+gdUHbbYvBYnbXTk8U
	JlP7y3dv0yVzNQheJtJB8/qXtPsjrl65iRde+lHV+lAGkbGtMR6tA7HTC3VlcTwl
	DfQxmZXiPfunsiV4hMgh2rerqlkVlLd0MEg/lr2/l63Xq2wRWnP7tyKELiA5Y6Gv
	CowxyRcjq+Y0Sd+X3r6As/FdcNx0vODWxItItFiHUUlurB5TrjE4nFy5FuO80/JA
	g+G6Pw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb3jgv0kf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 24 May 2026 19:49:49 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-365ff2ab7beso9237431a91.1
        for <linux-pm@vger.kernel.org>; Sun, 24 May 2026 12:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779652189; x=1780256989; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dn3fvC+mkNY1uNxo3o5q69xFB3+G2i+dm6Pos/3JyeU=;
        b=DLzv2EHrmi9vfs+pNxxCCbSJs/VLnAXD5pVPeylO+nUrF0cFnhc265uc9sQUjiMNIY
         5Ej1CQ9nRqdXUREWlQUSFegIHt+oHQXLmwM+81DYdE0mJYIpd9lfKOgpM67Kovnp/D3h
         yGYG3+uTJF5xWFKvAkJJmBjMYJvK2rxmyMk1ybRoVgMU/m2Y0gOhWVqwLHIBwkwy5XU3
         u2jAKqYdBYT+2j6+4Be4kr+2MdlGQIs8wRtgi+C81rIxSE8mfg17Uc9Re6RudoMVUGw2
         uJYjrywxetBFkW7oGaq4MZ36tVU36eDkqk2iWqatJVfH6U8f47A8+yDLglk73AWjJWyw
         D1mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779652189; x=1780256989;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dn3fvC+mkNY1uNxo3o5q69xFB3+G2i+dm6Pos/3JyeU=;
        b=jSAIeyK8QHO5xFTi4Jcy+lll7jP6G1NJbCasDI1leRsjfcFk6mw0kNkLVgvCxoCO5y
         fzXJjSJt2iAGaxb01JReAxjb0QGYgAkpi189hnUJY/v8uHgxNwnlogSU5yzvGlsq1NmC
         ACjUw60gL+7S8kiEmWK/Ivh8oOcOarQAquqtZ5rAoTNKFP1oaxLwcCHw180L6kv1G8i+
         3iiRIUl/HecPHEYgwbyIHcgUWO9rEzMsgN4EZytlShvfzyWsUJDiCMiP3IOErkRr8TYL
         vCL9GuF9effeKo2zfL2uwunNyqFZrZlFtcR0UOOmJqKp54o1PwFkwoqXmZYszLiX++xU
         NDqQ==
X-Forwarded-Encrypted: i=1; AFNElJ+ukDKXhfSoyk7HDcs0MEdAUzzu+9FoMxuGAXIpfvfjNfl7HdbwSWBstTvPRMNtwZeo+4Zwyc+vog==@vger.kernel.org
X-Gm-Message-State: AOJu0YzD4ncrpkJMwbU5ezN0VXedMLcEobzt3JA/ReUboVwOWR5NDO8z
	KnhjRkJmwVh9K4Rko/KojkXk+jOp6zEFDzK5rlxKJkO5uvti6RPw+tCUpuOVhBDv7s5M4tgbYfe
	QWlVqYw0BfT1hU/I0Ys2O/GGSOOxLR/h5zTjai6AkqxMnZnuzAwZG5G2+InMS0g==
X-Gm-Gg: Acq92OEciqRuAsptS4g0icwOOB5ufmDDRn5WuPfm91reODEfEeaY6jJWn1E9m228dZu
	k8XKZtROkiY48KY1Bit4g/OLV+yhsQL1/SwjcdvnTxSReboF6SiYhmZQ1mG3ELlu4zffJON9NYu
	xAUnchl45h7P9QFa1VsaWN1c7KLg1jUxAMUTGGe4qiOfFzV+wT6bq/4C5Q9m90h6yRAG1DZDEQO
	B64d8i+mcknUjz+Nz2BbaXByIkpWSbjjo5dxl/itnQBMhKdLoiigWNV3UmB6Kd/wlKVdyxHc1qy
	qV77sS7NywsPevQGS9D8bUGgQH5ESU6PhcVOQd7/Srea67sbbWXZB0bJ3TWLXpFK4w4x6oGNm77
	T9ECEm6n6Ms4z3pD2dbTkPX2FBt9mP4JMyt9T
X-Received: by 2002:a17:90b:3eca:b0:368:864:62ad with SMTP id 98e67ed59e1d1-36a473cf321mr13318574a91.3.1779652188966;
        Sun, 24 May 2026 12:49:48 -0700 (PDT)
X-Received: by 2002:a17:90b:3eca:b0:368:864:62ad with SMTP id 98e67ed59e1d1-36a473cf321mr13318546a91.3.1779652188436;
        Sun, 24 May 2026 12:49:48 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a6c21d4a2sm4725849a91.1.2026.05.24.12.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 12:49:48 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Mon, 25 May 2026 01:19:08 +0530
Subject: [PATCH 04/16] arm64: dts: qcom: shikra: Add cpufreq scaling node
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-shikra-dt-m1-v1-4-f51a9838dbaa@oss.qualcomm.com>
References: <20260525-shikra-dt-m1-v1-0-f51a9838dbaa@oss.qualcomm.com>
In-Reply-To: <20260525-shikra-dt-m1-v1-0-f51a9838dbaa@oss.qualcomm.com>
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
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Aastha Pandey <aastha.pandey@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779652157; l=2418;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=x7oSC/QDcnnpqyvWDCndMCwGFZzXKEB/9qcjR+Qs73g=;
 b=HxZsJ/jHJslnVtlepsro7vs9WMcGY5uPTKgq44vIO85LdheKILFcNryAySnY0r2+UCs/LiR1c
 s7sw0PW3rBOCD9AeBLh0vzGROv8XydUBSXVMDKjw8OJyiXlg2UnNVpz
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-GUID: FoNg1jmpYchToC8H4W8J03l8QT93aFBg
X-Proofpoint-ORIG-GUID: FoNg1jmpYchToC8H4W8J03l8QT93aFBg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI0MDE5OCBTYWx0ZWRfXwf5ebjcfEw7K
 51K276ehn/u0lJ1khEaPaz2/lqnV51mDzxlaeyVrPLKvJoY2ZRZ9hlOzqyKll1ZEZB89iNUD0+3
 bckysmhXMNNWEKX7QKz8VqyGN7byrCmRnDjFJrXmj149K+S/vZn7Rn2Zf90CB9cK1UDUCNsc7Nd
 XKx4olyh15MXLIuyE5lDu/WiTjWSSAZunIhbNWpu4jbkDm29D774SlJpnShesZXbQePYyqtyndt
 Bxh8pgkzY1MKPVh9+JqOD0wFqvtlZfTax+B7zZU9y1E1dzFQT9FZbPg/FmRBVlhUQE3xnnu7iQh
 dTBUSGlkHx8jPKh9GQQYSlqAHHkoN7EWUxgq93CUaGnpmyiZlInRYSIYaWzUJYgAr9SBarjJu9Y
 q5JkZsy1R+WTKyquvxTTCKCqcfvHDHhtE3O5PY2FpYoP3VaVmYUyIQgGb6sU8TaaCgbfOHR0Fh5
 IomarK0X22dzKM1d/tA==
X-Authority-Analysis: v=2.4 cv=Do9mPm/+ c=1 sm=1 tr=0 ts=6a13565d cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=sEM7OkBMBn96DhIRBF8A:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-24_06,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605240198

From: Imran Shaik <imran.shaik@oss.qualcomm.com>

Add cpufreq-hw node to support cpufreq scaling on Qualcomm Shikra SoCs.

Co-developed-by: Aastha Pandey <aastha.pandey@oss.qualcomm.com>
Signed-off-by: Aastha Pandey <aastha.pandey@oss.qualcomm.com>
Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra.dtsi | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index 2751b4f89678..35ab7072e20a 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -44,6 +44,9 @@ cpu0: cpu@0 {
 			next-level-cache = <&l3>;
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <100>;
+			clocks = <&cpufreq_hw 0>;
+			qcom,freq-domain = <&cpufreq_hw 0>;
+			#cooling-cells = <2>;
 		};
 
 		cpu1: cpu@100 {
@@ -54,6 +57,9 @@ cpu1: cpu@100 {
 			next-level-cache = <&l3>;
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <100>;
+			clocks = <&cpufreq_hw 0>;
+			qcom,freq-domain = <&cpufreq_hw 0>;
+			#cooling-cells = <2>;
 		};
 
 		cpu2: cpu@200 {
@@ -64,6 +70,9 @@ cpu2: cpu@200 {
 			next-level-cache = <&l3>;
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <100>;
+			clocks = <&cpufreq_hw 0>;
+			qcom,freq-domain = <&cpufreq_hw 0>;
+			#cooling-cells = <2>;
 		};
 
 		cpu3: cpu@300 {
@@ -74,6 +83,9 @@ cpu3: cpu@300 {
 			next-level-cache = <&l2_3>;
 			capacity-dmips-mhz = <1946>;
 			dynamic-power-coefficient = <489>;
+			clocks = <&cpufreq_hw 1>;
+			qcom,freq-domain = <&cpufreq_hw 1>;
+			#cooling-cells = <2>;
 
 			l2_3: l2-cache {
 				compatible = "cache";
@@ -1780,6 +1792,25 @@ frame@f42d000 {
 				status = "disabled";
 			};
 		};
+
+		cpufreq_hw: cpufreq@fd91000 {
+			compatible = "qcom,shikra-epss";
+			reg = <0x0 0x0fd91000 0x0 0x1000>,
+			      <0x0 0x0fd92000 0x0 0x1000>;
+			reg-names = "freq-domain0",
+				    "freq-domain1";
+
+			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>, <&gcc GPLL0>;
+			clock-names = "xo", "alternate";
+
+			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH 0>;
+			interrupt-names = "dcvsh-irq-0",
+					  "dcvsh-irq-1";
+
+			#freq-domain-cells = <1>;
+			#clock-cells = <1>;
+		};
 	};
 
 	timer {

-- 
2.34.1

