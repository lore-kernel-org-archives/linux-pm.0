Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A89D44BC92
	for <linux-pm@vger.kernel.org>; Wed,  8 Jul 2026 14:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783519921; cv=none; b=cXk3sq6AUjAkEMfBq591DeQZdzgSrgETD47tM+wY4qxtGR2COoZvVw39ol3u1MBprxPg4gOtY+/FNdVz0fU4m1924oyTxPVKjwKrqy28OaJVWpKdM7Fus3Sy4tdwpLlzKeQJ0iwLepNAw+9663fDnvDLvh+3iENXZppRqVNDKeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783519921; c=relaxed/simple;
	bh=0vJYZK5vPVo2/RXqS8keEXFurIYoDpA6OVUOBaeexG0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZyLCBIjz7DG9PtAoFct8Taafx8lMK1DnCk3+zRw/SAD5gJD1iSe68cV3FicobdPoNxo1omoaKGV2F5EAZp6A8eLnDbdfVEeN4wIiOmd3EG53Hkfu6MhC02lwCwSuL/EmXJHg9kiZHCmrciyWHU2Ued9cpXSnsCg3CE8FghrFslw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YXTLac9Y; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WlKrTFJ9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YXTLac9Y";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WlKrTFJ9"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 668C40Fg2752024
	for <linux-pm@vger.kernel.org>; Wed, 8 Jul 2026 14:11:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wQSUkQFLaxvlcc8RZA7/n7JM0m7BFdTCUNhiufZcHuA=; b=YXTLac9YvfDngvya
	j6WfSfxyWvA20J098KPI88zaXozwUIFqTL3FcUNEt+QbnrQSfudSAwNwIcPGbNOh
	9a3NuPzGu94NT+FvRA7LRTqBwx/Nh6I7bX3dA2ue459TXOrV5W/kHBwdvxsjHCeR
	wsMXvTGmSmo4ny1u2tzLkrWFPQYjH9lX4RM9JtEPaA4ycDf807ZC9Ctz6gJdYJwW
	T958Xjee47h4A5OTL6w07VX+9JZpUuN6V3LeZBcRETmnOB1k2yjYbjFnBlPc1bmu
	wVRO/NDtqRIuEeP+QSR7BXcMYPW2WNYhAk3VdpAUZ6svz4XKEJV6EIvWaxqU87UU
	O0IKeA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9csstsyp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 08 Jul 2026 14:11:59 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8ef81cc115cso17960456d6.0
        for <linux-pm@vger.kernel.org>; Wed, 08 Jul 2026 07:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783519918; x=1784124718; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wQSUkQFLaxvlcc8RZA7/n7JM0m7BFdTCUNhiufZcHuA=;
        b=WlKrTFJ9lpI8yDFXlGSzU1ODFt6DWjeSA3SDpLgRKGk/Cbyffy71b34aEdip69KCFx
         X16KoTx+L6bgxNgBY7O6Q4vRjUk0vBzNj3CA4fb1OAkUxA0nKi8J05DtIZ1Lxa8izNL0
         5ptMkok29NtXP/h9nnIvUXY1gUPpkUKG7zIA/vWFFLdntZY5Qi4256fe/FkmPWtEerra
         aOoeSWzuFC4nIHPdpX3ovzjrHOaeLRrIslXQ3swYllIzKjpB05yn7/A2HBaq+rSRe66q
         qJ2eC4F/UXZKjOkwnt9LtYyH96rzzOB6GtmaTJIeLZWbfG8CAGN6yeSAPDwVNiv8C9yd
         N8Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783519918; x=1784124718;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wQSUkQFLaxvlcc8RZA7/n7JM0m7BFdTCUNhiufZcHuA=;
        b=GJJehoxBIkkz7zChAqRGf4pbjl0eP6ssWULbvXmihG9idFnpmTagC1XrgT1anLGjOX
         dql+HhSFbNnKLbfxP5M5TLqD9HkduP3Pet8RrEeeV9vnYkIl0TX3/xvBHmcu1CfQDciR
         Vv5vlL0Bni3v4YnKWR4ki5Xu8UiAWgJlo8hyZi+YumugPq129RWiQZtt1ugylmulA6oU
         oXsC9DLKerAH4gNhOPX0MoWGcZvw3Kc9Ibrxt6qIrO+aPc2t1yZOuln5XhsI4aULu/ew
         49YfdCzKbrdQJNTENzUz7KFFJntXvVNAYBK32NkhFhpoDxy1cUb8DNu+zXWVkyiXcHhk
         4VQA==
X-Forwarded-Encrypted: i=1; AHgh+Rp3oKA1AVSBFlb5J80rBCXbbel2yGfOS8JNgR/I08P+sBs3+IgnUl3oJbOj35Wfbv1+3xLu0F3JSg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyFVTWv56d6T/5bYSFh14BU6WEzIRz1VnqhhavltnCmoEhi30U7
	Ii/LovmPGz0y/SqmVkwTjHVRACS2qAqpDFjPGR9mEcTsN4KCW3+aqmLd8dRbOk/IuRQKfMJBEGI
	YEAk8KexNHQz8YWWh96CALeQvSEI+YD4z9dcB37v9Lx8lHOObMshFIPIf6DTfBg==
X-Gm-Gg: AfdE7ckWiTAIbVFAWiODVXGNfHGqztsNxBToceXAJ3uZJ0tpo/O3irOK7lzZRV0W2Mq
	9Txv72G6y/UjZwVqlfNilUi7C73CKIHO+HrNRdGRlmvcCL72VTh73FcAcf4i4NO5+pkTuCXMX31
	jFqjQ9T658weuUVYKmtCbl004TSEIrIm8d0lJSv1u3rmxXyEKFuEL7PNPNDTqAIzrBiGUM189DM
	9zIe7DpD81yWrpPdayTriKBzeO1LwSDbWXDbAQY0yU7tSxHJd9b6Py5yP24OcKjdCo38+cUOZvV
	SisViWyLWsxqSKIa2OsMXgSCi28J7nukZ/MNRP6sFqzW1J0+oo2FuMO/WXVfSLTYKBPpLGGkLYP
	J033r5kquafgDciSvTE+qetRQo9sREEDFhPZARi0O6uuYC1FHybDXrl0eJ/zqLOuqMESCJbjWFg
	==
X-Received: by 2002:a05:622a:53c5:b0:517:91e5:1086 with SMTP id d75a77b69052e-51c7a78ffefmr78627441cf.38.1783519918594;
        Wed, 08 Jul 2026 07:11:58 -0700 (PDT)
X-Received: by 2002:a05:622a:53c5:b0:517:91e5:1086 with SMTP id d75a77b69052e-51c7a78ffefmr78626721cf.38.1783519918016;
        Wed, 08 Jul 2026 07:11:58 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:2110:e352:d7b8:8bf2? ([2a05:6e02:1041:c10:2110:e352:d7b8:8bf2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0960634sm43780774f8f.26.2026.07.08.07.11.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2026 07:11:57 -0700 (PDT)
Message-ID: <53b7b25d-bd24-4231-a43d-6740dfd84162@oss.qualcomm.com>
Date: Wed, 8 Jul 2026 16:11:56 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal: remove unneeded 'fast_io' parameter in
 regmap_config
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>, Chen-Yu Tsai <wens@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
References: <20260705164311.2273-2-wsa+renesas@sang-engineering.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260705164311.2273-2-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=EtziaycA c=1 sm=1 tr=0 ts=6a4e5aaf cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=LDBv8-xUAAAA:8
 a=5uWOEY44YF13KFjEAh8A:9 a=QEXdDO2ut3YA:10 a=xtd0hNyKXt8A:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=DZeXCJrVpAJBw65Qk4Ds:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDEzOSBTYWx0ZWRfXwuAE+4O7iWA7
 WqD9NwruDjmdVXxzQVSlJFfnjQgPj7SMubc3yWi2OHaNkjBHAfkcRingA33N9sVl4tz8EZSoTue
 y8rqJCtvWiPxvcwiXVMScI69eyb4i8m+0w6JFnZ80X2i6yCZJnJsGxhWhqfIouUF4/fl6D2QYMf
 kDay3+dkgXoMYRlv3Zb5xtCFgKGnwWg0KMRwCZQw7+TiDEAaSlr0BE5u17MdBrglimtt2fiAJYt
 CA/BYRinLNr33v00ILY6Cdp/CmOo8TRxiv9QvcOXM9WSiI2UKOJvt0rGlI/7QKvvbZRoOhjdxI1
 kcU2//FF9lXyheci4CGjos6WKn7i1KQsGdl+GNjxnxMb5a2Pym4miFdpgZqzHMYRge4/V+ZSwbx
 drsRmdyOAV+3Yee71eM0zg7SGiSS1JYUE11c9Hv4du4cUkx4hu9t+ym/ieSMZvcCNoTt2xT5gRR
 JVpndWdhNQ45EWHMBLg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDEzOSBTYWx0ZWRfX49sz5vbh15ni
 EoyWOqqS3WBOFjm0Qa54mmHDv5ccP2KS+lEBuD8GINg07DwFBzRKzh1t8O0zNhGAqrl8wHwrZPA
 NqbSu75d0H5MEv2PR78tFGM8lF9H0Hs=
X-Proofpoint-GUID: Ziqjl5HqfpTTpvZMbw4X-fOCFmSkdKyz
X-Proofpoint-ORIG-GUID: Ziqjl5HqfpTTpvZMbw4X-fOCFmSkdKyz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_02,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607080139

On 7/5/26 18:43, Wolfram Sang wrote:
> When using MMIO with regmap, fast_io is implied. No need to set it
> again.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---

Applied, thanks
