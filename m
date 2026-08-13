Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB0448CD6E
	for <linux-pm@vger.kernel.org>; Thu, 13 Aug 2026 15:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786636403; cv=none; b=O99NFf2q1NfLqg6OLgCSe7QSTj7i4cB1OSaqMtxHocAltKAHGj68tHhC4twgGittzq0NyzFYvap4q7UOlWtXTkmllPqT64Axg64/51sEumOL+wCvuJ2ZNmfsrH5Tx0aMq/sNFdyUT2rd8B/GlbEBXjNSBOtWg+aRdnzlow2afJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786636403; c=relaxed/simple;
	bh=CYLlKi/SE2dS+BKWZmr9RLIrKp11lqFHuiopYm81YTo=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=iH4Ve72mZ8JgFVLVwYHTsLSkCGD2pI14qSLb4YizvDNO55wZ+r5KjwSBVoo9vLKO9khuD3M/ekAmC7BuC2zwa+Wg5e7GMuZOTpttP6tEjQLwqhb4zwQlk7cOgyngNQV1UM+qx6B+BCqZp57sBRyzdLSlkDK9byUPREujr2rMop0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TInMFUPV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SvxMyfyR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TInMFUPV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SvxMyfyR"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67DFTMrD084336
	for <linux-pm@vger.kernel.org>; Thu, 13 Aug 2026 15:53:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=iMw808hq0PqM3j0Ds/2zW6
	JesnbSKNrDU9pxEw5Fdgg=; b=TInMFUPVVJr0SeySw7KpDIu/MGkrpvub2+rj//
	e/6rsAR/s+AnkUY5DQztOAUnpHrsbg5U2igYJSPcgLgLkw0m5fQGP6jTfIRnmcjO
	lfWCoH1y/Dthko/BEy7NxGbC7RVt6fdkwN2YqrSnuOw+vStOundm9jKhNg6INk29
	wJbIQw0cqyyfx1WcnYOzkpd1TEQ2gfK3PDhSZIDXMsFrvgeG4ArtHU7OkSBRgIpJ
	zFtTyVN8g7AYLSuzI3OfFPNGAIt1vaQpJFUQcMVBtQqa0CcH1FSPhhQlhE1z54VM
	X7I4HYvGGYnrNc+YgzcvdU0vkw8WFGwpl3KuLN9RJ3fGCrjg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g152mb877-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 13 Aug 2026 15:53:17 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-52d7b3adda4so651341cf.3
        for <linux-pm@vger.kernel.org>; Thu, 13 Aug 2026 08:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786636396; x=1787241196; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iMw808hq0PqM3j0Ds/2zW6JesnbSKNrDU9pxEw5Fdgg=;
        b=SvxMyfyROqfuECQZLhYRX2PYONjiKvVusPsX8Z3NPf//A9uTN43JFVkKY3OZI/YE7u
         EjlOrESVc7v0MdYk8BmltmGwsjXADUhvR51Zub8rdCQP9vFp64A99WQe64T3sU/V4dea
         cmHtRJi9ude+OpDuYihnCVDtWpAz2wuX8QtG47H28Enrvvxsh+qShXhh54Ll67jzp9SM
         enAZH2kdssvc3fLkkoOg7/0tZ2WjXMtXEb73q/5sK5H83JQynF+DFhaT23T3UlDsQn4X
         ylefsBffvERU7FORRYm09IzKLFTmhE7anrTZ8oCEI1FpVD+Wd2iDqktPWM18uwu+RoRf
         3w+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786636396; x=1787241196;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iMw808hq0PqM3j0Ds/2zW6JesnbSKNrDU9pxEw5Fdgg=;
        b=h/2oHYSWMiZOARt+upIinLhZ8a/r7kcrSdK/OO9OQZmGLdgLc0H3EkSfAVdM4MeeOG
         opGazHJAovqExtBNN5EoUUH1AwiebqusaD9KU7bv1vQi9TCtupjT5bPIH+fGYAoyykLj
         /wH7vj+JgFcZehOHYPfRmlv3I02WZzTfNppuw1co63GR3J+tueMcxgAE5VhvpwXgWVzN
         C+hhr+NiXUNPCmkiGVSf2iSycaE5Bai70ed8kEbqlPZVf4F/BaJ+IS7il/QfrhdsbaXQ
         y9jrCX/ny7r8BKTwyktexgs9cqxs8RpZCIpUlwSNFQjGe12TsGtqe6ngQ/6sEAE0z/R2
         TUHA==
X-Forwarded-Encrypted: i=1; AHgh+Rr1Uuq5GrwLJkcm/4jy8LjAs7hl3YyTb8knMmvsacyprthG6aprf2i1tvf+O54DqI2qcoE0farw6Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzGe85xhDb0WWJ5S9yjIGNTlsdh7n0tlb2ySnkmquHDD6fd/09h
	BngNVAefGsEBPeyymAq4xCsTUnCyaCZ3gR4rpOA7OsBUJ7D3xUf7tAmygLF2IamkTzcdEO/+oYx
	vGA3sD9R9gFUdtBYO7IrCy/hEwa6nfL8sQBe4MleF03o1FpNTGhXmqBJ9x9Ozbw==
X-Gm-Gg: AR+sD10HUbeWBGB+2kyaURwYv4zXJv9SW01zfb5HXIjX1IP98IH8pTPMtmliJNi2FZJ
	+uTAk64+5gBcjBzlR2RgMah+CxaoyZ3v0iyAh3vMpzmj57xq2sXRFX0szNOi0PjVtVsgQm5S2jh
	uSXJx3omRHegqCIXt5Gd74kEGOil9ylpN2tWNFs0gp0nM1GEO2vqaRISAXgVDeROuBB3/wZ2efa
	2XxvbvNk99dGWGiG9SZEa5joXpgK/MlS+Q2eoAWjDehdJ/Zg3wffw1FIpk2Y6wB4b95RagtSyFo
	lHPOhZIAa91dMjtksNWkwCJ1FeGBhIgGcwOM3R4skL+9uDPUzExO59ZmhOy4woaYO35ltBcFHY+
	drmT7/774tIgrDishKwcmvod64r7wwDdo3Pt+zxqym0hevd8MSJ5EqNA0reYb1As=
X-Received: by 2002:a05:622a:4818:b0:50d:9e8d:9837 with SMTP id d75a77b69052e-52d73c0f303mr74722921cf.11.1786636396324;
        Thu, 13 Aug 2026 08:53:16 -0700 (PDT)
X-Received: by 2002:a05:622a:4818:b0:50d:9e8d:9837 with SMTP id d75a77b69052e-52d73c0f303mr74722451cf.11.1786636395852;
        Thu, 13 Aug 2026 08:53:15 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:f8db:2cf1:ed63:1b3f? ([2a05:6e02:1041:c10:f8db:2cf1:ed63:1b3f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f229681sm222886f8f.16.2026.08.13.08.53.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2026 08:53:15 -0700 (PDT)
Message-ID: <468d3bf3-fbdb-4548-bde8-1c94ad6f15da@oss.qualcomm.com>
Date: Thu, 13 Aug 2026 17:53:14 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Lukasz Luba <Lukasz.Luba@arm.com>, Zhang Rui <rui.zhang@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Subject: [GIT PULL] [resend] thermal drivers fixes for v7.3-rc1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDExNCBTYWx0ZWRfX3OZKKwYu2bKm
 7H/gylOR8Q/hoq/aCVMCnJ7qnZZcEcvQ15yi4CzQHwVKip/gI0MewYtjMjaqdKUAh6zzGQ8X6a+
 GSrhOS2H0UubET2to1oc2LXQypVBz2M=
X-Proofpoint-GUID: B_lsq6iawbMku42AiTQOId4M3OvOUrZr
X-Authority-Analysis: v=2.4 cv=D8R37PRj c=1 sm=1 tr=0 ts=6a7de86d cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=AsoIsmY3Ml_igTwJbuwA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDExNCBTYWx0ZWRfX5M0LorkAQzSb
 VpTKm3jQE/JuUxeh9KxD+roo6loj7KWVChtatY2aWccPu1F3hnyDajVCTFp0VYi48k6D3WOT4/T
 +PKok71QRWRU6fNAn6sf8iHEu90kRnr7DFZRh8CG++qsxjhF6wnqRaHFstNeg1pBWlvV5LdJ33M
 CGhd4YgwR4BYerpe5Q7M+u9E2bSsqfqeSb/KxRV/WaQ+vAV8CsDRPJaKdrbaOy7/gTpdYbQPSbv
 j9k+YWgpK+pwNFRjdySYT+/Rh582xzefR1QM6qh81stdPcxgLWE4FTtH4LuEjdP1djMrWnZX2ji
 vJyMRBspOCORf++ayK0fUNDsa+DkTDXcanic/ddfxiHrkr4COHEoW/VlkOG/Skgk46/bfgTyExY
 VAnfO99K1bFLCHGJEHp8gt0EFoXtQBXmWGVnnW23s+OIc0otJbQPNYQv5+6tOqGwna6vgkdVits
 Kw8ywhfDttedlg6KeVw==
X-Proofpoint-ORIG-GUID: B_lsq6iawbMku42AiTQOId4M3OvOUrZr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 adultscore=0 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608130114

Hi Rafael,

please consider the following changes since commit 
ccda015d76736dc5ccefc70a040b9304a6c2000f:

   Merge tag 'thermal-v7.3-rc1' of 
ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux 
(2026-08-10 12:53:41 +0200)

are available in the Git repository at:

  
ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git 
tags/thermal-v7.3-rc1-fixes

for you to fetch changes up to 61faa946db1a9c94a3f48e587235d9b41bd8b07d:

   thermal/drivers/armada: Fix missing bitfields include (2026-08-13 
17:12:42 +0200)

Thanks
   -- Daniel

----------------------------------------------------------------
- Fix missing bitfield include headers in Armada and QCom SPM BMG
   drivers (Daniel Lezcano)

- Fix missed file when manually applying a change after a conflict
   resolution for the QCom SPMI ADC TM5 Gen3 (Daniel Lezcano)

----------------------------------------------------------------
Daniel Lezcano (2):
       thermal/drivers/qcom/spm mbg tm: Fix missing bitfield header
       thermal/drivers/armada: Fix missing bitfields include

Jishnu Prakash (1):
       thermal/drivers/qcom: Fix missing spmi adc tm5 gen3 file

  drivers/thermal/armada_thermal.c              |   1 +
  drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c | 434 
++++++++++++++++++++++++++
  drivers/thermal/qcom/qcom-spmi-mbg-tm.c       |   2 +-
  3 files changed, 436 insertions(+), 1 deletion(-)
  create mode 100644 drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c
