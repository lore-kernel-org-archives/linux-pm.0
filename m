Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778CB338595
	for <linux-pm@vger.kernel.org>; Thu,  7 May 2026 06:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778135020; cv=none; b=LytIngWF6u5XBwus5jQWD9CFcOQ1iYv24SRvCXHY7ftlf9RXHTIL5CjIiEHGOSickPHwWuMHjTUOskOxBZHyfbyNFc9Kz14cZkW8aYiNIU1FvzoU3dTGi/vzxet9bH+1x24h2xQ1/kZkGMQPy7VfA4UwRRLukNARCk5lBFfbeNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778135020; c=relaxed/simple;
	bh=iVYxhwFahA+hhulSf31W1qcb6NjNGKB8JYNcOB91Px0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sNNloNxyUj6uhAc5VtKHgWsil/prJZpNRfDyiONspCllEFCKivrFKOPE9x7jkwKvbT6ArVE7ghRAimyTqL6Z6gn2WottA3c0alLdcirzIhDZQrfq+J3MpOVbqDjUj4hjrdzJwmVPek8gGuBYfLlPDIOfAgYKQfOQJsJAADGdFjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bWGNZudj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NMIzXP4I; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bWGNZudj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NMIzXP4I"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6473eHds1669796
	for <linux-pm@vger.kernel.org>; Thu, 7 May 2026 06:23:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=W6lOhP1mJj9
	S5lsQBAhviQQkaUqn3FvSFeARxkagj0g=; b=bWGNZudjP0LJgeME8J9ge2Au3DK
	/Ua9/TXFFqO7DWpCkDyFVKdqVKPci8l5RH5BK4S8acapR3QJLkfsvl2Ekj9DMQBh
	DWE/KgpSVnL4hpirvO7x0GkW31fOgHoG9rO8Ppg0K2LcpH+o5+rF1etXzRQGZ8D2
	hn9vtnx+s2FWvmD1V7J42U4bMFDkZ0Gc9G0EU+iD1KJNDqTTajgCZbO6PDdEtsN8
	b9HVVI7D0xqplVuWn1lu3FCsLjOxEPWtMm7W+vHWyXKh0Ecd4uYyxgmE/0JzH6tD
	f7sUQVnEhyI4Dmvx7njOZwkgmEDyutO99kUXawRgBK5i4LIF6RrNkWfEvCg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0k1p0g1p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 07 May 2026 06:23:37 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-835444b6ce1so374099b3a.1
        for <linux-pm@vger.kernel.org>; Wed, 06 May 2026 23:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778135017; x=1778739817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W6lOhP1mJj9S5lsQBAhviQQkaUqn3FvSFeARxkagj0g=;
        b=NMIzXP4Ih6iewMtw6Wg05vSRDKvms6BNJjLIw7zGaNRSMFsLNcjmcFLUUgOiP5e1nU
         t/mVevYs6n3PbP2UmaWYdA1qs4QWVsyHp3dsmXhS0X9YHH3A0fJpq7uM6cc2oDTAWyYB
         WalKB+CyAkleLOEfEYahE8LP4+FNrZuV0qcDxbWDqiWkgaEdcFnHprVerHwmNe+Rz6aD
         Xwbp7fomHwXc2M+CdxftVJQUrVRyY3jFIdC854nlsw0ynMog4K2Yb3VsHHrO4JLCe0RV
         0MwWaqbJuhc7c0oS/2oZdx5d3AqFeZhCOihVcJsb1TdNn8eJjp1S5Hx9a6ANFmz+41sw
         jlKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778135017; x=1778739817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W6lOhP1mJj9S5lsQBAhviQQkaUqn3FvSFeARxkagj0g=;
        b=qLeSC0vyaVdFYZSK7FE6paKSfJgiripTZNUX+CWyX+/bMHwN56eLBbD8TX5MR+CEfa
         y8BuNZbliaZr22ppXUxRODubdRf4Rf/evO/pD27KHzI6Q19pgZ01hq+Jxqq3zkns43CF
         Kb5WLFl4AE382sD/dXmUkCUMrOZhSyEcvL3hWZql5xs7rNR58Bn76CQsDx+6ycUbCT2p
         yGSGm1G3KJOaodGwrA3RFGEERY2iD4qtovHEHb3imNCqItn5vntlRT9SzDa8nJEflwWx
         RReTlZFd5hwCYj5vn4tKsH/6vINy/hKiMLzyoMd6j03JyUW5/x8tPnwxHfKfX1GKukDv
         tBOg==
X-Forwarded-Encrypted: i=1; AFNElJ+hayRMOO4o/IWxfkbxsnT6i37JjHqF2RyPCN6oNQvC5o4LKVAe1yxLw6C7h/NGTGt8TsWIByDCHg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwzeMqAvf/F5tk7c/lokLztaBpU6PNKdIyVZD2WxV9k7Uk7cLoC
	h0xBTMdC1pyPV0lCxUzYEhWE087BzJqyDy9KY/oSvLNTOXwL7fhH9l16cQCPVKYdMQOKFhtKwVn
	FF/4JJPN9B8ba19/60F/q0QgDImlplgtKfwMPJLG3oDDsu2hZYCtCMJdvuHaecQ==
X-Gm-Gg: AeBDietFozeg2Qj2maQ8FTeS8Hfs11AcOYehli0y2hF6QuMS0qtc2XE0eCl1n+WCvpQ
	0G9lcLZc7VPKlAPXx2tptT89Nqg1PAwAbE5XVS/Rxz8CkBb+zIVhxvCl7u52F3p87RvH/1pYIE7
	AEcU/TbJDLW2zrssjBOuche63Tov3NoOR2+PY3YTwpfLgCrHzthCzlwFm6mG0BBohf9RQFD2qjo
	5BXGaYunNctpcld+IIBx4rbs4NVab+HD2WnnoT8y5/c4eUnakqknadybTCE/0+rJMfiC+KG3Tu/
	nAvIFqP9CsomQVtLCIcym2eSmY2WUW9rW9AZP1LYZFtDXQCrusES8fi+WEokD4vyNswdD9kZy9r
	mkh1xAAHwtr7KJipgDDkfVjnOdiIGurgKG+OTFhZWWRfvZ+kGaeRpQFKXeHfoq9/RxdXOaGTFwn
	YAAK5uJe340GPlwFXFAjL6xN8LzTmLHLlkNBj0INCS0TEplSI=
X-Received: by 2002:a05:6a00:b48:b0:835:351c:f236 with SMTP id d2e1a72fcca58-83a5d09a78dmr6377465b3a.29.1778135017233;
        Wed, 06 May 2026 23:23:37 -0700 (PDT)
X-Received: by 2002:a05:6a00:b48:b0:835:351c:f236 with SMTP id d2e1a72fcca58-83a5d09a78dmr6377412b3a.29.1778135016714;
        Wed, 06 May 2026 23:23:36 -0700 (PDT)
Received: from hu-sibis-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83965945101sm7346557b3a.13.2026.05.06.23.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 23:23:36 -0700 (PDT)
From: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
To: cristian.marussi@arm.com, sudeep.holla@kernel.org, cw00.choi@samsung.com,
        kyungmin.park@samsung.com, myungjoo.ham@samsung.com,
        konradybcio@kernel.org, andersson@kernel.org
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        arm-scmi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, dmitry.baryshkov@oss.qualcomm.com,
        jonathanh@nvidia.com, thierry.reding@kernel.org, digetx@gmail.com,
        conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org
Subject: [RFC V6 7/8] arm64: dts: qcom: glymur: Enable LLCC/DDR/DDR_QOS dvfs
Date: Thu,  7 May 2026 11:52:36 +0530
Message-Id: <20260507062237.78051-8-sibi.sankar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260507062237.78051-1-sibi.sankar@oss.qualcomm.com>
References: <20260507062237.78051-1-sibi.sankar@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDA2MCBTYWx0ZWRfXzB7sVH/bG8ji
 WwFIjpTp9ORyAJrA/HAASFjXeD+9yEA3DNQpSeXGdX5DfBAo6MSyulekgLOkHe2dHioODB4uHav
 PNYutpclK1fTJ97TV04Ql99nldF/PMAOghFNroBnWW42kVYbOXQ9/DgGBmR0BSXveIzXFfHbW/a
 OzzYEvlWcpqiVYgODKVRB3Ak6282BS2YsvV11uSaHT6t5EExUpAyZpFPhFHkRHgcpHntwdlUz7X
 m4akfv7ikAm54h4T9k94Wx5Y+jrpiZZZ36rM5eVu71PIJZNr8OkGI+pohZrclMyLChBHsZBojED
 EULorkaopiSr5BfxGee/OI6nAmHjeBIh+l++7SNDlbOpkOt2DgTWTJf0/2I8RsFPf6dScUSPVmn
 eXJe/YBHAqSRRWuORhLsQim0mfYp5dF0L4xJZchIZfndeX5U+02XH30byjEXcYVyzcp0N26bM5n
 divA55ctPuNU5NcU/Mw==
X-Proofpoint-GUID: z1J29uzeF9g5jM-O0qzVCKQGeRRYqwRv
X-Proofpoint-ORIG-GUID: z1J29uzeF9g5jM-O0qzVCKQGeRRYqwRv
X-Authority-Analysis: v=2.4 cv=K4IS2SWI c=1 sm=1 tr=0 ts=69fc2fe9 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=GY6npCAvCrdgt1im_sIA:9 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070060

On Qualcomm Glymur SoCs, the memlat governor and the mechanism
to control the LLCC and DDR/DDR_QOS is hosted on the CPU Control
Processor (CPUCP). Enable the nodes required to get QCOM SCMI Generic
Extension protocol to probe on Glymur and Mahua SoCs.

Signed-off-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/glymur.dtsi | 42 ++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/glymur.dtsi b/arch/arm64/boot/dts/qcom/glymur.dtsi
index f23cf81ddb77..6409350ad9d7 100644
--- a/arch/arm64/boot/dts/qcom/glymur.dtsi
+++ b/arch/arm64/boot/dts/qcom/glymur.dtsi
@@ -349,6 +349,21 @@ scm: scm {
 					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
 		};
 
+		cpucp_scmi {
+			compatible = "arm,scmi";
+			mboxes = <&cpucp_mbox 0>, <&cpucp_mbox 2>;
+
+			mbox-names = "tx", "rx";
+			shmem = <&cpucp_scp_lpri0>, <&cpucp_scp_lpri1>;
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			scmi_vendor: protocol@80 {
+				reg = <0x80>;
+			};
+		};
+
 		scmi {
 			compatible = "arm,scmi";
 			mboxes = <&pdp0_mbox 0>, <&pdp0_mbox 1>;
@@ -5675,6 +5690,13 @@ pdp0_mbox: mailbox@17610000 {
 			#mbox-cells = <1>;
 		};
 
+		cpucp_mbox: mailbox@17620000 {
+			compatible = "qcom,glymur-cpucp-mbox", "qcom,x1e80100-cpucp-mbox";
+			reg = <0 0x17620000 0 0x8000>, <0 0x18830000 0 0x8000>;
+			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
+			#mbox-cells = <1>;
+		};
+
 		timer@17810000 {
 			compatible = "arm,armv7-timer-mem";
 			reg = <0x0 0x17810000 0x0 0x1000>;
@@ -5859,6 +5881,26 @@ rpmhpd_opp_turbo_l1: opp-416 {
 			};
 		};
 
+		cpucp_sram: sram@18b4e000 {
+			compatible = "mmio-sram";
+			reg = <0x0 0x18b4e000 0x0 0x400>;
+
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			ranges = <0x0 0x0 0x18b4e000 0x400>;
+
+			cpucp_scp_lpri0: scp-sram-section@0 {
+				compatible = "arm,scmi-shmem";
+				reg = <0x0 0x200>;
+			};
+
+			cpucp_scp_lpri1: scp-sram-section@200 {
+				compatible = "arm,scmi-shmem";
+				reg = <0x200 0x200>;
+			};
+		};
+
 		nsi_noc: interconnect@1d600000 {
 			compatible = "qcom,glymur-nsinoc";
 			reg = <0x0 0x1d600000 0x0 0x14080>;
-- 
2.34.1

