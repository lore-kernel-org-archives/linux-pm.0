Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47DF3590C3
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 05:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784180933; cv=none; b=MQt8QIfXZ1IWChueEvv/FwWfK11o24+j6BGjh4vZZHSlcQIE9dx/cYyTbWfeEPMTVKwU8hBiO3bHpz01EIc3y4SP7pMB7aUOP0MEKqSSNd+DGXw5U1ohkWAYiJZganx5y68oCm93W0UWKiL1tMI4JBFMMcRBwPnEy3R+Vf+n7aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784180933; c=relaxed/simple;
	bh=3p+EC6z2C0GwRzaFy2GlH6xmETWlQWoDK9dCs2siqIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jJFUynGeLJg9reCayzaniD8yAqNcOm8yotGFmXop7Qm729e5VtpQZCdRXDQIUAT+6Panr9tMnQnVV/HBJTPVjMaX09s+5wFhjaHCz5MVF4uPo+IQXtmC+Du/ubeRuN/px4wXFpxqeoZsSDwYupN1kTeZzkv89HDOaIl2ye4AhKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FMY3yF5N; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=R2KWgO+R; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FMY3yF5N";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R2KWgO+R"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66G3wNZY1299342
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 05:48:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PlfvgBp2CUMUGWsfegxHeutfqkwSpENHA/lVll+qXo0=; b=FMY3yF5NogrymTs0
	jaiHe+HyMVoUo/dQl+KvAsd+Mg+QHsSTO0gvKPripXH1M8IRix781ihlqk9I3hy4
	OqrSHxVU3saAIFBlZ8jORSFoqeJHrf6kmCqyxRrls5T5opcigjDve+pjb4llGPRy
	AB4RVaFw53MkOpF8+VMqNTxZKccBBXRbjHtcE+M8cK5yolyWYTY4OyTFlRUBV0bk
	SOMvb3jcuJC1okl+aF4Le8DnXNy5Dk86fB5bODOKT2dxnuDxGGOiAK33eueQg2tj
	L35X79mzACI8Hauk9ZQseJhJAmdlBOdiSpvq16dhPyPzV1/A3fbNCsJ/DbJnsqjd
	xGzV5Q==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fed062t40-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 05:48:51 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8f0867a75ecso144011716d6.3
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2026 22:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784180931; x=1784785731; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PlfvgBp2CUMUGWsfegxHeutfqkwSpENHA/lVll+qXo0=;
        b=R2KWgO+RMfjS+uOx0OPj37lYM2CKCXpjF5yfO9su2FJ+EILBf+0B16yCtv6WQSLuPJ
         n5O2ttyA+rWNKGRrhsTsSPleVaM7gIrCKEfmNHtr7mLtfdUNT4ew7OKl+arK5rxz2p5s
         6DBaOkKjGIjDB4Bbir/1oTwQqILPEfBmkE68/duXUl0g4yBaBOLp+d2/duADJRcY8Ejb
         yuH+pj6DaQyFZHDiAR/qhgVYS6tFUySmbRSw6uTFdhhhKkWbiC4pIG6pecnHIPp742l+
         kgNlkGAfk7cPtObwLs0AzTMESLy4nk4pBdOoT1gEyBFsgFL0ZVOR5m19g2LWLpazewCq
         VnxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784180931; x=1784785731;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PlfvgBp2CUMUGWsfegxHeutfqkwSpENHA/lVll+qXo0=;
        b=q3PuDrjIohc1zEEfFS6goNzu6F61cV6DFk39MTgpKZF7tGM0NRjOTQYli6OcQqewaa
         x93RUHBe/wr6PP5AjKsLNpOEQcOQnP7ZTfzOjNV8jOlMxUzXhxA9XPFtw8XfvyvMlssh
         I3FECSaNaYJwug8G/lGJd9LlPj1tvJZ95injn7L9bU3qtyVOA4gfgTAni91C3JKZtdHg
         pvnan6AomvTt+u5eoayoG+NMIf1miNMEDq25QtjqsPZPpQXaffcxH1ZlNiAsSHJGUE/M
         cph0ycKna5dHaLWSgiOgUQj+mPAxh4E3J4vd955HETyG9z9NoUqWzaalymmkBVMGzrZF
         Yx8w==
X-Forwarded-Encrypted: i=1; AHgh+Ro0wZsP00UziCRAtdl+a8l26OkDSKSKjtNZbksNv9zaDWmDwvBLmb8Lpumm2FDh1mSQTGe00aUR2Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZyBDg4037d01ZV8ztHDMFME2LonxFxFEdWzKHaFsLRiQzeXhU
	yeXUw2qZ2Saps7Hlt3f2VzdxXVVX2RxwOa/CO4dKcdEaoXjxWK4ImKhD2hTWd3861W1xeiWjk14
	Q+iZwSW+jkNZ7uwtOg+/8v/pYuxNsDbJtBHtLgMfSNTfklwwTZZGTc9oJEPTjmA==
X-Gm-Gg: AfdE7clBAEKZZP5cvyl6k2E64K9IK5v7lWaie7jQVFAzsQGukKoEF56tU5SYfUMDCIE
	m5RbgoHDsrFzH/KN7rkoOFFQp8TsI6UworZFKzKAdjXZm+CHnChJDNuwNfSmJbaCqlX3WCmlZAm
	stCsfpqGVfhMXfojK3UH4chRCxdROlChsHKmYXiqGQytnHA3J7U9MAyvMh1n7HQYvT6ZCBntfik
	aqM2dl5J46LzJxW4zz6mM0klPmyq5BJJKvXg8rqxLTzeSue1V9XpY2CId46Sb8wmqRqYE8YOqBm
	xz31KBbhSDZyTwIsJWjVkbeorMzMcArwcVjE8TLZi8IV3iXP8YW+2U+mQIlRFNr6OwLFurbPeJ7
	P+vx0C21ldngzhHyWJNAKfNlPaj24ow==
X-Received: by 2002:a05:622a:28e:b0:51c:7b12:5fd8 with SMTP id d75a77b69052e-51e4f12bb6cmr60374541cf.84.1784180930855;
        Wed, 15 Jul 2026 22:48:50 -0700 (PDT)
X-Received: by 2002:a05:622a:28e:b0:51c:7b12:5fd8 with SMTP id d75a77b69052e-51e4f12bb6cmr60374451cf.84.1784180930455;
        Wed, 15 Jul 2026 22:48:50 -0700 (PDT)
Received: from [192.168.1.110] ([178.197.223.174])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49541e9ac02sm29699565e9.14.2026.07.15.22.48.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2026 22:48:49 -0700 (PDT)
Message-ID: <5a69bb8e-8a06-4678-bf20-f0dbf76f47c4@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 07:48:46 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] soc: qcom: Hide all drivers behind selectable menu
To: Julian Braha <julianbraha@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        "Rafael J. Wysocki"
 <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
References: <20260711-qcom-soc-kconfig-v2-0-4a907e064281@oss.qualcomm.com>
 <20260711-qcom-soc-kconfig-v2-1-4a907e064281@oss.qualcomm.com>
 <9bb44840-c3fe-4bcd-af2d-149dbc2c7c8c@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <9bb44840-c3fe-4bcd-af2d-149dbc2c7c8c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDA1NiBTYWx0ZWRfX8cMMF4hTFrh6
 z/r0VBGnD1ijLDTcdaQOJnUCBjTCmA5UzibkPnPt62vypfkUBOvCId00OJqJyRaB0FDq7jjf4zN
 2Y60GjEJeVoB15J73OdopPCa6QzdM64=
X-Proofpoint-GUID: _Lg58dkYMEqde4j-oaUEDYcebyBQiRBT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDA1NiBTYWx0ZWRfXwpTbgnABBY7Q
 Pu44vc88NrZwF7XyqjtxQDUmp4hGZWkxYK0YsDJmNuMIGeOc/aMvERQiEwKI5DUzd8Q8R0yGDyW
 j5VFYwBtiiBCWaBz2LaGI6O9+BDWzZd/wtudo+1FlvqJNrBunZeElsn7xcst25Sx1b0yJKJJQrp
 rFYucUSSryfL2zVI+jqoNvb2tB/A3NG3D+If53keOBqYdkjN3deCIP/EI+Y+6bOmKAyCUDEGuLR
 hvgQ43QlVYwfrKRU0Jah8YuNAa83gwMrCxvH7LxPhCzSya2BwotLRYCXBzphyPeV6+CX1zLSeAA
 C3o9MgsWrt5MCslnNJ5A+2rz2EvEDRLFvoyMmP2+uveIEpShjiM3hR6VifAVH2/cawFcrK2uSEL
 0pOaBt2tJKuziBghwF4Vv9CSEhXDVVqMqOsN72SH7TAVqRvys3uG/EDvOgo20VaejeEixdqC8B0
 Zqyh1ZyoG2TN9rjn71w==
X-Authority-Analysis: v=2.4 cv=Xb25Co55 c=1 sm=1 tr=0 ts=6a5870c3 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=N6niishs+lR9UBL1FN3Qrw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=lK8Tr2M9iWliC4v-rQwA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-ORIG-GUID: _Lg58dkYMEqde4j-oaUEDYcebyBQiRBT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160056

On 16/07/2026 00:58, Julian Braha wrote:
> Hi Krzysztof,
> 
> On 7/11/26 14:25, Krzysztof Kozlowski wrote:
>> 1. Allow compile testing of QCOM_OCMEM, which previously required
>>    ARCH_QCOM.
>>
>> 2. Hide behind ARCH_QCOM or COMPILE_TEST drivers specific to Qualcomm
>>    which should not be available to other kernel builds:
>>    QCOM_PMIC_PDCHARGER_ULOG, QCOM_PMIC_GLINK, QCOM_SPM and QCOM_PBS.
> 
> I think this patch introduced an unmet dependency:
> 
> WARNING: unmet direct dependencies detected for QCOM_PDR_MSG
>   Depends on [n]: QCOM_SOC [=n]
>   Selected by [y]:
>   - QCOM_PDR_HELPERS [=y] && ARCH_QCOM [=y] && NET [=y]

Can you share the options leading to that? or config? Without
reproduction steps that's really incomplete report.

Best regards,
Krzysztof
