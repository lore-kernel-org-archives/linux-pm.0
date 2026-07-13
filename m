Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFAE35677E
	for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 19:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783971485; cv=none; b=oG3klo0Q4O26SULCJYbw+Rvs56VIn43ngS9tn/V01HAouAmn6OQ8x0dCqRa33Dv1m+W/tWlzRhlKSzfHoimMIAo0NPKhvjkMyDYbAAcFYqQKhpH96hgGSYN4xeZFO4hP8nAb77SlyV+hyh8X/OsZeW/Jc9Viq7jgDLRfvGrVQ18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783971485; c=relaxed/simple;
	bh=8/FpCKjXpnBa78fkZAMzVCGiZKnCnFSw8zBEtlMuGnI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nyoAWDuob0L1MJyT6c0xtTMj9JZwfzD3/UQrK8Pg3aDTH34FQfsQtCiP3e3m7pSSNNJ9Y5hqVKuZ+S1MiMhSOoXFmMBte/9uX+O4g57SBK4WoSG2aQkWjZ6w1k7e5aJcsyjfNie58Kq7OFexidbh0MeqifZH0ijqvQJud6lwvU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RykZlR/Z; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VgGjDVOZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RykZlR/Z";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VgGjDVOZ"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DJ9YwX2356001
	for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 19:38:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kYUmd6iz4TOryxUGtheeJBgCKVWvj2LRSWBQTL1u2gY=; b=RykZlR/Z/g5nzRpJ
	ARFs1+eEm12IZfeizVrhfnerWb3nbIcey7wRYhJNuEcoawndpjFqxjvBgg2MFvU9
	/CI8wCcQZn0L7NqSfsgDKMiPmg1QjQiC52c7QiHeIjrE3d9SpN9fHYay24gbWl5G
	kDKYO8yQmqhBb1FoPpIRXjpZzmXpUJM90a3QGWxmsuzDHoC2kmBewORnm1T22Pmr
	4mrF3Ipse/fPCGpuSzzMOTa8hSim94W257+fBlaWK5Qj0LfjQDRONA8zieu1E16j
	qvVM/QtvJnOCK4txEDGkSc32bE9+dz8MPP1LfenK4JegiUdMPWyWNJgCkCMow06p
	KVfm+A==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcwu4t9mv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 19:38:03 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3810960140eso3752477a91.2
        for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 12:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783971482; x=1784576282; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kYUmd6iz4TOryxUGtheeJBgCKVWvj2LRSWBQTL1u2gY=;
        b=VgGjDVOZjEQZ9hysgHOhHZa3zjxrtY+XDh0QyozX6Xox0U/69xypvcNjCKaGsALTao
         b1DasxeVyHiaagpUbuP9iC5A48VMNRbKHIJ84g0maQhHDD0A2MzLw0EUJrUc2GS4Lpl9
         aujyBJRZBegee/GohZGkAUOeMl1WmHjDg02fe9UtDXIsKHnJnLPGf9g97h6/3/IZyF00
         3ECZBKYAtJjGbIpuOQIWG0B5YeK1k05TqjPiGxXPtRHG9+hm7pHDedNPjFa26/rjGtba
         jlC266anQVv3mlbr+uuCoelODY3sAzxPdoMobTuzS7V62f9YjweVYNzrQyb3VxSwCEqM
         gwTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783971482; x=1784576282;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kYUmd6iz4TOryxUGtheeJBgCKVWvj2LRSWBQTL1u2gY=;
        b=r6R2ANdHPuU2ARsHK+wlVLmnUaeDmO5SpDLKUpS8vEgLBBWJb1dnMe7lK67BU6GAxK
         Gx0kSQMWLVPrCQnHrwFTeygmg1WUfMVFNECFI84Mhbe3p+dEbaHuPS9le6+HtxC2AG62
         S2fU6uX71K9uvTKgv//wdudg3+k54LtXle6Bp9Dc5BIRN8bWpR48zom/nZZ0w367M82N
         JoLaZ+CAskdcJZaXKQg3I1olnjpMVQlibUUZdqkdVA8usgB8KsyRURPQijHVSDr2hFw5
         +398DZtj9Bn4246luOH2F8V6G+oAeb/FtemBSyw//Tt9gwlCNVmtRN+ReOvGQ1zAwZHa
         9DKA==
X-Forwarded-Encrypted: i=1; AHgh+RpEDhhCAbVU/UbNur+H3yneehSna+ZCRyjsKPYCgutoEMrK569IiImS0W8NRf4wClUOSVPeWP0VjA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhu/gMfW7jc/o39Azsitbn9BcXNvOrWTNnwLvOba0qtZs32cOT
	tn/WjHkN+hCXgcPwNaNk1Ccp4fullx6ZPUEl9iCl4yeXcI3cWBBJnD+Oj1HdL1dzQrFdK6v27RC
	JVbHenh2oSTTmseSdNwj4XYvbOC+mxtYk9Af6OW/CExlDjUtB81q9j9irBm4tKg==
X-Gm-Gg: AfdE7cmYp6kGNlde+MqhzDQ30AFH+Jqw5lP5hUoxqxVsKlbwipzwGqUo0RsmHo8+BP/
	fYfPv6BRvu4msQ1n9x2ZbAbx8bsRpPLhh+De24wuiTPOfhVcanuqXCHKLyw9XZxRWKjcqaoDnCL
	8fUnxFBlQKefenAAw27DvvhbbyRGJ0nOsJLOZ1K+HbPzmPtEWaV1jysYHm5Nx6JMQlL2WzKIop0
	fbFjmYV5RtwssPmiJLWaQkKbjGwtZsY3u8a36gRLUpnQFcKXeSiaUEKyM030xicG+90pxIG+KXI
	m2FXJiQ6NpZcEQtvDZFVPwMZZRjZT/pBu9vXpqu9hj6nKQplFeW5YkeF74iTsARj7zJGcy7lHOu
	eJ46SZIqnAoVa2GJa5sYha/pSjw==
X-Received: by 2002:a17:90a:ec8d:b0:380:9d0d:7ade with SMTP id 98e67ed59e1d1-38e17c7f921mr414001a91.0.1783971482417;
        Mon, 13 Jul 2026 12:38:02 -0700 (PDT)
X-Received: by 2002:a17:90a:ec8d:b0:380:9d0d:7ade with SMTP id 98e67ed59e1d1-38e17c7f921mr413975a91.0.1783971481987;
        Mon, 13 Jul 2026 12:38:01 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-313f3ea883asm207540eec.29.2026.07.13.12.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 12:38:01 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 01:06:58 +0530
Subject: [PATCH v6 09/11] arm64: dts: qcom: shikra: add WiFi node support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-shikra-dt-m1-v6-9-bee265d3499b@oss.qualcomm.com>
References: <20260714-shikra-dt-m1-v6-0-bee265d3499b@oss.qualcomm.com>
In-Reply-To: <20260714-shikra-dt-m1-v6-0-bee265d3499b@oss.qualcomm.com>
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
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783971418; l=1908;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=8/FpCKjXpnBa78fkZAMzVCGiZKnCnFSw8zBEtlMuGnI=;
 b=oxqh6B+wdVABVr3BrVMyttYe2SpdgRMGWhozlcQdQreZ7v88nYRSwvuHH2ihNZeMJeFhTtRw4
 mrc9ETQrATaANLbtxicGGbW/kCyt2l+T7oAYl7wQbkGbgxhxahsT/IS
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Authority-Analysis: v=2.4 cv=FMErAeos c=1 sm=1 tr=0 ts=6a553e9b cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=QXJAvSDBUSNnL2LUfNIA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDIwMyBTYWx0ZWRfX41OmiVbT4JBy
 HSF/GeGkT2LcU0H9mKqLqddQK+Y+vqe/bcNkn9Myn+WJ4NPz5siiekNj3OA+286lim3Zk5X74O9
 7U2rHLA7y3Uaslsim4bt195hVMBjFJ8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDIwMyBTYWx0ZWRfX/LfLPvf0MJBS
 WS6w5XoEhR0fV1okJfw4CwJSazt4Fgj17qmzThwFrRS8n7LbrWp91J+0rvJ/V2R0XOT8MYGxNl/
 PsniVhvCyOCla7zQ4JAIr6Shbg1yKh5/mnFF59753pufgukn+cEOkXQZX4kDjal9kvhCsSr0ifd
 MJAMu1vVMYptaqNhShwikILRdClbAcs8xWdDly1HykM+9g3mL9WcFyYZwLKEUAWzWEpUpg+jZHQ
 VsoW47+l0Ue3kFrD7AY80SlFVVEDYrfNy8DBQ+24pGvcTZWfMF7uc9bsGmvmLeN5CyDfQJ2cI/b
 vueQbtKaJ1HHF2P5YMC6BUIVmQmtAnC/C9dd4gDcEDktEnSyOgNXa4ebLfXf997Epyp9urns68O
 XMQ9jbQB2umLjH6hjZWIctHIrfzo6LSF3FQsp60GOy4AvUigNxTBl64lRmogx29Lb6KGrL6mj81
 JcZZ9jxLSEJVQisNBhA==
X-Proofpoint-ORIG-GUID: -AwXg7QSS2QQEe3ONH1QOI2s9pVM9Ccu
X-Proofpoint-GUID: -AwXg7QSS2QQEe3ONH1QOI2s9pVM9Ccu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130203

Introduce the WiFi hardware description in shikra.dtsi, including
register space, interrupts, IOMMU configuration and reserved memory.
The node is kept disabled by default and is intended to be enabled
by board-specific device trees.

Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra.dtsi | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index 3abd0a686d0e..205814c4b349 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -2079,6 +2079,29 @@ apps_smmu: iommu@c600000 {
 				     <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH 0>;
 		};
 
+		wifi: wifi@c800000 {
+			compatible = "qcom,wcn3990-wifi";
+			reg = <0x0 0x0c800000 0x0 0x800000>;
+			reg-names = "membase";
+			memory-region = <&wlan_mem>;
+			interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 359 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 360 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 361 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 362 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 363 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 364 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 365 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 366 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 367 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 368 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 369 IRQ_TYPE_LEVEL_HIGH 0>;
+			iommus = <&apps_smmu 0x1a0 0x1>;
+			qcom,msa-fixed-perm;
+
+			status = "disabled";
+		};
+
 		intc: interrupt-controller@f200000 {
 			compatible = "arm,gic-v3";
 			reg = <0x0 0xf200000 0x0 0x10000>,

-- 
2.34.1

