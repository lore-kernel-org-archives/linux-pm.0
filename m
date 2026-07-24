Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5080F421257
	for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 10:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784888082; cv=none; b=fjhmXH6T8xPo8h2sXEH5egZmi3xzvTrsVuugOuaaF8GP2891i9vFnOs1px0DqpFQDpE6kuu9ODV+pJVY801e6n1POgIXZIgYCJha/XhauXXkuSxmmCBhv41li21jmvvYYTchtcnS50B4nnyGq7C6Rhgs2ULP7E9HpfMlYrsr54w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784888082; c=relaxed/simple;
	bh=+DLG9qcyUgwzvSyAJXIEFOR5biL+OffkBbsNb2FLaPQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UJpA5atF9eDmb9IhYsDEEHsO1NSlbIZo87Z8cDTKU19kZNbPbkduf4CtgZF0onB6H/CD/V8qO+ktR4lHDGUkIfIvB0B9Pvepz9dlfBdPexjjDzP6TtHo68lGw3lUQz+u6xs1KO/owl4rjY+f7h3XsN769D/7puojr1izMj/9mJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GbcLrGBy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fQudZZyb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GbcLrGBy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fQudZZyb"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66OADwhZ2742726
	for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 10:14:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	owz9GHEUOfqCkUnJifN/Kj4c7LuavhIMaFFfbdF4YJI=; b=GbcLrGByESg9q+Jl
	Tx+xNgOGT7O/x5xMDBRrZAsgAo/nH0XuYYFP6d+ApsP/Jt0c0gFbSu1yKwPe9f+o
	fl9hwpi+TN4IuOgpr8RsIpnas8Yf+zaaE4jRekDfIXk/R4W2fGz+58em1we9ai1C
	/Kn5zfbLGkOUiCSKX2wtwsPausGNqeor4acfMk4Mg6Mp8UXWlak+D2WEcORbijPB
	bsaaB0/ZgcG5AXPIFoWoR1DVrcjgHHqqzoeXrGKN+/jAX5VrGghM/EfBpi0KU29M
	TWdROIcCoc1kYXHTjBG9Y4ilbVxxJjQHxNPF3cDX7fnrLHX29NuEWtI6yk3rJ7FN
	Ys1Eqw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fm0p519mc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 10:14:40 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cccfa32670so4161395ad.2
        for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 03:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784888079; x=1785492879; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=owz9GHEUOfqCkUnJifN/Kj4c7LuavhIMaFFfbdF4YJI=;
        b=fQudZZyb0C/JkLQA8z0O05/YhSuydkG4WuwioTT/2gDuL7nQZAbLVoMRpGQ6BDxP3D
         I5EZgJ9M/i10xRAtCuN1J7Mpy5AfgWP4unl83AW4VE5FsB6Dr51pgvXH8BWSylF7VeWm
         ECpC+YoEpRwueD78wMCLze+8R+j2AP3yIkhHvoWj+s3jIV5Q9eR2MC4/7LQG4G12W+vP
         POw6w7yrJsplEaMBgi/a1H1eNHDGHILMjkZdYAa2B/RXxp/m+lBFk43j/on9veZXfMj4
         A0fy/H6avoWH3I6iS98qKS2BdyvmWKHN5hehpr0xtYh4RxMZNgomPNdvaoul9a8jpUT0
         bqIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784888079; x=1785492879;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=owz9GHEUOfqCkUnJifN/Kj4c7LuavhIMaFFfbdF4YJI=;
        b=c6cXzRDmbDTTJkLnVWC7V/TqtACkdDpi3SAZDXPL9JDplI6fIX/IV7iMcpYWBIsLWQ
         BWpY91TAEx0W4sbYmQAEqX7L6aBLIZUqrj6ASzTtIqdKYhFwlFtRq0Yzv00JtPSLiThF
         9GMp5FvxljCIOSPfwieIlazxF8CKv9LDZsCuYGJkbAweeUA/4nNjA7Z/5HuqK3wnxs+3
         42G1lQnTCVtFADYuYTFfYuYwPVfdkktwPNGoswzJd64H4TXZsFJkhVVZcXUjaGS3HZIc
         4DxjBp32frpYWMWmXUAKJ6tWbsWvmc45S09Bh8eyKsjD55SU+oKWXDm27NQpBZdUZKL7
         cnIw==
X-Gm-Message-State: AOJu0YwcqpfhkWOSSXsJW4Zt0ZeqnFS33EPwo88uOPrHRwFSEOswHAVo
	jyXViHkhM8sWm64wW45sWtsduUgGf6uDUxfzLF6ereRnTsmQIAje9gTUZ/5JNlh0MzPWaOv7Ew8
	Btfk6/48ZEebCZHCZxv28Dfzf3QBdaiPzqGt3vKNz0KFyFBAPgb8Giuqag3Jp
X-Gm-Gg: AR+sD10zfdUF+LTerbS8Dt92JBwXjvA2hcqncvqd751FnrOTDbeyys/maMOhY5m68X2
	vzOeDJt47iSR2YYDmPmqPENAG6b6KODFlPRq29QPK9lKGyzIbbDElXBX1JYDucgtAgnALtd6m7x
	GhSre2kjo4Rc9E4bHhq07P02VJvuvucFEHahDxD+ucgr5t/kdmd/FyE8C1IY5Nm0OXyNMuU22Yr
	a0SPFMvp/hyMeJB4K4lgZp1KmGzc0KJm00jLOqqqUp6CUjGPez8bzcIFSLi0vwhRKoiEFJnvf1j
	m6jthYmvGeJWPwKUrKyLXMH7d9tPVf1bCMFOP2hMMpn2AKnnR+QuVlsNIYYJv7Rfp+9OpGqAJbA
	Vl2NyFRREKhv3vY/PfmEY1t+FZ4qGFQ==
X-Received: by 2002:a17:902:f709:b0:2cf:b330:e0e8 with SMTP id d9443c01a7336-2cfb330e151mr49854185ad.10.1784888079215;
        Fri, 24 Jul 2026 03:14:39 -0700 (PDT)
X-Received: by 2002:a17:902:f709:b0:2cf:b330:e0e8 with SMTP id d9443c01a7336-2cfb330e151mr49853915ad.10.1784888078820;
        Fri, 24 Jul 2026 03:14:38 -0700 (PDT)
Received: from hu-kotarake-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8f31f14csm48486575ad.63.2026.07.24.03.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 03:14:38 -0700 (PDT)
From: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
Date: Fri, 24 Jul 2026 15:44:13 +0530
Subject: [PATCH v6 3/3] arm64: dts: qcom: monaco-pmics: Add PON power key
 and reset inputs
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-b4-add_pwrkey_and_resin-v6-3-41acc214d93a@oss.qualcomm.com>
References: <20260724-b4-add_pwrkey_and_resin-v6-0-41acc214d93a@oss.qualcomm.com>
In-Reply-To: <20260724-b4-add_pwrkey_and_resin-v6-0-41acc214d93a@oss.qualcomm.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Rakesh Kota <rakesh.kota@oss.qualcomm.com>,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784888058; l=1614;
 i=rakesh.kota@oss.qualcomm.com; s=20250919; h=from:subject:message-id;
 bh=+DLG9qcyUgwzvSyAJXIEFOR5biL+OffkBbsNb2FLaPQ=;
 b=mHE23l/I/hfbcybrBtTJMrbVqMqusxmSm0T9DB2ajaV6smgNAF/ZLn+aQ5my5HDb0cwbBCYlJ
 Tc7LHdak0TgANNctHsnEnaEtyyYj4+6tm34LE3Yq65EytZMssFHLaz/
X-Developer-Key: i=rakesh.kota@oss.qualcomm.com; a=ed25519;
 pk=dFhv9yPC8egZglsSLDMls08cOvZKZkG6QQn1a/ofwNU=
X-Authority-Analysis: v=2.4 cv=Pq6jqQM3 c=1 sm=1 tr=0 ts=6a633b10 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=f3aK1VMAgMfWcFvZUCoA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: jTAjqF0X86XaJNpwFpBp-BvJobm4NwcX
X-Proofpoint-ORIG-GUID: jTAjqF0X86XaJNpwFpBp-BvJobm4NwcX
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA5MyBTYWx0ZWRfX9Q7ZKC5I7/9z
 izt9FUeAMYQT8i/FouT7E1eyQnNW74zfdYUGxXNp8dVT10FfXMKdaNkXysyCwrKTPPqq7nDM7aL
 rK6bQ8LPicE98RIEbozvClmYduLYDWU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA5MyBTYWx0ZWRfX5LPTqBW9/Kx2
 6gJULtU1B7M79YQMaNLjF/2vSpIzWeid36E2YWVxin+wJt+10JTToThW5Fm2pbqo3mvvDZHGnBX
 RLCgmZRCvi6B4UUC8jm8IyHtdNrowXO5YEWsDM+cW1rOGh8edun55wKIvmY6gOn1zsoaX2VDi21
 zCiiCMPey+T11O2zyNAL/tM+Qcx2miUEWjsU/837XP6Qw1Z7CFDAVYCnsefGy3aK1NvUIoxBsed
 P7AxsiAQdO7hZzH9iIZSggRp0lH9XofsSFwGgwrH2hzxi/rFy3U/uKRxZ+gFn1yDPmgLr5cblgX
 Wuw75OVV/4U0yT14RHdi9tDf0kPdTdeR9FZc4SNRTGafArIB55TdJ4rFTw1O1xQWiK9RirU7VE+
 PfF4tm7It7V/kk9eTLVTKBGYyMFZUk/9IfRLZx536wQRxfLYsREJgSEhn9eFAZ7pEYDEPMrdZ4K
 NiV2k0zOzXu1lCSRxYg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_02,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 lowpriorityscore=0 adultscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240093

Add the Power On (PON) peripheral with power key and reset input
support for the PMM8654AU PMIC on Monaco platforms.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
---
Changes in v3:
 - Disable the resin as suggested by the Konrad.

Changes in v2:
 - Add new PMM8654AU compatible strings as suggested by the Konrad.
---
 arch/arm64/boot/dts/qcom/monaco-pmics.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/monaco-pmics.dtsi b/arch/arm64/boot/dts/qcom/monaco-pmics.dtsi
index e990d7367719..af4c38309efa 100644
--- a/arch/arm64/boot/dts/qcom/monaco-pmics.dtsi
+++ b/arch/arm64/boot/dts/qcom/monaco-pmics.dtsi
@@ -13,6 +13,26 @@ pmm8620au_0: pmic@0 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		pmm8654au_0_pon: pon@1200 {
+			compatible = "qcom,pmm8654au-pon", "qcom,pmk8350-pon";
+			reg = <0x1200>, <0x800>;
+			reg-names = "hlos", "pbs";
+
+			pmm8654au_0_pon_pwrkey: pwrkey {
+				compatible = "qcom,pmm8654au-pwrkey", "qcom,pmk8350-pwrkey";
+				interrupts-extended = <&spmi_bus 0x0 0x12 0x7 IRQ_TYPE_EDGE_BOTH>;
+				linux,code = <KEY_POWER>;
+				debounce = <15625>;
+			};
+
+			pmm8654au_0_pon_resin: resin {
+				compatible = "qcom,pmm8654au-resin", "qcom,pmk8350-resin";
+				interrupts-extended = <&spmi_bus 0x0 0x12 0x6 IRQ_TYPE_EDGE_BOTH>;
+				debounce = <15625>;
+				status = "disabled";
+			};
+		};
+
 		pmm8620au_0_rtc: rtc@6100 {
 			compatible = "qcom,pmk8350-rtc";
 			reg = <0x6100>, <0x6200>;

-- 
2.34.1

