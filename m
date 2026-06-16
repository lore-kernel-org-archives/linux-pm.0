Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE12430677B
	for <linux-pm@vger.kernel.org>; Tue, 16 Jun 2026 09:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781603151; cv=none; b=kT4zGB/X77Dd3+fKNA/YeNurV6VN/8AF1l2VfU9H68aMEzFqLGUzuka8x+3Shg+Ur3XvPn/41axvj4nOwEGRqmwMDA0kLyOCEmqva+imak0lGjCoLSr9grxEd1p47FDQmxYU8MmjxHxRXPC4iNlpKMEGUaA7NeH4qY9CLSZETlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781603151; c=relaxed/simple;
	bh=LC7dDtmk+ZW/FYQaJQ4mv5Z0clS776B0o/QgDFWksAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sQlxBCsikUrX56PoaICFAO2rlfBR2khpCGmHKsIHKIHH3slvCWFmAI0zB2DiuvdxODLs1r07IlpWBoIkYvupgA+Y9extGhJHTr9Qlj5uF77aLGyFMkKiN0zZUcewp3AejzA0l/VBs0X37xwLgZTXvkYaEd8zhup/ErhksR6qk0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U3QF9A08; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MjHvrKRW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U3QF9A08";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MjHvrKRW"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65G65e7b2699297
	for <linux-pm@vger.kernel.org>; Tue, 16 Jun 2026 09:45:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0aEEZ+OkgRg4egXxqmcIcO+IisKGYk8Fwd2iLOFyAnQ=; b=U3QF9A080EZPWBs6
	H2V2Y8Hb7OTLlO9XK7w34lQLF8XIKvwWeacYlq+dULEUwalseVno75iBhP9uGOVJ
	wsgqxBJWAcSogMyaLXrE3Nj2q38bMr2Obi6tBYGikOZJHhi8ivB8Xhhdd5TNhN6d
	GBALD4JTKbC4Xu7Nv55UIMrpQFHuUzdHSVwlz1Vj6fMxJbhxyeb0diOtvOypnlN9
	en6+Wg2uVcf/9UsKFQwwVwzeDIQ+SnAy8nRuc5pRfRjyJuZo9vkNjHOW8yDP9K1v
	XbJ9I/8f+ucs8L7pQeVKvwjjetVlptC86ch02lLJyZByiZj4HLQRDWDeytIg5KDL
	KB9Zsw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eu09k93c6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 16 Jun 2026 09:45:47 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5176891d0a9so10679291cf.0
        for <linux-pm@vger.kernel.org>; Tue, 16 Jun 2026 02:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781603147; x=1782207947; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0aEEZ+OkgRg4egXxqmcIcO+IisKGYk8Fwd2iLOFyAnQ=;
        b=MjHvrKRWS20Xg5pInBp+IvYysNYLAIvY96Nd44K+c4wR62Zvve5IXfdqcIbVpEzYHd
         ey1UjxNiJYZn3KRNe9H/4BqwodlP89jYIvcsq8vn+bUExtZe+zVo1/SWn/95Vq42Hwd7
         cBMLeTa/+9UVC5V9cj0XUxIrsV1h+Mf0guH6QPxH4YL1MxfcIAWs6ejNIrNJpBL1HUcm
         Zi4SmPlNa3B1zNu+0SCoI+FinOEG73bnWRy4nxBckgC46rC1dFLAdOPdDhCPV49Q5jMO
         K24Okk63Rqi9523APfvdi864C9tMe8DjNgQm5JJ5M8XFt2Kmcb/5BIbakPGgK0MaRT9I
         zXaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781603147; x=1782207947;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0aEEZ+OkgRg4egXxqmcIcO+IisKGYk8Fwd2iLOFyAnQ=;
        b=sCaH6xMWPjQTuZyDmQ7UlkFBzGel/QHu1Rj8M32WUCy7fprh6fj6OcfUjlT/a1MoJU
         WT6soR6+QcsXB1GP/UDFgyv+hYqsYrOUZUYcv/DnL6rt9LMK0RByYl1yJHjdneErV14M
         LHj9Cs32KVY68AH/AdAxx6z7JUnIy3ja1CepOUTtAokP2Mgd1qykCoMouQcoDVn/z6Br
         cB3cl8W8j7zjhwH/z9jpQK94TfEfBEqbarZQ6gSSv1XY5pitHaCJo1h/MACH8jOAeGtO
         ywS1Sb1SahpA8BX7+zDY3w/Th+SBCAdI5rxleAI+RMES7WIVSjSxQ/tj0EO4XN8xtiOW
         Ne3A==
X-Forwarded-Encrypted: i=1; AFNElJ+rGkKJlLxf1f9tuQ+8bGgNGRExblNLS8vtXKrzw30De9mDl/J8jDpw8NekcRl++9hDj4Eg9zho4g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzlIYyhpMqAl6SG9cai5H7LZQWT4EfkaVFjADmiW32P+hj5Ur/e
	QKXkd0o+94dHKh2mXhXU4/S/wwHu0749+3EcQkP8CNdvKd9Qd4q9xrjKOMUN4qvZKzh6cW4KMu/
	f0wuvtKBbozaAdOYnpHY5o2SmolvSFT5kBHH2T0iT2bOUtRzimqE4ZiGI7RbEsg==
X-Gm-Gg: Acq92OELgNU4nwOo3WuGZSnc1i4+UQ0XibwljebipBjHBw8pf0FwWNhEUJ/BlFqD62P
	JabPWXkMh9MjuhDI87ZSa8KXyiC9Pop+eLFsm1eOFhbmLCyHJdo5Vwz9wCEkhEjsdcWk8j8iXqO
	z7s38n9a+AaycB5VBwifNIaZha2ecyyBBEMVUFjyAIS5teQ7NLkran96gO1WXugR+NDIg4pxWH1
	ilBwYUN4Xf/ZcgqTMb1IjOOSRoxAOGX0HwrHFzo/EzQ1O30aF3WQg4DkyQojtSxOrKJ+CHrkq6V
	MzU6Lp7OohLFTAMVU3F02tWCM7sa/2vZhEuY/u0LQzEoReZ6XhYIg4jGPP2OHmaZJ+tSP0oVGj9
	Ve6/nshnud/CkYHjYRkrxFZ1AXgsD82PJvkPt2xUs3MNflw==
X-Received: by 2002:ac8:5855:0:b0:50b:3489:5495 with SMTP id d75a77b69052e-517fe49783amr170523171cf.8.1781603147156;
        Tue, 16 Jun 2026 02:45:47 -0700 (PDT)
X-Received: by 2002:ac8:5855:0:b0:50b:3489:5495 with SMTP id d75a77b69052e-517fe49783amr170522931cf.8.1781603146627;
        Tue, 16 Jun 2026 02:45:46 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfdb8341840sm623721966b.43.2026.06.16.02.45.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2026 02:45:45 -0700 (PDT)
Message-ID: <511f53cf-0f1c-450f-b55f-cc7f3dcd73b0@oss.qualcomm.com>
Date: Tue, 16 Jun 2026 11:45:44 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] powercap: qcom: Add SPEL powercap driver
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
References: <20260519-qcom_spel_driver_upstream-v1-0-75356d1b7f94@oss.qualcomm.com>
 <20260519-qcom_spel_driver_upstream-v1-2-75356d1b7f94@oss.qualcomm.com>
 <7ea2f2cc-ef11-4727-810c-e32e815bd973@oss.qualcomm.com>
 <8f045340-a6c8-41c7-b1c7-6d9b87b05d90@oss.qualcomm.com>
 <fe5ff2e6-4c54-4b21-be5c-0f06bf0e6696@oss.qualcomm.com>
 <c85b658c-ea61-4d34-8327-2a0be2618611@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <c85b658c-ea61-4d34-8327-2a0be2618611@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDA5OCBTYWx0ZWRfX7C56F1zyns1C
 y8oDF8h4gxtkLr68qlT1m34K0nWhGowsggrEkZxpW48CX351hJSIyimYXJOe3pDATc0u+kte7Bx
 cmr9vesEfd0q6f/ZoYQWuPNClFVdOhQ=
X-Proofpoint-GUID: LoDjzm7ID5hbK2ZOYccJGPkBCm1NM2N2
X-Authority-Analysis: v=2.4 cv=DoZmPm/+ c=1 sm=1 tr=0 ts=6a311b4b cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=iXSNKydA93grDqh3_akA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: LoDjzm7ID5hbK2ZOYccJGPkBCm1NM2N2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDA5OCBTYWx0ZWRfX5xyrIdZHuJAt
 EN08JC04UyEwZwvnkhxCRDDHdzrwZSDuFZLOKTngCOuG9ChsnRBimiGCQEuN6re1vVCxiwAmpOc
 QyYv0cnFvuqHfz6xbFpYxUMQFfGFfVbQaAs60e0h4I789uhaf0Ut6PXyJw/XhZ89oG5jccMFikn
 k2rwyujPk93RHKYCnsfOojsNbCt/3UowqH2Jv6rcVUED+bSJGWLiVjb3npgh4mxrc7Zg6z5SBAu
 cbPIM7fhWmWTEbU5GtAYbvgE0a4K08BnmaUWMyQTEl9f9Xf/7tUxtOffQguPQ3P07qgBsA4Z6aG
 AFm1rw87RSESIwwN2dGKDh1zK/kDz6a8+1BT1chiF6ZT3N9P+4W3aKJ4z6rcC3T3xoJszpb1JnX
 4SOdES2XwVJbqmlVfuIDjdX9JcU7PBRJw/Q5qYRpgKXOcqX/hLeGKY5gihzNKxlgmY1jCIg569x
 1kRPjREbcM/3TrmbwbA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_02,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160098

On 6/15/26 2:07 PM, Daniel Lezcano wrote:
> Hi Konrad,
> 
> Le 09/06/2026 à 15:31, Konrad Dybcio a écrit :
>> On 6/9/26 3:23 PM, Manaf Meethalavalappu Pallikunhi wrote:
>>> Hi Konrad,
>>>
>>>
>>> On 5/21/2026 4:46 PM, Konrad Dybcio wrote:
>>>> On 5/19/26 12:49 PM, Manaf Meethalavalappu Pallikunhi wrote:
>>>>> The Qualcomm SoC Power and Electrical Limits (SPEL) provides hardware
>>>>> based power monitoring and limiting capabilities for various power
>>>>> domains including System, SoC, CPU clusters, GPU, and various other
>>>>> subsystems.
>>>>>
>>>>> The driver integrates with the Linux powercap framework, exposing SPEL
>>>>> capabilities through powercap sysfs interfaces.
>>>>>
>>>>> Signed-off-by: Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
>>>>> ---
>>
>> [...]
>>
>>>>> +static void spel_remove(struct platform_device *pdev)
>>>>> +{
>>>>> +    struct spel_system *sp = platform_get_drvdata(pdev);
>>>>> +    int i;
>>>>> +
>>>>> +    if (!sp)
>>>>> +        return;
>>>>> +
>>>>> +    /* Unregister in reverse order: children first, then SOC, then SYS */
>>>>> +    for (i = SPEL_DOMAIN_MAX - 1; i >= 0; i--)
>>>>> +        powercap_unregister_zone(sp->control_type, &sp->domains[i].power_zone);
>>>>
>>>> Could you try adding a devm_ variant of these register functions?
>>>
>>> Powercap framework doesn't support any devm_* API, you meant add this support in framework in this series ?
>>
>> Yes, this should be fairly trivial - look at e.g.
>>
>> drivers/regulator/devres.c : devm_of_regulator_get
> 
> Given how structured is the powercap framework, I'm not sure it is so trivial. May be it is, but I doubt.
> 
> I don't think it is worth to investigate adding devm_ variant now (for a few lines saved) and diverge from the objective of this series

Might as well be, looks like the powercap zones are "namespaced" inside
powercap controllers, so it's not that trivial

Konrad
