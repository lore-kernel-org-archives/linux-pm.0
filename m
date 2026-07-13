Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8D02737E0
	for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 16:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783961808; cv=none; b=tuo6FfvkwUluQ8uWyZCHbXKPuKmSbMQ0uiz03uN99OT4+SK5HF5eoVD4z/yX4IsvEw1oDXYIROnan62Dq2ZVUgrvZsBu5xxJCJ3KICaojBmUuZ+XveJZVtxRLZmmcUdUbhfAFItDAMUXL0xG2+iYtf46aiewKkhzKBr9oTnYURY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783961808; c=relaxed/simple;
	bh=f1dENWIJHys20RMrMzjKwGdXIMauPk3ExXn/7QJeIaI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AEZMhmf8d3VVivYawzhkl8KI1YZ+cC+88hywF5oO+39GvoiaFjI91ErOx/gPqPhWyOAzm2QWK0JQM0Bu0JGQnRRbNj+w7K2QJjc279lg11iKEQ9rLbs25+LTvbme4jU87H7hCsh10l9jpTgMN2xXjijONSZyyJqtxA9ZDfnfCCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CXHyQvkf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iq0E6/4b; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CXHyQvkf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iq0E6/4b"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DF8JRt1860711
	for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 16:56:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	t1BTK6gFt2giEtwJiw2DRM0UmiGtqToj6SdQoef7PZc=; b=CXHyQvkfz6bBl2Pt
	uw8jCZ2dmva3aRyVyYaavB3xthMwVC+62Hs27bbn16wmR+usqY/AS4Akse1extmb
	BA+4dlU8aZ2pU7ysSkVBXodzjx3ypvPO+wsHnLvkrAl3atXYovjpzGti0bNLIYhk
	5jhnxN/s5vy7hu97jXSw4cxI7JSUw1Rp9XF5ZPd3dN0EdwQwSrjfOfsrn8SD86JN
	IiXu/gR8G5T0KOsRx0NLI+0oOqmJb9x7ceJRk9y/CN1+TkD5Rh0VfHUJmGnXopsV
	4MR/BYUd/q9+FyiuM6pTdooxQ/pHH+njA9+uzprlOJKXi1kKHVys9mTsvQnVrV/m
	M4Thqg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcuj02anv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 16:56:45 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-388cfc4848dso4166251a91.3
        for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 09:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783961805; x=1784566605; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t1BTK6gFt2giEtwJiw2DRM0UmiGtqToj6SdQoef7PZc=;
        b=iq0E6/4bybjNgq3CiQTP75vusHPq0bpT54n4AQVFocFkLj+Znvcuqrsn1FuPLX1sFH
         2kVM4MjVhSHFmePdxgJ/pCAHsq3NpCtgTE4fW9u7SE/8L29ev9ttMItN9Z91mwehHPRQ
         LoPdcFwcA0XEu+PbaMFMOKn1CdPvnexLcOwmnJCUSQF1ukkXIR5MDVv3kEdcXXn6/25F
         jEVl6tw+2yrnke83XDOHh9A6KjdSvc5T0t5HhfU2w8tJZJ4EvOzywLOEU2k/k3Csx37s
         k2Yw57sygD77of6VPePQgynFpiK38HKcHacjbY/esTjOkiH1t/VhdAc+P3f1efvVDZu+
         oatA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783961805; x=1784566605;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t1BTK6gFt2giEtwJiw2DRM0UmiGtqToj6SdQoef7PZc=;
        b=PEMTGtMxQe2ukk5HumDutMkWxg0tErR+OifTQfeCR/0lEh6B6qZrieAxzvHuqK7pSK
         GvnNwT7FshyZEM2tDZGyu2j+Q9YEhOdpeKE4PHWdPfuqM8kKS7ZIYBoj9/gWerEAkP52
         i1o8E1S4MCI0y2OrljMlL+Xjb059n2W5nds2qjiuphUTR7bEcC+oXKrFpfBRM6RAeJmz
         g7gD3SVCQ2HVzUfdHp65x0U8p1y+k/wsKhfRUVaKLOBPL1awKcJQMCy4poDpCM2HxgjP
         +Nq7rnyqLV57qb+7RmpAoLjgx2L1l+FNchKUIKdT/wfVrrFpexb7+bdh5/B1Jxbq7QlQ
         bMBg==
X-Forwarded-Encrypted: i=1; AHgh+RpxnpJBV+Tza+0WUgMDtDeO4ktCnisJcDLix4sLY0CaBTCYRPiUvM+qU36vHjWSEAW6Tlgr4pFGog==@vger.kernel.org
X-Gm-Message-State: AOJu0YyVKI39yHWXoMDk1Z6loPSuWjWXqv2+cXJOehpjIx33zsWZsAd5
	klbf96gfvaxGhD8zQ59v+HbTjdz1pe7X24HSH+5jrUg9RknyQcgg0M/JvTMorz7se3PMXtrCyiZ
	zx3OlRfLh70rJWuD46KkG2YgPFWYjdOkWQRMdcOTr59uzj+6CnLm4sgBwL/LIEA==
X-Gm-Gg: AfdE7cmHKHieE4rqSP1Tc3LoRgY/sgqUXsbQCW6y7YgFzx0aFTKwkue/ReKjJRXvLb5
	8ceZ65OcdkPVnPtHeR4660CZtjU+R1jE4TlTPOHSXg8Nac1cnm6gUh8BSCSUuDlC4unQsYSahnx
	y9tRhuctlO8/cB/Ym9ONjv/0XoDM8Fo3UCruaP9Tag19cmG29StTnu+QKgQWKEGuaG/RfgMg2i8
	hfwDcOdQWSvqJJyVL1HT3O7cpsIuqJUdCMpWX9DvbrGAJd0kUToKPqaV7RFO13a9LiqHMmajYFs
	/347IupuuBsgZgcGmAchfH2DrcTh6AC9upyVqjw3XWeyRoRuVVAyCSRLK0752o1y0R5jU3HcTrO
	ErIpl5yGakW1KUp+e5A/5snVIlKUPGBTXiq0hazFeZ6Pgzw==
X-Received: by 2002:a17:90b:2802:b0:37f:9ce1:7364 with SMTP id 98e67ed59e1d1-38dc774cf00mr9949893a91.26.1783961804619;
        Mon, 13 Jul 2026 09:56:44 -0700 (PDT)
X-Received: by 2002:a17:90b:2802:b0:37f:9ce1:7364 with SMTP id 98e67ed59e1d1-38dc774cf00mr9949860a91.26.1783961804152;
        Mon, 13 Jul 2026 09:56:44 -0700 (PDT)
Received: from [192.168.1.100] ([157.48.180.168])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174ac14f2sm76694721eec.27.2026.07.13.09.56.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 09:56:43 -0700 (PDT)
Message-ID: <ee6c2c71-d988-4bc8-b716-1468458965c9@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 22:26:36 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] thermal: qcom: add support for PMIC5 Gen3 ADC
 thermal monitoring
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        David Collins <david.collins@oss.qualcomm.com>,
        Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Stephan Gerhold <stephan.gerhold@linaro.org>
References: <20260705-gen3_adc_tm-v3-0-ac62f387dbce@oss.qualcomm.com>
 <20260705-gen3_adc_tm-v3-3-ac62f387dbce@oss.qualcomm.com>
 <bbe3e9a1-86df-4c36-be68-ed480de10c1d@oss.qualcomm.com>
Content-Language: en-US
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
In-Reply-To: <bbe3e9a1-86df-4c36-be68-ed480de10c1d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDE3NSBTYWx0ZWRfX7tuc/oG7TLuI
 0KdXHacL7wnx59OnlTLbKNTYvDWk8piybL5YthsRd6IzHj5jHDe03riBV04/6dCr6PM5IMgkwy+
 VWFnf3qREgDPA+2uNQKshZMG0akhApk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDE3NSBTYWx0ZWRfX6Kef9RzrwxXL
 xhcpHLBynNxRn/+i2LODQUJJXVyXk7246Gd6Ne7JSbjB4vqnP0XLT0bMrhIJZADdPoyXKqkFW68
 nkUJxDpkgkzZeebICWZ4MvimA0u8VFkazDwIUDD5qTrI08HetkdMMSmR1wFpxAb70tOpWkWPKgn
 cYR6H1mcnN2PbQvLZSeHXqu8e4dwNLXKe31HGz6RQ1Vpup2KqXf8fDm3pEpOI4sGy3+BtkYP21b
 3eJwfgQhHUbG6cFS040hD9x55GLdIxDpIAX3UH4FqufkkbmURs02YZYzIBXWBva1/5fuSdIVHhP
 VuwaV6Pm19fxB6prLgzVcP+6rGbASACUe64a1bt5SMMmYRK/PGv/zCkHUzWqrENFzcb88kpnCV7
 UCEt7FMmdZgu0IfBRKiDz95DLM3gXAVTi8LyOJ8iP1BH8DOsHhMsBsPRvoZ8UgJdr6y5dLdNSGR
 a2dDWkuz0jy36H1tDtA==
X-Proofpoint-ORIG-GUID: 0e06msh1oBVTb3mqCVraOTC2ENwd5sVR
X-Authority-Analysis: v=2.4 cv=DbcnbPtW c=1 sm=1 tr=0 ts=6a5518cd cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=62VzjLAzdHZQ3L95IMgkXw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=ZJtfdnNEmsHLE5vD43oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: 0e06msh1oBVTb3mqCVraOTC2ENwd5sVR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607130175

Hi Daniel,

On 7/10/2026 12:38 PM, Daniel Lezcano wrote:
> 
> Hi Jishnu,
> 
> On 7/5/26 18:53, Jishnu Prakash wrote:
>> Add support for ADC_TM part of PMIC5 Gen3.
>>
>> This is an auxiliary driver under the Gen3 ADC driver, which implements the
>> threshold setting and interrupt generating functionalities of QCOM ADC_TM
>> drivers, used to support thermal trip points.
>>
>> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
> 
> Overall the driver LGTM but as you are sending a new version to take into account Andy's and Jonathan's comments, please take the opportunity to document a bit more the code and the changelog regarding the hardware (eg. register layout)
> 

Sure, I'll add a paragraph or two in the commit message to give some
more details about the driver and how the HW implementation changed
from the previous ADC generation.

Thanks,
Jishnu


> Thanks
> 
>   -- Daniel
> 
>> ---
>>   drivers/thermal/qcom/Kconfig                  |   9 +
>>   drivers/thermal/qcom/Makefile                 |   1 +
>>   drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c | 425 ++++++++++++++++++++++++++
>>   3 files changed, 435 insertions(+)
>>
>> diff --git a/drivers/thermal/qcom/Kconfig b/drivers/thermal/qcom/Kconfig
>> index a6bb01082ec6..1acb11e4ac80 100644
>> --- a/drivers/thermal/qcom/Kconfig
>> +++ b/drivers/thermal/qcom/Kconfig
