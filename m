Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FA2481232
	for <linux-pm@vger.kernel.org>; Thu,  4 Jun 2026 16:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780590155; cv=none; b=kQV6kIcANFicBV9ULW4OndGYvf8vrA5OnYzWx/TbFPXce5B1Kied31HxbvKNQXLumm+PD5gVpXHN2YQ/itVxJeNCxPEy2yNEky+tZgtLF3s/V/HWagwFeDBYvDVVQVC+KdljSIfBjotWn6T1IvyzNMHLdcM64nDIrPuOgPJ/49w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780590155; c=relaxed/simple;
	bh=KDONWoVWgo4bQVHIX5jep12WUUSRUxz8kNJF/VhmCpQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Ai7Tk+8WyHx3ydQySaWkSE3ibiaM3ARn9atMWaT12BvqC+CPmENYoCqNjvrZDBwm6wy7g/LhiOQ5Tv24uOPw8DmuF34NNOC+zDA85g+nIiwIekKnitk8y6NrAyarbLAevYPjaJJtcFswLuFKvkIDEWuYtvLLGKWuuFb45KaANyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EZ5jiiY0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CAgWcgSr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EZ5jiiY0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CAgWcgSr"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 654G6tuO1957618
	for <linux-pm@vger.kernel.org>; Thu, 4 Jun 2026 16:22:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=k3wL2K3dlb2dNxaCHLSI8S
	bji31i/l3i8H4s1lAhgCs=; b=EZ5jiiY0WHUhzRfvD304C2b2o45tICUlCYvFxk
	qyA0Zs9yjtB+VZMO369CKdOTKD1bp8z1qM2u28THTBVjDQqu1NAKC4GQuBBOPf1T
	VItdDlEQ5T3stAM1PK5PfTqbJcOOlQ+AEVkTUr1aR879ta5sHJWbLzT9zdzFcIoj
	3QKubtLRQ+HtTAekZzBU5O2pIjJTX1sqbg7S2gFRujmZMnIjGJxO1j/gLkqzmQJw
	KxDNEdlKkPAg4QnMu95de/nN+/7uoZs3juGJWmjp31Vhh3+MORqJv38bbIIqn037
	w24veYHzx7qUO3viIP5DWQr/tFBjv4/YZoAGlysin40ZhO2w==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ekckpr32j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 04 Jun 2026 16:22:30 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-963bc9a24f0so912990241.3
        for <linux-pm@vger.kernel.org>; Thu, 04 Jun 2026 09:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780590150; x=1781194950; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k3wL2K3dlb2dNxaCHLSI8Sbji31i/l3i8H4s1lAhgCs=;
        b=CAgWcgSr6W2Iux4uybUaEdC1Xg4oJNO+DxRn4atfB+i4vRxmFRimkri7NQEvPQ6w8O
         mzNl1CbwQI2wge6at1/TMUEcIHETT6/P9d8GJ2fhIyA3tiFJ3joGdlOqMTzbtRvqO0wJ
         gL86UYi5eWPU5Vg2IlZa1GIaCH9ssHSGdqO9nmeFcrV7cJT8V1H7C8jlwCr/yl6UauOt
         SUadaYtbgcqtZCpZ8/GKwPBCeDMz5ZJ+nxOh7O4rqXgvp52pXGfCMqNPHe1To/bly36G
         gPX1dbes0pcnvqpffOYSIWtylN0i6UMlQwTawDsV0nc7BPM8eKY9u78ZEUbK9vEYvTXW
         EbuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780590150; x=1781194950;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k3wL2K3dlb2dNxaCHLSI8Sbji31i/l3i8H4s1lAhgCs=;
        b=MWYVSsT1jmneItlt9YJTbMVk1e7DruWiv3wquSe3pi6oFUjbladv1UGH2mGhdclFpf
         YzzSdWjFdptSkgBabSae19jeOBxxQUdmV6fu7Itud5UidXHZcTvCAscQjE4TAuXyjSVd
         B4i5F+rrxai8vfyHrR/aW4CVpXuMrl9EMODbmUuKeXiM79NIkUcEcWhqgvkfJfWha2XJ
         uymxUhugOgFOoopPWEFBHmPtkoHHg3aaOicfEgHlJ9MHvmX/QofIgczFk8K/ruw9mRXQ
         Xm4ZA2rbiPh+r9tFgYxCwdPQ7NO5wkzN0IGqcX89YOLunDSmqbqZFDYEWvp4cpRXWp35
         A1Cw==
X-Forwarded-Encrypted: i=1; AFNElJ8J0aqtlGnO2WlRiqFaot/gcu7BF8gyD7GEnxpYQJsF4xNzsbZHB0YrVE8NwfGsSsaiLzwcEW8mxg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzRtjfhbYX0za0YBJe1VU/EToc6yo+0MSyyHLTOYzEDPjQfYH43
	KtiwK/bO+u8OYV9jb4P7OBhr1YJmXi5kADk7QrEgmmocN+LxGlQ4EdR4UiBZnztV0/ZvF7+juhH
	bolMXiRocnAiyxda20bvOUwTyQzPQiC0ATF/C1nRBZSl8cLiYq8WXDJVTEg1fvA==
X-Gm-Gg: Acq92OHS97uYlQJa7jYZLIEpK2OO7gaWrHyaDKwV5XaEOHpwrBMkmXIT95peEqW+Vmg
	+x5VXHC+L8XHbOUngLdmILfVaxpq9YnueOYAFkWlNiv38WLcKUQfJRx093HIcu0SaoTOsEJHTm7
	PRRuTPQcJsNnLLPO57r07CuLP7yM2bxmly9jehftYXhXAGiIrkqbp/NzeMWTy8KWZy7oWvdcwaY
	di+4tPGohA9uMgAei+K//GjLlTIXaAxUTblyAoA+u9TvAmbJ5hZVCoXAFvbGejKZ7ByQAvhpZjR
	7s1LVGDJVn3Y5k4krSbHw9lyhtDwcF1Nkebwt/uJEhVL64aYCEsGuKqPonMOQmATeF1tO3y64Jq
	HJ6IOufAhYqZ8gCfiOBT4yrbVXeZQUr1hjUQYxpsZMKjo2553fFzzZLOjGB4yDDZuQ5Ra4x+p1B
	5MOFUaRFGB54XvGJ3KVA0Cykw2RjNREpGDJmOqiPDlP24r+Q==
X-Received: by 2002:a05:6102:94f:b0:631:ec2d:12b2 with SMTP id ada2fe7eead31-6ec2b17cf54mr6178854137.1.1780590150170;
        Thu, 04 Jun 2026 09:22:30 -0700 (PDT)
X-Received: by 2002:a05:6102:94f:b0:631:ec2d:12b2 with SMTP id ada2fe7eead31-6ec2b17cf54mr6178772137.1.1780590149625;
        Thu, 04 Jun 2026 09:22:29 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-396ac2d5034sm17591591fa.29.2026.06.04.09.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 09:22:27 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v7 0/2] arm64: dts: qcom: fix power domain handling on
 SM8250
Date: Thu, 04 Jun 2026 19:22:22 +0300
Message-Id: <20260604-iris-venus-fix-sm8250-v7-0-7bd2f0e5bae8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD6mIWoC/43SS27DIBAG4KtYrEvK+5FV71F1ge2hQartBGwrV
 ZS7d5wskkVRu0H6YfhGaLiQAjlBIfvmQjKsqaRpxGBfGtIdwvgJNPWYiWDCMC45TTkVusK4FBr
 TmZbBCc1o9NKB8GCVtwTvHjPg6c19/8B8SGWe8vetzcq33b/ElVNGWyM1gDHCqe5tKmV3WsJXN
 w3DDheywat4YIJVMYGYiYr1WKY75yuYfMZUDZOIWRaDcaBt9KaCqWfM1zCFmMcXBqYs752oYPp
 fmEaMBSGk0b3UTlcw88A0FzXMIKa506ZvITr52wCu91FnOC34c+b7vEkbCtCtKM37ZoTz/DqEM
 kPG+usPvdAjxXECAAA=
X-Change-ID: 20260131-iris-venus-fix-sm8250-f938e29e7497
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        Jonathan Marek <jonathan@marek.ca>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bryan O'Donoghue <bod@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Dikshita Agarwal <dikshita@qti.qualcomm.com>,
        Ulf Hansson <ulfh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2209;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=KDONWoVWgo4bQVHIX5jep12WUUSRUxz8kNJF/VhmCpQ=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqIaZBXqz/eOv6SsVdSHfYNYXRqRBPY0J8sui/B
 jhNDL2e2HyJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaiGmQQAKCRCLPIo+Aiko
 1ScVB/9o14pbiVemUmz9SJ3JKaNgvASIRblAOhzAS3YU6g1eiawgEsP08a5cIbYb/xu7mxrQb0e
 wVhGoZLEwnzHSOldaIX9uk7a/RJRPc+uDViiI+aIpN8ShCnXI5F0VV84GRakr69sSkzFw+lEBqE
 TtIPeLyQn9AiTKOTwcWvaYVqX1NBS+N0Yh6ZBVj1FGCOMPWsGy4UOe5j4DUdjmBPknCy4aa0yc6
 Eq2B0JOytVwTPNlYRAi9azpWY6c1rgzPAl7wKfjAk2KDB1xm8qB2Baah5F1B0PPk3Gw4wLSun6K
 q/bwYSfQYdm1wy8AtKfSgG0aGYxnIqSt1pUFng3k6503FYdJ
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: DrmrRIcMTb92XDjpoqsSIW1KEGlo-9w7
X-Proofpoint-ORIG-GUID: DrmrRIcMTb92XDjpoqsSIW1KEGlo-9w7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDE2MCBTYWx0ZWRfX38ISK5SWsAHl
 hkBvio71lR5Z3LMZ8SFG10n9VFzj3gXyJOZq0QzN67SyxToUa+n58WNQAT7ADDHmWODTNF6Wad8
 1MHSMEzwpro8XnBOsBS0HXWL59PaCgEprk+T8u6u2BraTA2iH/g8Myh8XCmWJKLdDa7SBN74D+Z
 6SCiOYNwclh//J7uBdzg47wjy2V6vgPB2VXiXv1ddbuX85LEreLsE+GSgZXrXbg3E2Gjg/gL+g3
 TxZZEfaK5sPvAVl6RH3lStYVi2MobVbXlcH8goyJlipQzczxNBNFRdo5HnORbe9OxmhudxnYMEr
 DghDT99L845QAXSCPWBcNqbIJ4WQe8s7TTHHLLTRWCrnwe+5sg6Jk8Iq0+R1EnKW/8l+H5bFrq3
 l9QKJBoMjsb+9hopxFiQXYQAM8lpUVJuKO9vZ0Bfu+wpqiBNFLxHTS5ezsb9lF4wYlLexgRhySl
 vcaxYqUq//N/B9TxJtQ==
X-Authority-Analysis: v=2.4 cv=H9jrBeYi c=1 sm=1 tr=0 ts=6a21a646 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=cvYA71F9yvrgsMZaK7wA:9 a=QEXdDO2ut3YA:10
 a=o1xkdb1NAhiiM49bd1HK:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040160

As pointed out by Konrad during the review of SM8350 / SC8280XP
patchset, Iris aka Venus description has several flows. It doesn't scale
MMCX, the frequencies in the OPP table are wrong, etc.

Let's correct the Iris/Venus enablement for SM8250 (unfortunately also
stopping it from being overclocked).

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Changes in v7:
- Revert back to the levels in v5, they were correct
- Link to v6: https://patch.msgid.link/20260512-iris-venus-fix-sm8250-v6-0-51856dbef83c@oss.qualcomm.com

Changes in v6:
- Dropped patces, applied to media tree
- Corrected levels for MX rail. Dropped the review tags from the patch
  to enforce the review of MX levels.
- Link to v5: https://lore.kernel.org/r/20260209-iris-venus-fix-sm8250-v5-0-0a22365d3585@oss.qualcomm.com

Changes in v5:
- Fixed maxItemx -> maxItems typo
- Link to v4: https://lore.kernel.org/r/20260209-iris-venus-fix-sm8250-v4-0-9662a0471d82@oss.qualcomm.com

Changes in v4:
- Dropped MX voting by videocc: it's almost-always-on (Krzysztof)
- Restored minItems for the venus device, preserving the ABI (Krzysztof)
- Link to v3: https://lore.kernel.org/r/20260204-iris-venus-fix-sm8250-v3-0-70fa68e57f96@oss.qualcomm.com

Changes in v3:
- Dropped applied patch
- Fixed typos in the commit messages (Dikshita, Konrad)
- Corrected MX OPP levels (Dikshita)
- Switched Konrad from Suggested-by to Reported-by (Konrad)
- Link to v2: https://lore.kernel.org/r/20260201-iris-venus-fix-sm8250-v2-0-6f40d2605c89@oss.qualcomm.com

Changes in v2:
- Fixed example in the new sm8250-videocc schema
- Link to v1: https://lore.kernel.org/r/20260131-iris-venus-fix-sm8250-v1-0-b635ee66284c@oss.qualcomm.com

---
Dmitry Baryshkov (2):
      arm64: dts: qcom: sm8250: sort out Iris power domains
      arm64: dts: qcom: sm8250: correct frequencies in the Iris OPP table

 arch/arm64/boot/dts/qcom/sm8250.dtsi | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)
---
base-commit: 7da7f07112610a520567421dd2ffcb51beaefbcc
change-id: 20260131-iris-venus-fix-sm8250-f938e29e7497

Best regards,
--  
With best wishes
Dmitry

