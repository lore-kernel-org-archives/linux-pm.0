Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5E04DA533
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 15:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784647186; cv=none; b=cBUj1MFBLStOzx4Y5bK9aMcUqheWZDOCAH6vaMgSqlXdFiGYoAqp/CshJH5a7AvwxTXEMaxXncrn64DG3syhH6s97MAUj5bM4nqkepkBPcduqWRx9WJMWCIXUGOwBMHCdvyrEUu9Ie0qFcrdGhg4zNQDs/QFBFkbH2YH0haRPOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784647186; c=relaxed/simple;
	bh=R8sR4cqsPipci1y67lqmSetpbPF71MsFIqVHTQu8qYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RMpjRF5Xyg1Bh7/zQ5PPoG1y0UskvywdzrhEcYWh81F7ClTz+grnrGH4WImn8rzCNvDBj3U3JWxTEg3DUusb7kLOWYu7LivLzt38y3Ig+serCK/5wv8DIOeCS7NRUtcaiGjSWJt+bCuODKFp+9jfsFgYBYN2t8MBWWE17ObTn8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cEPo/tUb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=a0vkp29I; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cEPo/tUb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="a0vkp29I"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66LDg7K71939379
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 15:19:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BeImWg3UpWEBMTVyVBkk+sdUXk023lo4rqYx6rHHQnw=; b=cEPo/tUbvol8NMA+
	CZkSAHloVdMHHr5+U2G+q722fHaDvdc4HKqrvQ4qwn1LG5b1o4Z9TmLNWjzTm6ST
	1c6DgOl5JYndkk72KvmXPunEmrKqA9CjCq6d0mUfXKj1d90YBaxPzE83Jv6AXMLM
	eYy1j+lUhdFTCtHRoyLSonfXRyEoI8LjuoZylTqfzTEboxKBWnBrB/E3LdC/R4nO
	1CSk9598XVIM6Z8vAQsVuEN72RU+Agui/hPDmEPdDj5Wf+xjEW3a3K416mDsexmq
	aQD81ZcFw6diUNwz/YuTCNi9yLSZVLT6wAeBES9Kncn95WqLtl4j+ryPM6YYUVq+
	oZ28nw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj9bs8n10-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 15:19:45 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51caa0b48ccso20456191cf.0
        for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 08:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784647184; x=1785251984; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BeImWg3UpWEBMTVyVBkk+sdUXk023lo4rqYx6rHHQnw=;
        b=a0vkp29I1EWFhtAOghLTMwbS4woz4y5rCOr3ySimRlXhHs8f3LnhMHHKsSr6v75yD6
         4/NT9J5DMS7kcly1vcObgEGgFbJzkB6cX71f7FmNs1koPH6IDg94AhSsjTUl0f3UPgNo
         fsWGY3iNm1VgRyR0R/8QYPw1BVhlOhObcJ/Xa7WAfItJ+xrP1O7QsYbsXjJUfU8shWJP
         37XVwlgm1n+DqtfJOMitFlNQi8ijjCCwfFLMImh86GIIpoNcD03fGZJ/v6RqCChAw+V4
         JifI5AceOK8LXT03vEClk1azRb/VTRvccIgblzOWKTaOw/OY0xjAtt4px/8lCTflecqY
         BjMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784647184; x=1785251984;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BeImWg3UpWEBMTVyVBkk+sdUXk023lo4rqYx6rHHQnw=;
        b=DGZf+MGWMrPrgK/lb+O+c/Z8iw43f1SpptBsia4Au5zQVBi8p7pc2bYDOqLXaY9q3d
         8aqGf79BFGpX8pvjbKgyO6GItkHDxm8vFLLVyiVLqLE9mxKfytCOU7mf6iwd4GWuBW9X
         ezX6yjlw1xvYnfdVOi5ih9PATAK2RrRlUbfdnyZx5Q792+Q8hzXOOtDJNW8OOZKOLAIb
         yw0qbrIa9CcalrLsaneV6C+fsL4pkaEVzJc2805l52W8hGnFR70ySx/E12Y9QL+VWWTL
         iRadPf1Uzv2/99o5uXWSrCDQCAL7o/nHAfdNf+vkmH2Nr9HSY6oA2+AzldusZ4iumGp0
         RMMQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqhw2vgAzv3i5OeFT2jUC8pfVbdblK630kmmj8ZpTIt+atg+Ner4rQZUP7BHrSh+xrJ9iE247hEUg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzMEZQeevgB65EVRLrZ6kZ+lFIFErfmXqxnWTSFP1FxrkEsx5L6
	Y5KF+ZM7yh5Exq2F5R7hFjF3kGrBJLdNAB5VRS1Buot2gv2NJpuE6ncPfPMJc4e/nkHPcKgYr+S
	rBZkCGxfaYSQp+VDYgBYtgt+qB7fMDgbIwR774OELTHjzw+ZvibmjPw4OVCeloQ==
X-Gm-Gg: AfdE7cklS1a5RMyzac2jCsd/PG/tBmG0N6+RYAYKt33NsVpl2HybxJGeUnBNySWbmvS
	Nk9IMVaMLBe6Ml2n6R5aY2bnOVsYJi5VM0IOZe/iTTZKO21AOD/PZFCNCaH/+7FTCNMtBYKRJ/g
	ugOPrl4o55y7t5e5taJCF6EIe7tkcsBG72S4oEmbV2Spl2rxf8UgYaBBu23S5w1ggUoVRbOBR65
	0EA7qOZIPOUawvP6v1SVj56jYRhot2aNJ4f5fyE9xS1EmIAUsJrcZxK++/r4i2zgK0+c/UIMpGt
	KnjlMSYB0vVBz34q1DwqoUqe7eJAKtZUwYxqEOHOtNDinO0aeV1EWmMjkYyjS5nV0SErjhB71S0
	7NWwifMm/c+S9WCVrlcruGIKS
X-Received: by 2002:ac8:5d8b:0:b0:51a:8c9c:7de0 with SMTP id d75a77b69052e-526750fa557mr26892981cf.10.1784647184069;
        Tue, 21 Jul 2026 08:19:44 -0700 (PDT)
X-Received: by 2002:ac8:5d8b:0:b0:51a:8c9c:7de0 with SMTP id d75a77b69052e-526750fa557mr26892621cf.10.1784647183431;
        Tue, 21 Jul 2026 08:19:43 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1740bf91bdsm587290966b.63.2026.07.21.08.19.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2026 08:19:42 -0700 (PDT)
Message-ID: <180c27a4-5058-4072-ad23-709ad6d6ea0d@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 17:19:40 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] interconnect: qcom: Make important drivers default
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20260720-interconnect-qcom-clean-arm64-v3-0-942e8ee7ebda@oss.qualcomm.com>
 <20260720-interconnect-qcom-clean-arm64-v3-1-942e8ee7ebda@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260720-interconnect-qcom-clean-arm64-v3-1-942e8ee7ebda@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Yv1s4AezwjEG6ZLshUHTDnbhTyER5jmE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDE2MiBTYWx0ZWRfX5tBlxsDJOq3T
 SD8B5nSXuTQVi2F8UXeQHCmqAxmDx+Ql8/gEStINnR1VqqPsEYGHQZwpuHM/8Pyz7dSezbagM/g
 9cpBwiDDEPvT1knUMrA/PoCp0374Ac1lnQYjkyuWo11uMaRe8vmCNwlPtSL1RFJ1XZHV5gvmu0q
 HfWUHBgH8J8btsZ0hWNy6vXV6n3umvwRSDAelHiI4Gy1rjs7uDADsnsEaYBNjjAuBqnsBUQdti2
 5fZ7BgxTc3wR0YSCcjdATxB63nbqX0CC0X9sjkML1Tx70lA5jw4/Mo2NcLOtUVyAL3sA3wrTHoe
 draINNxgPInss3vUh8iIww/2nmvisiEVFViIaXxMTE67vr09pjrulBfRGQx5EoktqIWlKJxm24w
 hACl7nk4+0mW53pPwSLMAaiN61yqWulD+fVAd3MqBAUhA4MNqTx2Yge5bxUV3RmRG9gyr+38gJ+
 5vM86SEHqxM/oweu5Kw==
X-Proofpoint-GUID: Yv1s4AezwjEG6ZLshUHTDnbhTyER5jmE
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDE2MiBTYWx0ZWRfX1AgmSwpz77d5
 X+brcKW7MikeUjEPdZ/xqsCHkhvR0Ow5fY6IGqOFwGwYn+YBG/6uC1t1mIz2BS33qsKkV9d1qfe
 JLHIyXaRrUx9kvkEl+FxCj7aeh+uWyw=
X-Authority-Analysis: v=2.4 cv=QK1YgALL c=1 sm=1 tr=0 ts=6a5f8e11 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=N0nv3qFBaOOCOp0HD7oA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210162

On 7/20/26 9:03 PM, Krzysztof Kozlowski wrote:
> The interconnect drivers for Qualcomm SoC Network-on-Chip are covering a
> basic or fundamental SoC feature: bandwidth management between internal
> SoC blocks.  SoC can boot without these, but power management or
> performance will be affected.  These drivers do not represent any sort
> of buses visible to the board designers/configurators, thus they should
> be always enabled, regardless how SoC is used in the final board.
> 
> Kernel configuration should not ask users choice of drivers when that
> choice is obvious and known to the developers that answer should be
> 'yes' or 'module'.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
