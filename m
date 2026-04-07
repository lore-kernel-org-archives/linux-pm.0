Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBC13A785D
	for <linux-pm@vger.kernel.org>; Tue,  7 Apr 2026 10:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775559247; cv=none; b=r/ft+mQjylMR9DnNrEwe3sjDi7/5OScnf+zpUif/csHmxDKwHqRF4dx1lv32archSDPoyqv8KaZSkiOuEV/2tFgl24Ili70Fwf5EZD8YI10CkQ1AIHKZ5+bnu/eisazswgvvXOXo6QofS+jguujFUCGc2KWpaZQ0Ke8WeYKmXGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775559247; c=relaxed/simple;
	bh=cDtysJFCTVlhLCi8K7fMRs2yFDSXsxiLpHPhAa2G8wk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E7O1ZY6fRpvzb+5VHV2zBJpPX59JXkk3hiVazsK4qILAWTSDkD1R5zXZV8DYeixDvZZW1BTCLhjtgbABwX7owZYWmuiszFmkJLxcnekAlHg76phNr+qh27KdNUnO8xNcnYj9te15IffPyQARKjJWRubhLOAwLx7MzRx6HwxGFmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C5e8x0wC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JfsQHdkE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C5e8x0wC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JfsQHdkE"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6376Zkx62549950
	for <linux-pm@vger.kernel.org>; Tue, 7 Apr 2026 10:54:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CPhQgmTX2jRBkQjnSifEgvXH19lDzdJqEWxJWe2dowA=; b=C5e8x0wCsE7pASpX
	EX9J1nM/LxbA5gFqR9nk5PRPJXjgcOw3Wss0fKWlDDKAdI+qE695J36Vtl4ZR76n
	Ha21Hgp3G7o4jC4UieYwjkhP4rvdTaNgQPmTYmAPYIEh3dmE53AIitFJZTZo4B4J
	wQdYiGWARC3/ug7A63SVWc1n7e8unPgvw6ggUZ1GgNKjUsysE4BRmM8l21Fscwc9
	XSylcDGPl+fksafYsfex4+SEOZXyjrN0LL4qtRto9hW6Qy/UnHvfRK7tHQoBu/H2
	dvyXu2kQ5FqfJSQtMz1yHCPIrTOnkiftIDqBvb2b53CYUcErVmQ1vw6xWNNu0rAe
	pZ9J7A==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmreacvh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 07 Apr 2026 10:54:05 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50d7128e038so10401391cf.2
        for <linux-pm@vger.kernel.org>; Tue, 07 Apr 2026 03:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775559244; x=1776164044; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CPhQgmTX2jRBkQjnSifEgvXH19lDzdJqEWxJWe2dowA=;
        b=JfsQHdkEgobnULVkreiVrAUAmM3SJIwefzeBr32iORMBQSipa2Z9dD2qGHBcOGVXGY
         VWRL0U/69FgtmIlDylONR+ELPSpbw9dH7VtseINS5BCvvt1xChjc+H7xXsdS1DG4shnk
         iHI8zcIeFA+slBMHEgZnFcD8xyQzWYMOkMjHaKQpBiQ/34UasAqn9F2jkEck1to2oDm2
         7wID0n4swhY0zyeymDhkUa0xAhabbS7UdGXvGTPptopCZeCZ1nNp7ARDWIv9vrcSLlfv
         ftx/CdKDy1qeRu41gLLIT+L3ulMBAYQNcaVhm4xYxOkbvFTw01Fh6EMWBD7Dsuz9BRQO
         KH4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775559244; x=1776164044;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CPhQgmTX2jRBkQjnSifEgvXH19lDzdJqEWxJWe2dowA=;
        b=l/bACYt3Lz/rWfSmnwlaxgDevcvcVxyb3yCBiIDp0V3gKdvMhLB/hH++778ZO+YYF1
         J3qY5XFvywpfkCBY6pBQv8iELglEcCOazYkBGAZdpMxq591JeInYIYd5tffkpSEPMRcE
         9O5sTLVR8xxK/Mv/O8qLVt0qtOClpZYYUpOG3hwI2i1ImGd3bpAqO1OSQeWnKIazfLBa
         qiyAwyUhuvrDFubhu09xPn96XX9kbThYMtDaxN486mRW7Ux+W+YTb0o2yJCpVWLc29ZO
         VR7kzHwmLRg8ymjs03x+PUfGtK+8mjGOwFxQ1hmi7eICLz7ja8Af+ngFYRdnxGOxQAxa
         uUJw==
X-Forwarded-Encrypted: i=1; AJvYcCXLJ6/jgLwZhy/HNjd2t0wRjNaAH6rAHpMha+JYKR5DLGFj5cL/HzRHdXH0F6AMbqverpbGdRNjCw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwbbInQ0N0pgfnTI4MVFizqzHEjVSCAf3IvpdlPf2+OgQJT9LJA
	YIWGiCJS6HzdVJJ8yaH/u2FvUwnyMxmi8/tqSHTW4m9P89VjKuS4DKR761u1wAzemJvAxwIpz3o
	FFR27GKJCjgJj85ftYmbihExyyMZD0TT5o8iuqZwi/JvNGSAEyptlITtKNj1+xQ==
X-Gm-Gg: AeBDievzEeMdOmPeW53CQqMTqChWd8vtERLXEQ4Ft6s5/QEfTOfkH3BEwZsmi/wqHW6
	a8JFC0sHMCzkzGF8/5kRJnXpxnOfcMfSIQurJZ1rqiidCOQmT5wjI4//nBSsxm5tse7HUcH17j7
	WTMYgWLvSMk8kWl23EUbSdPD/aMIlbmBBI/bfbVdUuTf70ahgFnk4JNmx1aFDLOtoHZl+Ma4wH8
	r13Rq7ckstFq1Hm8zPOWGkCWSoAPG+L61CKwW11Qbc4pMmEQQ6he5q9g/2I5vpgDAdyZJlALg95
	YpIptTiWSS57BCnn15G3sbBOghpaLhUj2nO+18xLZOK1gumPOpX+v0Ln2PysHtgQ7d/U3wqEPzD
	O3XIJWlvuPCX2PLBM0MuijzB96W6y/lpLOvRd+GePY39aQzT7iAL3VrMX+ObATp7rKz74lfqCIv
	31d64=
X-Received: by 2002:a05:622a:2b44:b0:50b:92cc:f879 with SMTP id d75a77b69052e-50d62d201b3mr165487971cf.7.1775559244525;
        Tue, 07 Apr 2026 03:54:04 -0700 (PDT)
X-Received: by 2002:a05:622a:2b44:b0:50b:92cc:f879 with SMTP id d75a77b69052e-50d62d201b3mr165487681cf.7.1775559244047;
        Tue, 07 Apr 2026 03:54:04 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9c3cec58f1sm551798566b.33.2026.04.07.03.54.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2026 03:54:03 -0700 (PDT)
Message-ID: <03f8cfc9-4e62-4181-8108-7cca4d48445f@oss.qualcomm.com>
Date: Tue, 7 Apr 2026 12:54:01 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] interconnect: qcom: add Hawi interconnect provider
 driver
To: Vivek Aknurwar <vivek.aknurwar@oss.qualcomm.com>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Tipton <mike.tipton@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
References: <20260406-icc-hawi-v2-0-6cfee87a1d25@oss.qualcomm.com>
 <20260406-icc-hawi-v2-2-6cfee87a1d25@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260406-icc-hawi-v2-2-6cfee87a1d25@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=OKEXGyaB c=1 sm=1 tr=0 ts=69d4e24d cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=X2bA-DTC1ecWuKQBpGMA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: IypXcl41GNnLJZbgH4qgpWD-_61GfcGI
X-Proofpoint-ORIG-GUID: IypXcl41GNnLJZbgH4qgpWD-_61GfcGI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDEwMSBTYWx0ZWRfX/I7Q6EBVsl1g
 zvfF+RJwFb4FTlHw2ZMygCQfkuA0TsX/xyRkY+iKPOCoKJBMMVHFcnYzaWrezQ3CRwHnPgnOdfq
 KyxfVMleoqe7AL5gt88xaB2C0GK61fdelYw45Dw6VjEBoeV1FMNr7b1coGwUg7PsK9PbGcQYCwW
 s3+Yrel1eWwaczJkj37tuUmuBucYPm3AJ7fJvU1T0hLUPRB+0k0HUqnmnrkWGN91tsqFu3KfOVJ
 SC2RQMtNAJQckCUbuT/iOYoEkmqa4jiHeO2UPpPsCrJcdUlTo9a75sHGC25nPKm2W2K0ZiXy0MC
 PCTH6VhwyuQlMUD89rO6+PwIgFsXL1JfB92yy2mIfnH3DyroyFQM6oMDmeXLBbW3pEA4KwrxAP9
 51EQlvHLA3nbzomxgfOvFWGSch5tZ5K/6BivI/Nalc0eWXo6Ha+hMD/bbGgQGpley5FF/IEza9g
 ZwPw7MnNZRAMKX9IbJw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 spamscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 malwarescore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070101

On 4/7/26 1:04 AM, Vivek Aknurwar wrote:
> Add driver for the Qualcomm interconnect buses found in Hawi
> based platforms. The topology consists of several NoCs that are
> controlled by a remote processor that collects the aggregated
> bandwidth for each master-slave pair.
> 
> Signed-off-by: Vivek Aknurwar <vivek.aknurwar@oss.qualcomm.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---

You lost my and Dmitry's r-bs from v1

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
