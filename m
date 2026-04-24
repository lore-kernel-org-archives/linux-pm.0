Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70963BED75
	for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2026 13:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777035676; cv=none; b=Wwgi/xXOAxe/hywQyB5wNkz9a/Bfh7c/P7tZfmvYjRcaiKL62NyEXRDdKtPXs6XozcCyFFpfGrzaOmqdgfqalW6j5gtgUSKZlfBQKxfmq0GO7QNfU66EQe8S41LHTbHNVsVyHsyN8kX5HIrUkDru++X4ZAr1vk63VoSEW5+SCLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777035676; c=relaxed/simple;
	bh=I2R8ytEugiAGPrNt7U62aL8z9WdGGmhQf4Or51QTpvk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pdBhrSyuCoq0G+8DK/Iet6UEViexPM/6K74slXxN5VTcHjcgsDJTsD/RqcodaUXbMZ3iGyANVRe0oG5+K5iPGqwNpOKn2mc4FqkjoIpQCYe7PpLZMPVwnw+eBUaiHffUExk8xz3Lfm8M7+DUeCl/sYIgTr/EBISfIfSTwQgRHUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GKPf/YY5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XKVFjsNC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GKPf/YY5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XKVFjsNC"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63OAEtN12447131
	for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2026 13:01:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sVxua6OhniN2pNp7NNf6eMLPe0Dqnx/jPe7KCBX+eEU=; b=GKPf/YY54uCJOcEH
	UK7MVwl8orxzMcn99ix8lwLcX6ttfFjUgJKdRImNh3y72eDRKc3COWNT4FmfSedS
	1g6KMZbNd1VLvvRSlnoepxv8/yAEM2Tm6MjuAfSFKyBNy/P6kXUezwbJw4dd2GJ4
	GwgAxC9Nd5WdBmzqiskal6jrelMht+StXQoV6leBuabi7JJsJVzsCg8srfpeaJlt
	gEZIsZIzBxXYC4XEr6XxlTN9N26ei8BIvRYlfM4XTo4vv1wPHL6g3LHPBGfwd/Om
	TYZ50I0JoOugjsPKHMy4AusLVVP5wo7z9gGOLFiJg3Jo2gD6mpzQP5ucmscCU9oV
	Vr08kQ==
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dr6kprrfs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2026 13:01:08 +0000 (GMT)
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-69629c3b86cso253525eaf.2
        for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2026 06:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777035667; x=1777640467; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sVxua6OhniN2pNp7NNf6eMLPe0Dqnx/jPe7KCBX+eEU=;
        b=XKVFjsNCLb8SfvzPSrOTfedFf9tufnZCbjLfsurrY+qHN9lIEHGvMVUMQlu2y+ftJ8
         hnOYs2LyJ0mRaZUqNZxFFRe6ETjkPBYk/9+vRSREQ7NiCSOzU0UCI3Wxzx5q+dA7Rjvs
         GMoCKjAEr3uDPoDN/uDBVbGuNea2lxpjJgZAAEZdI0HnP7ZGI4NlyGdSFdiexPSUczGp
         M1xp7lXmKr4XTh/Il9cIhcgHdX7+diqH1uqyB7bQdfK0lrm+lGP8X0fQToleCC9OOL7J
         Jn7O2KUeylH5PZUd4NRfXYYDWR9FPfHT13TNnJXYSk2bkCnUW4AmSqZ11TQjyCA0TSVb
         rL8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777035667; x=1777640467;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sVxua6OhniN2pNp7NNf6eMLPe0Dqnx/jPe7KCBX+eEU=;
        b=pFwROcgpWT4jEmiQh1FCcvtXo02bZyJpBAP2T2lFcfnHJvL3pJWb77uzCwTJl6h9fY
         sPtbHxsX14XuknZgwTqyQ51+6yVjaUHNcNiqWyuie4auQhvgJaSytEYkV247w4SeTptW
         MMHVPOrk4NGm8mOaD8ff1xdozG5MalWo297NazX1/Z8gUNtogWNfkhAIhwMtRvcOU9It
         h6mp189gKUXxv6EowVwIGMHuZnNHHv33hWII2iERfmRWK3XWA0r77ynZ9zrPeDEPg5zo
         1Rbcj5KvFBK0b0QebzTxjzrIH4IPoPXCiF10ChD3rXDcFOC6xCxwES//l9ubr8UwcoHk
         aSCw==
X-Forwarded-Encrypted: i=1; AFNElJ/JQcgppVRVdGwpZLKlfx/psTUN/J3lMlm1KIq6g8FuFAXsqzhiPbIp08RrxHVFMBPXmi4vHgIn2w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwmCw/iCP74o7EnWO038+UZ87arS8810DpFgWv+oP99FA1O+SQ0
	KrHp8qrzp/f6ypaxIZEd+WdtV8X/fXg1VfwtVKyMHQ6AFvFrneE/vX8XL80jpYXgufvlRjiID4R
	2lv+ZBMXHe1VrLwPbUBKW8IBz2ZcnQ8LqnsVUl9TXckkkDAS1NJdosEmvPAumSA==
X-Gm-Gg: AeBDies8A/khxvW8XZ59oglomPV+UzbhDJ+rcdzss3rdt/t5v6jRWs/7MlfidScnNQT
	ohsqLGrs/YjzIejUjPmN3CxECvmB4L1/CXzysvhT65X/1Qqj8x7Ofa2tZew5SPGcOBUg0wJYRfL
	MvnkaPLgYp0N0DiAARy/iF5SoAbsRgTPBwbad6AH/KDOkGbKW/8n3YJ8ODeMhVDuv1sajXS4UiC
	enK6B/oiI058Pjr+ZlP1foE9poE33p0nT/BXsJm4efqCoNMq77aM5jB60/dq9hSyl9ddlJ4E6Hn
	C22vy1dIxFjcYUWar7LLlcFhVKJtYFEKG8W+FTNaZPmPT1dUiMmSdjsxTUzkUo+1FnTb2GBmNpr
	QOrK9j6YbKCceyGUXgPIa7SCKjPFiHjX8zZVmAC8FEV+65qN+wvHdYYURbCyHs5rnZ3HzAnlOMH
	EiPAMO11I+EyH2HvuY7eg=
X-Received: by 2002:a05:6820:81cb:b0:695:818c:e552 with SMTP id 006d021491bc7-695818ce65bmr6590841eaf.55.1777035667250;
        Fri, 24 Apr 2026 06:01:07 -0700 (PDT)
X-Received: by 2002:a05:6820:81cb:b0:695:818c:e552 with SMTP id 006d021491bc7-695818ce65bmr6590794eaf.55.1777035666580;
        Fri, 24 Apr 2026 06:01:06 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:1ab3:98b0:9e96:47bd? ([2a05:6e02:1041:c10:1ab3:98b0:9e96:47bd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e4d525sm57154801f8f.31.2026.04.24.06.01.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2026 06:01:05 -0700 (PDT)
Message-ID: <91219d5a-793c-4145-854d-5a1f8db45daa@oss.qualcomm.com>
Date: Fri, 24 Apr 2026 15:01:01 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: thermal: qcom-tsens: Document Nord
 Temperature Sensor
To: Shawn Guo <shengchao.guo@oss.qualcomm.com>
Cc: Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Deepti Jaggi <deepti.jaggi@oss.qualcomm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260420065409.1249030-1-shengchao.guo@oss.qualcomm.com>
 <a4f6b7f5-6566-4c73-9c4f-e43c3cafa75a@oss.qualcomm.com>
 <68723e33-53ca-4a66-8777-945cdcfce6fa@oss.qualcomm.com>
 <aetoLNvH5jeK3Cmo@QCOM-aGQu4IUr3Y>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <aetoLNvH5jeK3Cmo@QCOM-aGQu4IUr3Y>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=cdDiaHDM c=1 sm=1 tr=0 ts=69eb6994 cx=c_pps
 a=lVi5GcDxkcJcfCmEjVJoaw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=SgGMxA1ftVfEYTiVe-wA:9 a=QEXdDO2ut3YA:10 a=rBiNkAWo9uy_4UTK5NWh:22
X-Proofpoint-GUID: QIDT_jPzvhoMIU26lpZ2qgJoH7ovpeVG
X-Proofpoint-ORIG-GUID: QIDT_jPzvhoMIU26lpZ2qgJoH7ovpeVG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDEyNSBTYWx0ZWRfX28M3bog09n7R
 /0oXyozlBKT+nqQ5s2gy7qKisq6XjI7bvSiAmXB5l3Gz3fsq2nhGmy/v4njSkEd37SMADeK/zUa
 mJU4mkEmKAx+vx/G262s/b199+tJHoDHEh+2e7si/GWZ0DbJ7ZDZ6OH0GuU++wjogV9PO/1OGIB
 IY6qo5sSWgQey2HDqUjLp6XWMwU5zFI5+ATERJWmwvHVhq6SSDlbmafIolrxx6Xjj1mhdLskMYu
 7eNWPbsI9w70i4zyUktWv7Hw7wTv+zJ4pM6/PShT3tK8mOECvSTIC5iRIgV325P9f2Q/J8uRFzi
 QgL6snt+/sxnIWk4kDuAg6/T8Qx9hUC7rP4nQFdQvYJ5jmOdcq9aQHBacZvJ0zL9ljwQvAxgVTX
 WLsiFeM/leK63tiXS05noKvNP7hFnbUzb17OHi6p0kOCDRSteaw6VFfNP5G50xoTybb0WFx9LII
 GSDalJLbGHANJDW2swg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-24_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604240125

On 4/24/26 14:55, Shawn Guo wrote:
> On Fri, Apr 24, 2026 at 02:12:44PM +0200, Daniel Lezcano wrote:
>> On 4/20/26 11:19, Pankaj Patil wrote:
>>> On 4/20/2026 12:24 PM, Shawn Guo wrote:
>>>> From: Deepti Jaggi <deepti.jaggi@oss.qualcomm.com>
>>>>
>>>> Add compatible for Temperature Sensor (TSENS) of Nord SoC with
>>>> a fallback on qcom,tsens-v2.
>>>>
>>>> Signed-off-by: Deepti Jaggi <deepti.jaggi@oss.qualcomm.com>
>>>> Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
>>>
>>> Reviewed-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
>>>
>>>> ---
>>
>> Krzystof,
>>
>> are you ok with this change ?
> 
> Hi Daniel,
> 
> I plan to improve the commit log per Krzystof's comment on another Nord
> binding patch.  Hopefully he will ack the new version.

Ok, thanks
