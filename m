Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5998734041B
	for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2026 09:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792141967; cv=none; b=uuFG1HA2FCzLUQYn8lvE8OVQjsClutzBDBs3nb/npqmz4Ma+fP3KIYWRrICANko6m/2A3l0gF7VAY+rNmUD4dAeW7uWTGPMZl/YO3Q3kG4DgevO/KWvznSCtgEMIRNYsYN09/1cH18rpVWTe2e7w8OzOSSJiPtE6hNZoT98lBcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792141967; c=relaxed/simple;
	bh=xQtH3pqs1wLQ+C9XdxZoFfK5bnVyIVslxRRCRhXb8gA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PyyPQsfeKkMdvICsaofWfKk667Ub/CN7mLAXu8v+2u6jZm+qVkhFKVdkj6lqsmX281PyxBDV/stGmPY4P9jeO0PobYH1nPaTsV092GZq1ykv3hfQ3BrOnYZtZIaP/oKGlOUGOl6VkKjpqbwTbZ/MMdKr6pyjbYXv0667ihyVFNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZNcAtXLZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MSkwzLAb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZNcAtXLZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MSkwzLAb"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69G8lHOI1797629
	for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2026 09:12:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4XwIbro7DtwnORF3AQbRr4HnKuyXp8n7Awe9lOC2s1w=; b=ZNcAtXLZFNkU7DEJ
	9chMTS2OWbmRoHdYRu4PvQqK6/KAD9M/BWBIlWL3BEZB7kvDCBoN2+pJ5swix+Bn
	uCSs3OMHOd7KT/Vme+O6FpFY+dzoAq2KC8PsI2Oka656aUCssCc6NTUpDUcvvSF7
	1Hpq+u2WYSwh9mQHB8vfY5OoKANKBAiqcjiFo86cd2uRRPeHhvb8rt/hrdLYzm9H
	mTLYqXVzrr1gYf1FrgQpaqfHdIXrCfJC7BnsY5ARaz9+ZW5rgvt6nk1QubiYEbmK
	0tRaDo121baqXNBx9bC1vPWyDCy5KR12suZq2e5/JTcQ6FmV59oztMz0K81jwfmL
	is7mQg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb8a89vma-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2026 09:12:45 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-917aacb7abcso16005826d6.0
        for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2026 02:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792141964; x=1792746764; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4XwIbro7DtwnORF3AQbRr4HnKuyXp8n7Awe9lOC2s1w=;
        b=MSkwzLAb5P9d9LXGT2B6mgiM3ZZHsj1A38qzoPhCWPIf+sCea+wBmGFwYGM7AE06/D
         tf6eVtw39oCR9zol3XiwQZ9cv5lmOe59Id6Iw5bYLIYeW7BLEnbeYfNVnBiZyItq89Sl
         1uUd5JmBZtrUfoYP3i8T0hRXAWmtbyq3IFXReorJAABhy+Y1uuplgnc/BYTsaPCd93TD
         sGSkiHUba16xhofL/gzAcUCslJkqD9hGSmN+fniYrkdtn/TFpJ1g3W5d15itLy9RLVJj
         BdwWK3Fb9Du1HhH//4S3/f0THhiZgRfT9vahZneHpvf3xLfl2LBb8GQGF953b50nuceq
         j2Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792141964; x=1792746764;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4XwIbro7DtwnORF3AQbRr4HnKuyXp8n7Awe9lOC2s1w=;
        b=m8zzQ2vI047+ocTwxD8n81uogDsjVrZNgzaifgiDGMtfgZK0x8QskH9yg7ZBHgqTLg
         84n8HbFkIWURueWixGB3ynQpYBUFogCdLrS9eP+CuPzQFplCzsIYWK9OkceIQ2IBVOzN
         oOwVR0lRUg3B7nsHK0b+N/EFLo9iilpMM/dnHaUXbf2X8PZxKKyBrGjjzxg7LO66fJWO
         xGRxAR5CPStRyH79hDWXHQYK1+To9Ybe48RQGAfO09VAHScfzH3fBXU3Qfl+RwgkfUWR
         B8ppSk3IGb/I1AKDLumekAj65jmJ1VMa1YAFFopp93hGqpk+derrEZHtl1rPQa9H2Hvb
         P8iA==
X-Forwarded-Encrypted: i=1; AKwUvByp2BG3ep+7xXJRzRNAPRzqCdBpz4Xr44AhVoBpUXCwkcaxTJsCFgVKhCdt1GXurM4Xr9+3XKd3vw==@vger.kernel.org
X-Gm-Message-State: AFq9FYLcGbTSDoga6Ld/k4/qciHafizzRDy8E6s0BDnApMxgQn5IHEwq
	kzFc3W1DUQ33AdiAyv7nVLamZhfUvfvbjjDYHNelxfAq9+rnKZj7EBPMkuB/YOXWqqaE0kJj8yb
	lHNHYh+T+v27oyRNdaUCqxo1azP5YFfrJAjBUWLL/lD6mOOMzZN10tuqb69kUHw==
X-Gm-Gg: AYBFou3aYJ1OExkYWJJYTpR6lNl2X8/6qnzgT5kCvGzTcbSRD7E3kLch0QKAL3bE0m0
	ekDLnzAnBDVAFc4OHtUp13ak96EpTgUnq+FvZDzxVekRqcoJ+V3JbwN5O4PUDoYweeENsuVlx59
	kJz7cQZHjj6HrTGMLz8JhLGyJcH98DUOysvly+ep9Xw1HIEYkrI0imJoM/oPWz3SqGm4d0XftW3
	iMxOGMkWQ0hhe/3pY++rYwV78vwVDBIOvIQj5yGWQ060NtKk9NY1i8z/kg06A+IDD2QZ9H5GkSB
	YX6lWnZhcgy4JYiquE9wzYLJJhWzrKdzA1xB708br1KKpjv9cfmaStajMocRKGtOwk/MSHx01mz
	3BG4NipVaiaMkIy1h1vF9wg==
X-Received: by 2002:a05:620a:ac16:b0:93f:1a1a:2974 with SMTP id af79cd13be357-93f1a1a2a48mr240084785a.6.1792141964296;
        Fri, 16 Oct 2026 02:12:44 -0700 (PDT)
X-Received: by 2002:a05:620a:ac16:b0:93f:1a1a:2974 with SMTP id af79cd13be357-93f1a1a2a48mr240081285a.6.1792141963792;
        Fri, 16 Oct 2026 02:12:43 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c408e32874bsm53526666b.9.2026.10.16.02.12.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2026 02:12:42 -0700 (PDT)
Message-ID: <8bdedc8d-4779-46e2-a56c-1139fa5f38a0@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 11:12:40 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/3] power: sequencing: qcom-wcn: support SW_CTRL
 wake IRQ
To: Linghui Wu <linghui.wu@oss.qualcomm.com>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261014121910.1509541-1-linghui.wu@oss.qualcomm.com>
 <20261015041241.2186521-1-linghui.wu@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261015041241.2186521-1-linghui.wu@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDAzNiBTYWx0ZWRfX8kl/HK7suFtP
 Jpv35PS7fxfObo6NEQ6nBTuVJ3XqQCrCW7lZEUArUGz5xx/NhWMk39rPVBDyN+1M3k7ENBwX12e
 HWPJMQs2oqgkcmz81H/eDOlnCsJopdA=
X-Proofpoint-ORIG-GUID: tPoooIQV6dLKSDt0Y9F6NakRCq4d8-3q
X-Authority-Analysis: v=2.4 cv=GJadgeNK c=1 sm=1 tr=0 ts=6ad1ea8d cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=uwVdFEeZ8PiR924G3bkA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDAzNiBTYWx0ZWRfX9p/aFEavYDKE
 2qZIOp5fLjiW6rNbcP/0MeJepwB4LCUfqNoC6W8ol/RXh009RGmOeZY+6fNvB2WtTfqZxK9lUJ6
 mfmL4LO+/WpMoha/5WMBYbO9DX/av5M/2DWtoJpU7EwfjKhEzruwjIbiD1E8xBITi1ZYvH1DOYB
 MxpINcMocOsXmxV2dNr/jLGJ8d8aAJJLa5grhIKV9zZN+9WlmFyKDy9JBgJok6ZqJ0+hcWMVrOm
 YaGuuOE4z4RS7CnRe7Bl66yt1Af8UPs6KRDY2WEzFNoNrgcoK/2cylxtCiKQVNZWmfGiME85/+v
 jRROJM2BSMBEqB1yjS+oOdQTYpNUA3aUoSdxV4xl+Js+rD8cb40VkzQfEgmQkhfEAHqB56Whpnd
 2fP4McfI1OaWX/9DMlPfMWmL0nxQpjySnagx/TD6RfSAriiSfjBmAKBP2Q3TIi4xLzxy9GEP1w8
 v2KdmHJxdPVGJ4opQcQ==
X-Proofpoint-GUID: tPoooIQV6dLKSDt0Y9F6NakRCq4d8-3q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160036

On 10/15/26 6:12 AM, Linghui Wu wrote:
> Some WCN3990-family devices use the SW_CTRL GPIO to indicate that
> resources must remain available while the application processor is
> suspended.
> 
> Teach the Qualcomm WCN power-sequencing driver to use the existing
> SW_CTRL GPIO as a dedicated wake IRQ when the power sequencer is marked
> as a wakeup source. The PM core keeps the IRQ disabled during normal
> operation and arms it for system suspend.
> 
> The series documents wakeup-source for the WCN PMU binding and enables
> it for the Shikra CQM, CQS and IQS EVKs.
> 
> The series is based on next-20261014 and has only been build tested
> because a Shikra setup capable of booting linux-next is not currently
> available.

$ git log --oneline arch/arm64/boot/dts/qcom/*shikra* | wc -l
41

$ ls arch/arm64/boot/dts/qcom/*shikra*.dts* -l | wc -l
9

Why are we carrying all of this code then?

Konrad
