Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C13B2FFDCB
	for <linux-pm@vger.kernel.org>; Wed,  6 May 2026 10:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778063258; cv=none; b=YhfWICGIwCVI1OaXpfKBkGDnBLcOGhHxJTLxMUiNpt+Q9Hho1BEw+CzHOCEUIrMWhrIee7UuAREGZzz1gd8IcDyCdmaYXWeBF2SSan46bWZlDHESLm2VzjulEyFueVJifALW57pQZtlfn9KAk4OM451k4PM1n0b/pDNkd7Sg5o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778063258; c=relaxed/simple;
	bh=nmDqBEuuNrd55Xf0EKOMVEeQIuKmfwnGUnA5AYldlNU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=in4wU5ZuYxSAAfPsVBfoQuY+c4dKUUSkEesHne1v0IzK15+X9f3QL0DaHPJprHZ/DJPZiJ8pZoakU1ccaKJ434/hdENDMDyEexZdO8ilm1sWv3u1b/DN74iDUm8nZyFsBgqbvcyDPwCcFZSIRuhemk11nhIdiBYi6rXEXEKZqj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FQXRtTCw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=X0Ytu/hS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FQXRtTCw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="X0Ytu/hS"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6468ZrPV442617
	for <linux-pm@vger.kernel.org>; Wed, 6 May 2026 10:27:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BsZLiSX2Y5MimoIZwLQ0CXLNavG9OJUKdcX3jVhpm9g=; b=FQXRtTCwLZnb0KTo
	A8sQ23tDcmxK0ajaw5PkJorRHsaGeX/gk5Bc1s2oLLkXKzfzCTbg1KtG4kK8Smgt
	KJhe+qAKkMLcD5wy4fKFQfWT12EvkP+aV4M3gpSb+iIfjf5xikUJvbVbjum+JMea
	s78QQr86xe201fPON5H1pHDmUZtl/Ej8TwDFHVN3BGa38Z4Mp0fI0uvIQ8hO4ckP
	v3ZNhAbU0DBeOtO5DjEgMxT8iLFGZ6V5KIx3Omq94RulUK40LZklc5krb06uR6L3
	72JUddchXTUG8XIooi55X7r/IwfRmb9wEuHrcuk7uco3VDWcojV9D2PdSQW6UcBJ
	eOfI2A==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0299gdkm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 06 May 2026 10:27:36 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50fb6d713ddso116938871cf.1
        for <linux-pm@vger.kernel.org>; Wed, 06 May 2026 03:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778063255; x=1778668055; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BsZLiSX2Y5MimoIZwLQ0CXLNavG9OJUKdcX3jVhpm9g=;
        b=X0Ytu/hS4BlmPX+pW2t8sd2fxUYyIplv6sRVU808FTc7prIVxy8iAh/NRgxkiSyrOB
         opIyinhjyiVLa0OEzwziuykHOw1vabGWyGPMzyqWrbAJ6tEmfcFIqxsqaSpVUxBdbygy
         M2B8+dfbRAq2SZhNIMcJrrAiI5noFoovgFeBwqZ92t2sOLkUIo/5RqXeAZHEfXkVAb9Y
         lv+fKbhB8jY/xa3uEal/G1c6ZlxEGutG+Be0C1UZDi89mwqIWFBPVpiH7+e3Q+DICI/x
         y/EnZR9Nn7q6cRApJ7idG1Y72k4ypxzzxB6RmE8ZjY+wIOIq5LBsVbSIPSVLMvBiJUVg
         thug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778063255; x=1778668055;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BsZLiSX2Y5MimoIZwLQ0CXLNavG9OJUKdcX3jVhpm9g=;
        b=GiT9ipgepukrI20gpzsHE2OwQON6sax+IRRS9BXIB/YGg80PBPwPbXaoq9kbWAq+IZ
         0XLNuotDkVIynw9UxrOjUE02UOJKSVcWczJYD6eAJymc8kxBS1QjFkqIe8i5XuvtDbaQ
         k1I1fpBPtso1ZkyUAJpSK8wKXzTBS19ZDThxMuyZyC5H7wPFyQFJjGmgFkch8x/IWCJO
         uzlmQsqXvd8W+VgOw2jEuHjBsaM02LXHIEMMv+lTrX0/YU/23rqGznpMfd5mun8+gJNg
         /KGfn0MMynztC/T/07x+Ed4UeJ7n719sV9sXPB5v9F4kmHDpYLdI+tBTLeYCmNXDHuKu
         YVHA==
X-Forwarded-Encrypted: i=1; AFNElJ84WxuscFr4sdPADihcFKLf06rG6EExSIXE3QSikaPKQ3CpcebgFqsnyHW/zYjU92H8hgLGyjqW1Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyfgWlg3Au8DFYnHWvPg97v4TjVUyxcGww89Bs7lIp6Gcfypx93
	3ldTdQudjqERbSIlBXAnG6VrUafl7ym8kE+nVyuW1WfJzUCyXV3o1evflPfTWCKWvprMuZu2xt2
	VNxm/5DLJAxhaXnSqkql2rQaAPnevYgGR/Dy9U/4HOgf5cCH2/UbjFMO6voRfpQ==
X-Gm-Gg: AeBDiet/Hk1jPCScs9mDq3388VkKmHRturf2q+pESlctmGNlvRFoicqQJvELBGbk9e0
	eqUd2Ped1IurHQpD3DoxjUChFfor6WmVxS1GaX2n1ZzzDSstxdo9/aQ1L5Hjq8+FDTNWeYOrqhP
	SISC5J6Ymq+r6vp6j76DdIvMLpUc0iP08dQIZihciv6o7r/xp6f4f5HzBHWI5r2tLSmMJ8k/pmt
	80Dy0dueQ2t3RGI4vAMTVFLMMxHGrzVYnb43hVQ4j1fHh/S+So/UT1PKBwt0hDJflN5mNdArime
	8WebYYHT1Vn6U8ZcJweqvGoOiruFrJhI+dZm7N2t+FyZdyapWiYWEcvrOjyolIrERwbvupPpDgY
	qawXfGPAIbY+kXxf6DS2TRNGNdm8+NZYpk1avE9RFiTLmC7EsLq+9BAtuibL+mTHsfe6UShPmdX
	pIbM0uoR7oag/KsmMWE0Y=
X-Received: by 2002:a05:622a:410f:b0:50d:8080:2a7 with SMTP id d75a77b69052e-51461c268b9mr42610701cf.21.1778063255517;
        Wed, 06 May 2026 03:27:35 -0700 (PDT)
X-Received: by 2002:a05:622a:410f:b0:50d:8080:2a7 with SMTP id d75a77b69052e-51461c268b9mr42610431cf.21.1778063255124;
        Wed, 06 May 2026 03:27:35 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:41ef:7b80:b3e8:2c1a? ([2a05:6e02:1041:c10:41ef:7b80:b3e8:2c1a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4505238e174sm11525885f8f.1.2026.05.06.03.27.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 03:27:34 -0700 (PDT)
Message-ID: <2740bf17-27b5-4a68-8eaf-589252a84436@oss.qualcomm.com>
Date: Wed, 6 May 2026 12:27:33 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drivers/thermal/tegra/soctherm: Use
 devm_add_action_or_reset() for clock disable
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, thierry.reding@gmail.com,
        rafael@kernel.org, daniel.lezcano@kernel.org
References: <20260424160019.41710-1-daniel.lezcano@oss.qualcomm.com>
 <3075fe5c-e8c3-4439-be5c-0f6eb2fb6e48@oss.qualcomm.com>
 <d60b7b44-37e4-47ae-9af4-0c8d24b6c599@oss.qualcomm.com>
 <c45c96a3-535c-4374-b9b2-cf75240a8b05@arm.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <c45c96a3-535c-4374-b9b2-cf75240a8b05@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=fMMJG5ae c=1 sm=1 tr=0 ts=69fb1798 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=7CQSdrXTAAAA:8 a=q-kRPO7bpnIDiy-Y-2EA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: yPEgQTUs2vMCtX8lavAQ0Bu3ey4tK2PV
X-Proofpoint-GUID: yPEgQTUs2vMCtX8lavAQ0Bu3ey4tK2PV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDEwMiBTYWx0ZWRfX+7H5xmLl5Zan
 RUhOtMlqLU2cfmf9hKHJ4Vq4HHuD2RuQNGyykKMooaiTjV7pjM9Ri4++BDGa5ReDac+yW4wZfZH
 lyra+jbcajHLxR9tWekpjtr/gFAGxBN++9HdbsXnQgXe7mNcY7p5d2vF+8sNXjPrGDO/RuJKNxl
 EYB8fRARZEzHBadeECXdWXp4yTVeQdcqyhJQAHXScDPU6ep/RlO0ybpzvrgBb4yNcfO06FAgBSw
 PNvzicEWAJufdp90oYQADwPXnx2AmYDVM3sCtx1BwqIxv9oB2USj3tvxxjj6dYL08PqAh9/jX32
 0lY6ncJO+Olwj9RdyZIu4pW/QmfXSGRVyEBScw2gNhFKv6HZe3LTwN0Q8V5V7eFni1OFhvmH2R3
 BLy/rQ6LprNpLWqwkm2leJxjpjWsL4V3AK+/QCgC965s7yPrKR37GhRDBjbTXFfRsm/flc7Ewv7
 3H8lYu9pHAazld4qxMw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_03,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 spamscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605060102

On 5/6/26 12:26, Lukasz Luba wrote:
> Hi Daniel,
> 
> On 5/6/26 10:37, Daniel Lezcano wrote:
>> On 5/5/26 14:10, Daniel Lezcano wrote:
>>> On 4/24/26 18:00, Daniel Lezcano wrote:
>>>> Replace the manual error handling paths disabling the clocks with
>>>> devm_add_action_or_reset(). This ensures the clocks are properly
>>>> disabled on probe failure and driver removal, while simplifying the
>>>> code by removing the explicit error paths.
>>>>
>>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
>>>> ---
>>>
>>> If nobody is against these two changes, I'll apply them
>>>
>>> Thanks
>>>
>>>    -- Daniel
>>>
>>
>> Applied, thanks
> 
> My apologies for being late. The changes make perfect sense.
> Feel free to add to both patches:
> 
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Thanks for the review
