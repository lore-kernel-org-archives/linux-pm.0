Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B67E2DEA68
	for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 05:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790660768; cv=none; b=gp7t/yrzBMpgnTzHwNoKcRIzUnfbpPT7FuRpjnBDbkUZd6FOVaHdWtMWikPGP12b2BrPAjab8iHkmMSZElNCfEsZAMNLf5wUOW6Y1SKWBHb5ah9H9UNGxcYXRgJhrpIE8G+JHg5sgblb4RzYt4yoa+T7KmwDMmT+c3Ig/ve6YhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790660768; c=relaxed/simple;
	bh=WBrK6P1J5Sn8UyafewpSzbEBsFKxbWX5+iAjHib2raI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A4oFQcNl8KRGssTdPm/XuQl2yX/n3oKiF+/lVv2qBq53H2ahHey/QVKT1RqJf1aW7sw09Fsi/QiPmRSAJXnTTOz1X2KXBI6A/sfG2mbJ7mOhJqkHhHj250qLsEVQgYmJToD0QvXqmoy/o8pzL1WZW1yUFFFcJdZ8QIawGiciWyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WbHSujlG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aJkCSU17; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WbHSujlG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aJkCSU17"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68T47AqU2126503
	for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 05:46:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Q+frg3gm10voRSH4KNBjLaqR7f6wGIX42XHmruDIkxw=; b=WbHSujlGrgDr8OaY
	WMmlKN6Jo9lkdsIy5AwBBFCxU9rhpxCN5ZEjn3/UGeC4RWJ30NVrxqLlmJsjDeaR
	XlG6wSbZExGK8jqW7aPv+33FL8X00noxrUd52MWHaBlq49eArmAXLTWLceySBuHg
	KTSK0i6qhSdiHbOJCZKQ359lZAtGNYXf5iCYO3JmVXRosY5XPzYv4yrr8juoBrgd
	xvQqdUM1eZP2achlYfNlAZ/9v8VWDZGg0SyYWYCyObiZMyB2Vz5aE2f/A4uDuq6+
	rZCi6YSE3psWytZ6wv1Bo6eU8MbZzB5Ha2CZo2qG58cQYs3FydzxGQQhXDzKdFMM
	H4ISCg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h02mn8yvc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 05:46:06 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e82060977so97858485a.1
        for <linux-pm@vger.kernel.org>; Mon, 28 Sep 2026 22:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790660765; x=1791265565; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q+frg3gm10voRSH4KNBjLaqR7f6wGIX42XHmruDIkxw=;
        b=aJkCSU17L5ha0nMHgNNdoAgfxblO1Ylv1R7mdmasqxzaGsAHZQ9OZAA0KQ07e2WiUf
         LYqzotpLWt58Kkouf8F+T20gpELyQEMT3+KSLq6D/YWab1giJ/Hd50OuZn9d2/YO/avd
         dJhRjSBmeBR9mMGjHDmb+amluGI5nw3vH02ieqSBCMRpSX3mu/coqqPLNLwZaQcr4TRW
         SP19d1kncJFJRrrJF1OH3HK+U1lRDGLfJ9iWVIZnwEhsNSoefKdC75tVKRoau02/MYHh
         42b62kyyDc62UR5PVT9bhJDZiKrx27UYpyiMsuIW9mtH//Tq4XefLORQxlSltCmv2SYi
         XQ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790660765; x=1791265565;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q+frg3gm10voRSH4KNBjLaqR7f6wGIX42XHmruDIkxw=;
        b=CijOpFYwzM61gLHn45+DMJPWpAi9x+h+Y8oEHJNG2tH1LzEdzEtGt3oU9ANTG7WXGA
         1stLvx4HoGmi5edfYaa8VbaOSHqT+eX0H9o2fjuiohZn+STu0vfIJ5GROvUswg2eEAdF
         cJ29UrL+fndM7q3HHmVNZkpxpczatdTG+3ij5js9qDomY6hNZsKz9bMdwVNsq8SFX4M/
         T8+zuFgx5KXRSvZFsujB3JgmahMpIbBwXsSQyxLeDqH9Qyn1dV7fN+HEkhIEy+r8w6KI
         425943mU/1R6+A1byJ8iOR3W3LnMcyrZx8BVDoUfJObf2Hk5hYHVcAX9Au412uy4o+tm
         ZHJA==
X-Forwarded-Encrypted: i=1; AKwUvBz3E+7Gil//lW+odCu3t156hC6L6qoneTLvBUE3j3FzZg1Y+/1jkVsXzWFE+/aS11hQfEFpr94EzQ==@vger.kernel.org
X-Gm-Message-State: AFuF++nfYxLABM2SyFsZb2jXqInig7VogQLiPZnXRJ6tCD1jsgDjHgdv
	XggD4p9f4AIP6Dit9W+Tiav6Ifz3V/U5QTAH8GPhv3XMvsNKxmuyyo4kqnRQAVt+MJ3IlahBcT4
	xhNiX88oBl6T6jPk6WBshtNEFs4k2G7aPBInirNPS82bNUDlPtkTjCSM9uLtz6w==
X-Gm-Gg: AYBFou2hGKwUxhVl0NrS6DNYBuvsUCnE4+fxGZuZAPRGQpXXxDcqSlmNh2c39zUQJJ/
	FMIFP5dGN78jwYO+rHwTTuhwDxCG8XsCDETFtbG8cd/LbiwItN7XVIQUqYzxdXxrAo0w9IgYibS
	Au5I/g386Vn+USzgPIKEvi1AJtAinmjuXvn/oJRgDWSNDhKkab2rSyedrYXgA/aH3Rfk6ToCSa0
	4RfjKv5aaai8EBZ/coga3lmv/zneQl//MCIyR/3J/Lc1KNlN7QxG+OPfNcqLB8zHWq+jVysBo3J
	G37jItGdmk53vhVjcCRmYH2/LljwrOus169CAWgRbJuF/LaSRmwofN5sNQ8ZmafJ0n+wDAikFr0
	STnqZCQvpAsmdbuXJpVgB79HyGpeOjs3D8eDzb0GW693vRgbmymqJ+sMBOVSbyg==
X-Received: by 2002:a05:620a:2b9b:b0:93b:c6fc:71e9 with SMTP id af79cd13be357-93c8bf447famr274500785a.25.1790660765626;
        Mon, 28 Sep 2026 22:46:05 -0700 (PDT)
X-Received: by 2002:a05:620a:2b9b:b0:93b:c6fc:71e9 with SMTP id af79cd13be357-93c8bf447famr274497985a.25.1790660765060;
        Mon, 28 Sep 2026 22:46:05 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:7d20:e20f:a77f:4ef7? ([2a05:6e02:1041:c10:7d20:e20f:a77f:4ef7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00ed06ea7sm31492735e9.4.2026.09.28.22.46.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 22:46:04 -0700 (PDT)
Message-ID: <8eba263a-c233-42c5-842e-7487ea36d5aa@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 07:46:01 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/7] thermal/drivers/loongson2: Correct thermal sensor
 registration loop
To: Binbin Zhou <zhoubb.aaron@gmail.com>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>,
        Huacai Chen
 <chenhuacai@loongson.cn>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Yinbo Zhu <zhuyinbo@loongson.cn>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Huacai Chen <chenhuacai@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        loongarch@lists.linux.dev, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, stable@vger.kernel.org,
        Sashiko <sashiko-bot@kernel.org>
References: <cover.1790561983.git.zhoubinbin@loongson.cn>
 <502911659e15a51c4e98c11f3cf476dd5f92e75b.1790561983.git.zhoubinbin@loongson.cn>
 <0aaf7166-378c-47d7-98d4-1004fdaeae7b@oss.qualcomm.com>
 <CAMpQs4+uWMfFib7MhRcc7o-QMXkFrFCtdcGj04y56u44JL4iOg@mail.gmail.com>
 <ed99f62d-cf90-4ba9-89b3-08dbe7f7227e@oss.qualcomm.com>
 <CAMpQs4+hATFf+0w6Wq09RoZB1JJ5L_GP0aWxcGAeraTW7Gfy0w@mail.gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <CAMpQs4+hATFf+0w6Wq09RoZB1JJ5L_GP0aWxcGAeraTW7Gfy0w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=X9fHu2Te c=1 sm=1 tr=0 ts=6abb509e cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=Ewyx0iL5S_KfCDCwH-MA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: n3SG0smbBQmPiMykgY1tIpKK2cXUx03_
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAyMiBTYWx0ZWRfX0xlJiYNCshy8
 B6B+aMftn0RtS1sVI2xp7pWhz6TMz5AAwd3L6rTTBjvFaVsxsZRQKL7g2jSM3RAjoSMEV+QH2qk
 i2vFcb3BQEqQ1X9wUf0fviPyB4dhJ/Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAyMiBTYWx0ZWRfXz+glKahwgLtV
 HqRVn4w19pNGelBcpqkfaLT8BsIB/HiqOk5O1Er4DQKjEiNg8fMbyDyhp4uXO7EIQcyMvrDDOVW
 HQT6HTyIfcDWrDQ4cAF8ZAJiZjLRCaJO7zs4YzFmKoU2NvHZDRY71ovyTIDAy2f+UZTK2zti1at
 RzHNn4AKH13N2j27H1WlJa/OYV6ggTeRr0PBx6+0pPsmiwMcjiNig2RczwCb6i/Zokc0TX3xdXy
 P88t9I/gsDjfrMCeG/bmnFI3m+XySukKX4oXG9ICrOc6l5ZUxnpjn21rhwHsmA68/j5UbiAP6Fd
 zkhspuNviMy7jZAbEaV0SkxDys6uo08lx4VwhceVUGxGZe/EzkfsWe+6Lxwu9uZb56wCpwhtwUA
 hq016YffqjwZG8XjltnKBk9xWJiECYFYEx1g3rTJejy5vKvaexVylICLa5kMHgMpKoG3JFHrdyv
 xMxFKYFJfyOfGdYwpdw==
X-Proofpoint-ORIG-GUID: n3SG0smbBQmPiMykgY1tIpKK2cXUx03_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0 spamscore=0
 bulkscore=0 impostorscore=0 phishscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290022

On 9/29/26 05:06, Binbin Zhou wrote:
> Hi Daniel:

[ ... ]

>>>> Please make a less cumbersome and implicit checks here. For example
>>>> count the number of sensors and then do the check against.
>>>
>>> I thought about it, and you're right—I made the logic here too complicated.
>>> Let's use `sensor_count` as the counter. Is the following check logic clearer?
>>>
>>>           u32 sensor_count = 0;
>>>
>>>           for (unsigned int i = 0; i <= LOONGSON2_MAX_SENSOR_SEL_NUM; i++) {
>>>                   tzd = devm_thermal_of_zone_register(dev, i, data,
>>> data->chip_data->thermal_ops);
>>>                   if (IS_ERR(tzd)) {
>>>                           if (PTR_ERR(tzd) == -ENODEV)
>>>                                   continue;
>>>
>>>                           return dev_err_probe(dev, PTR_ERR(tzd),
>>>                                                "failed to register sensor %d", i);
>>>                   }
>>>
>>>                   sensor_count++;
>>
>> If I'm not mistaken in the previous version, the loop exits at the first
>> registered sensor
>>
>>          if (!IS_ERR(tzd))
>>                  break;
>>
>> Here all the available sensors are registered
> 
> The name `sensor_count` might be a bit misleading, but here the loop
> exits after the first success:
> 
>                  sensor_count++;
>                  break;
> 
> Let’s rename it:

Can you clarify why only the first sensor found stops the thermal zones 
registration ?
