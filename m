Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C00033A71B
	for <linux-pm@vger.kernel.org>; Thu,  7 May 2026 06:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778135026; cv=none; b=b7NRrilLqJsG1kJKg5WCTRW301yZeYnxsuJzcQhNV0zrFT/Gp4XZCEo7/CpEeaOSMZEtIfWmQNEjCFYAtLYhZHFyujP0RTQDEGZoUqRmC2goX52XRscihYCPrYuEertjpab5idommebEoUVGZ+X+tw6s0J1Y4tj63YN8Faqgdt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778135026; c=relaxed/simple;
	bh=UgfBCZ1rMfVTJev0k1z1NyPZBVmzJ4hpyWJ3luahNzI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N+g+aHcJU1S+NOJ1XPmYt9t2CdULlsBDjxNa5djao3Vt8QRMEhMvbVkZfe4zfW05i3cY1hmEBrvc2MapmIguU9AJzmxXGVYYHp+zXHdkT2/3wIF5DGsz1iKEXMgtIlsCrWBreQA4I3j18pqiLjUmW3lRcfEPiQ5XsZqHMFIsp/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=S+GcArRV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=L17CyGdX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="S+GcArRV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L17CyGdX"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6473eWdt026511
	for <linux-pm@vger.kernel.org>; Thu, 7 May 2026 06:23:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=9rNAGIYUfdj
	1piWxOjlP8LFzd1d7wyZuV9JLCGPlDQ4=; b=S+GcArRVddDimIfm0VImbZsU8Jh
	BojGaEBTeO+nt1ue0Qo77p3y/UgonoABpbOevp9/nGuz9PW3MF8YD5gHhF3zl6D3
	hTbt6hN3PiAxkOddtM0HDKwxg/OVlFgQ3y+zFUoo+Ir757YYz0cSM3HdaX+Dc4g8
	JPOhe9WYHuv+8ys5rhJJS4AvMG1Nt/DiWN7ecMTuA8YRyDgBD+vIs10wF+mKJfPE
	sLqluSCWDcs9MXVlPhRwAWBCNFi0RtdqP0G5c3astwdk6iv7GGOBmCSmzCNXz636
	djZKA2peeZvhaK0RSj0lQgIs5gf5KcijeJQx9NmYIQFMRCOiydiW/FDeRsQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0k1t0fqn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 07 May 2026 06:23:44 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-835417ba8c8so275910b3a.0
        for <linux-pm@vger.kernel.org>; Wed, 06 May 2026 23:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778135023; x=1778739823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9rNAGIYUfdj1piWxOjlP8LFzd1d7wyZuV9JLCGPlDQ4=;
        b=L17CyGdXl5oALRBZio+6gdnW45ltkjie6m1tAsCSlJeGR7AmzU4zLK7jwr0VxzldWB
         Vbh6CDDLRTb35mirlagpmKganSckExNvg+Ytj4DkRwMxPiHJpPk7js+zMNOAN5ISGs0J
         fIP7UM8UmfFKHj1X41PRSmp/2gPrmreGWBh8bx3K7+bhJAZiS8cWXpEdkKD8Hw+bL+7U
         tP57DKydrQdrw9smTID9dHkxhWu835mCYmm5b8ZrZnrCa8wIkt2G2od3MhrDtEtmsXj1
         Sl5vcFC6ztND+zLlzArqTB3UQ3WmY38USmfYoBXrpPZ172FE8pS53Hd4ntZ0o6EXfPP1
         /2zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778135023; x=1778739823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9rNAGIYUfdj1piWxOjlP8LFzd1d7wyZuV9JLCGPlDQ4=;
        b=jvZkzfi69BDh6nPMP5D6TsStGmgBBohx3cmvnDcQKTN7T8LLyIOtRHJdOnjkOYKL92
         XZeoxc9ebRHkmuh0ERYcdOWszbdrmAa5B+KMuvttzyapXus8vSTQ0lj82Jh2nUFBfCMm
         tRoLdMwR5P1XxOIUI4wYlRxanKya7TD6WKiABPZGcuhdU5FmBkcQ1DnHEAjF58LS7oly
         64/YU/Z+QuDVujzmsVnlJamUp6qcDUxNcDrxJDxAek2uB1g6XLQOQDMl9MCrNRibTslQ
         0hMYc1ns4yMneRNBGSCSBfHJLctePuKC93+vx3il7I7YuFCnrQy6bAgXQQpIB7QRWrdB
         OXVg==
X-Forwarded-Encrypted: i=1; AFNElJ94D5GH4is1WmLEzqbm9NFskehb7qM9eApGSEmLpfRhiMggMmo36i6SsWl0MYfz9peA5PiNWOi16Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwGkFA98RJuVfGKMpq2jl/duKOKJ1ggRG5MT4yFGj+kTPJjGh0w
	LlSzncgBfmNsdz4j+jb18XgQ+OMA4brfiuHKTkgDsNG+2nVZwWxk+aJDZ/vA6wS3OJrlV0Sl+rL
	miMfkOb1mcXY4IvhKh83muWbfkbjtNrG8dNrNqV5HCt1kDCBwduaDYGQa9u5hAA==
X-Gm-Gg: AeBDieu1XlF5YL4Ujore41qZTrMoh6rUEWIyijotiy40oltapNjHyOpmVkH6TxDFLo+
	AERLDIo66GRrco84i+z1Sg6zvBlj+ov4Wl0grtoOoRPsmtFFYuusW0HeG5aBX5fnAsOOhriWjZo
	xCHlrD9z4h1qKJftrOLIloxMIcRoRbNMer1mWWZ+AdPwtfAy7n3zQfq2Iw0hMud714Zfo455+6/
	AvFGUfVY2+9zwvoDb9rvlGCHY6jz6ohR66I9DW+rd0A+oD9/HPZJK1JO2KXyYjox3kwO15q9ZXn
	ldgBVFWX/agagstQ1c6Opec5YMF5TajIcoah97a9HYbNXxT2ENZeTQbhozewqyWcARCPijVxDNJ
	tAbrT7m9iNzvYLO0Yb2SuVJk+POo1fU9qTAjNYb0/UYf9grYUNrETb/kxswh7s82cDaLtNry2Ab
	IDjYL++I3kMoTMPL3HJSOl+cd+M6JPjFBpRSjNQketP8SCiARvRMuP8FKLdg==
X-Received: by 2002:a05:6a00:460e:b0:82a:7dfd:9757 with SMTP id d2e1a72fcca58-83a5b2d3078mr6499168b3a.4.1778135023537;
        Wed, 06 May 2026 23:23:43 -0700 (PDT)
X-Received: by 2002:a05:6a00:460e:b0:82a:7dfd:9757 with SMTP id d2e1a72fcca58-83a5b2d3078mr6499131b3a.4.1778135023021;
        Wed, 06 May 2026 23:23:43 -0700 (PDT)
Received: from hu-sibis-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83965945101sm7346557b3a.13.2026.05.06.23.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 23:23:42 -0700 (PDT)
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
Subject: [RFC V6 8/8] arm64: dts: qcom: hamoa: Enable LLCC/DDR/DDR_QOS dvfs
Date: Thu,  7 May 2026 11:52:37 +0530
Message-Id: <20260507062237.78051-9-sibi.sankar@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=EoPiaycA c=1 sm=1 tr=0 ts=69fc2ff0 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=gKi3Cb3mJvt5RuhTHbAA:9 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: RcLNf9x5tlKdNZA3eCecMkPLC-wUxwRT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDA2MCBTYWx0ZWRfX3o/SJiHoejG7
 3XB5tjlEBiHEHb0TvIzH2aIl3CoERQ/a1tKTp0uVgiGBXCz9u1MJBQlhICS51X5/4B+msvF5+8n
 1pdCClwIhYW8H3dZ0z/DozlNv9/88UD1GbQ6zOSUM7xN44GAJV6zb1VABlJBWjQrNiqG3LRP+Tt
 bwtH3zbLb+8o+jeaywGWW5ia2sHFylsPZmEk1TElhGUvtZpccsNbc94im1Obzr6OHwIsTbsPvjM
 QvcnQwhI2495sr/o6TY9UM2jry8RtAxy79YVa/4/37wvvXMV2547kygApacojr0nFkBHERuYtnX
 bmq6THdgmoUJ9qFznhhTSb8JADgS6E9nRC+yRSzCkfL9PKzjqXWc9qujwnNTGCvxue/YfOT5vbD
 XJcXnIZHFNtNUaTZPt68AFUMYZETR+JpeIkjOvNcbvY7oVaFccjqhyZa0elNoEJJNniyyP+OLMu
 1Hq+H4VQan4DmQQDd+w==
X-Proofpoint-GUID: RcLNf9x5tlKdNZA3eCecMkPLC-wUxwRT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070060

On Qualcomm Hamoa SoCs, the memlat governor and the mechanism
to control the LLCC and DDR/DDR_QOS is hosted on the CPU Control
Processor (CPUCP). Enable the nodes required to get QCOM SCMI
Generic Extension protocol to probe on Hamoa and Purwa SoCs.

Signed-off-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/hamoa.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/hamoa.dtsi b/arch/arm64/boot/dts/qcom/hamoa.dtsi
index 051dee076416..a2d5c9db984d 100644
--- a/arch/arm64/boot/dts/qcom/hamoa.dtsi
+++ b/arch/arm64/boot/dts/qcom/hamoa.dtsi
@@ -338,6 +338,10 @@ scmi_dvfs: protocol@13 {
 				reg = <0x13>;
 				#power-domain-cells = <1>;
 			};
+
+			scmi_vendor: protocol@80 {
+				reg = <0x80>;
+			};
 		};
 	};
 
-- 
2.34.1

