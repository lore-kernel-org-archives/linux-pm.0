Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E1F30FF08
	for <linux-pm@vger.kernel.org>; Sun, 31 May 2026 19:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780257506; cv=none; b=oaXJ5D9kdVz47ZiUt8OqmNJC+1eCZjR5+8Zcq8tMCgL/hkRAzqezzj1FtEhs+6la/QKhA1c8saiy7GZ5DIOd5FnJfuHBKSxCl60wwjTuCTyaqoPC6Q9Zgb6Sg+zdJZnsDVwSg+V0bpgVj/eKxXsMKo7ob/54MOOljAguc0hctNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780257506; c=relaxed/simple;
	bh=4d27iXqwYegfSxwa0tyuhz4yvb+d61tUAzALnsjixzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lmOLfB0KxC8f77SG9ZPOhm5lCJpFhxHGv+IcEOrNkAc9NECUcN5ZGilug3qh7BFitS1l2+OEjhJ8x96LD4+skLq7sqxvK8GMH4iUF+HfN/qPc3LzK2hstSbCan8z/YHkDYVA2gZkO/yaFBc+9CINJTTYPijg6MzWzO20P0iflKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RbTVPKA/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=g9k3xEbS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RbTVPKA/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="g9k3xEbS"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64UNX9JS2900945
	for <linux-pm@vger.kernel.org>; Sun, 31 May 2026 19:58:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9EPVuHLNy9vtwwB1VoFU440/iMySrQARYXdbMN/T0bs=; b=RbTVPKA/5wmS3W0/
	cUjJTZHMCY9tm2xDovY5HG/R+QoYu/vLCSihmbj5S16JknFgrb4b8OVo8TrTKZC1
	qlIull9mxJRz4gP3mVRdPM5y8X5AS/VMdRWozNwUBYHvzeT6H7EWEWLxX9j+U1c3
	lOFv6BdyVKD0UozxsAewMm1Zt7AGDUdaCucWB5h/xSIX+xI/feF5zj7pRg15cHkx
	xwC/QtaQXFkGd5NFhSqbHEXgcZWwqsadkgm1ELads0Z53OgGYApx2EFhkjKFnSwF
	MiibEEpyuuH6A00BYmutOu18Z6BntkVTnoPWU1BEFkE5Pirh7RhZlQn2VKgbvM+Y
	x1rGnA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efpw7mjgn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 31 May 2026 19:58:24 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8ccd719a2f2so18238436d6.0
        for <linux-pm@vger.kernel.org>; Sun, 31 May 2026 12:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780257503; x=1780862303; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9EPVuHLNy9vtwwB1VoFU440/iMySrQARYXdbMN/T0bs=;
        b=g9k3xEbSgT6o/FzzCY1JH25oVlxIt8HdM25p3LSDysgvmsBfbtt2dfsGW1hqo+FXWd
         GUE0amgT7BJSkjR3tCUPhY/nx/AInao7mJym76Qo0xkL13orI1oZG0IfMAYBHBB8R9wx
         fYtv5wQEZMA3DMtDXfTErvSV8rHv9Fcks1DVSU6MBfW3Vqv/86VJlXvmnNaBxcSLLGXN
         Z7Xm7Kno1djfPxchmULGTCle2xcLP9ETt7MqL3ZeBr5dLhdPF/xnLJUuCKOGCZps88wR
         0KFqPE2L7T1xmOP+G5Srga62gmaYAIlFBM1buRNtHDIBQTFyrCj9KfPeWQmQXhgYd6j4
         SqEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780257503; x=1780862303;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9EPVuHLNy9vtwwB1VoFU440/iMySrQARYXdbMN/T0bs=;
        b=mHmsPO4/FlI9oPIebAVnWHKJt7DLidc+NIii/cItN7hYRbahmD1+h5Cf//iJDwHatO
         Y3dlHY1GUhZRoPWxglMHo/YIWtrt/tudbRoZDdkmYhHcM/ne4pRbx6lCms0BD36iCC67
         jYCNjdLDD15iMRGo433k9gfXP7COf5S64Z5dl/1ZwZ9XYSvkVOLadAL8ZCVAfvM1+36n
         nXM/3AslfM35OyxRVCq+MV4tBx27AhmHyM5nXrRiWye0t0orhkvgI8PyAb63ljLmbcBf
         QDV/tnFrV9TydyjRyt0usgmr92E0siDV0cf/e4U540EyHGCOXxQiezUvRQJwcFybIpW3
         f47w==
X-Forwarded-Encrypted: i=1; AFNElJ8i2oAonKnfifnhjva7SzkVWNQFHHd57/UwcQM1vGvB229mkFHLg4F6IKFVdYpdjuERRUYRIqFjBQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxvckHUaMbFXTpXnUCLMmt8rRJ+SVjP2wKw41Lp9DYK3WuCJMVW
	fPu4WR0qYEfBo0Z2H9oOhlxmhiMhHLnlvuxb0qD4rwl1UsV5P8wvOnM/5KuwosNhRY3xpvVMsjJ
	VMQscEPxUpsZOmRJ0CyBqCXO1n4nuYVDmLuxQHJaG2m++A1rc19wCQcW24JSaIA==
X-Gm-Gg: Acq92OEiL+HfsaMnMccWKwTb1vxICEg4shrZe3My0C9/LMulwganIz0mjnbqG74ddsj
	YZK65bn967uUDutIqkxCnffvWCahjxig93+XX/p8xwHXIn2TbGXayMutncu0aDCoD59knFSR5iz
	IhkxQNBb+89gK3Lmur0c/PnJNo9uyuah1xM6pA5Zv6TqtEJbtQBAvP1LQSWVnmf1anMH0idhTdI
	yAuFz8Tt/tTHYj9aK7XAvweuJsKZTiule0tdKR0PNfaucUmqd1UTBBfRjsVMZIyqFDnxGRCC/Rb
	/KbF0LNuwrzST6P2mm6m9QuDXsFSe+621oz2DIJKBS2L/T38uZ6NMU5pKID2TgYFBZ7sUzaN4ST
	2JBUMGTFmB/wFq+7DYMnZydkYW/wZgSBzYPs1zYjwiJA693pu8XlG0LLNVwEcutOUx7Wbq/3vuc
	em
X-Received: by 2002:ac8:5143:0:b0:516:dede:2094 with SMTP id d75a77b69052e-5173a8b0d5cmr70777161cf.55.1780257503418;
        Sun, 31 May 2026 12:58:23 -0700 (PDT)
X-Received: by 2002:ac8:5143:0:b0:516:dede:2094 with SMTP id d75a77b69052e-5173a8b0d5cmr70776921cf.55.1780257502956;
        Sun, 31 May 2026 12:58:22 -0700 (PDT)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909d68a925sm303091335e9.2.2026.05.31.12.58.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 May 2026 12:58:22 -0700 (PDT)
Message-ID: <0c5033f7-1535-49e8-a502-426e54333496@oss.qualcomm.com>
Date: Sun, 31 May 2026 21:58:17 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] firmware: meson: sm: add stub functions when
 CONFIG_MESON_SM is disabled
To: Ronald Claveau <linux-kernel-dev@aliel.fr>
Cc: Guillaume La Roque <glaroque@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>
References: <20260531-fix-missing-meson_sm-symbol-v2-1-1def8c3c169f@aliel.fr>
 <8c11a91b-cfbf-4b9c-a46f-907989bf8305@oss.qualcomm.com>
 <12d74340-0213-4f7e-a494-10ce147844ad@aliel.fr>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <12d74340-0213-4f7e-a494-10ce147844ad@aliel.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: kqftKmMhxBX-dF5avPbHux5b6poNM2AX
X-Proofpoint-ORIG-GUID: kqftKmMhxBX-dF5avPbHux5b6poNM2AX
X-Authority-Analysis: v=2.4 cv=bNIm5v+Z c=1 sm=1 tr=0 ts=6a1c92e0 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=uw/3876vWhRnNVL35W6mqQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=DmWT0VEtOxJI-Rt19aUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTMxMDIxNyBTYWx0ZWRfXw7f9joWJDVql
 L6F/Mx4jZC79VtbFFfPutTzHbLTtZN0J0iyMOQbHmfZ47blogppTotNfmipIxXKJ3jcrNzSZyTy
 I0K812LNSm9x6MMkmTy9zqTOCSC82fc2C5y04i5ju/jhyiRsX3vf+kuRDqwpDDXgi8037c0g2Ec
 GMRsVaKB549ngordYjFhnX/AI+RdowC/oID2k3BtTTVgnt/0vlhUsqxWCBOiyF7YnLSvFd0pHVI
 9Cys0NP36sq/klV309FhI4RaK6aJCDmbTBAh+E7Kc8oi0qQPDl4VcJ4vg/Ye+EA5pQ9Dju8eBgg
 5t+64fna360pZeypqW4bhEs/haQLmukabMOgQvTohZf+QjgHMUZmqzXgK2Rxh0LMwITc+gTDIzn
 T9VcvZNfChOiJBmETiOJXPpu3tJxIxIvwwrk1fjlK89/a0dpvIZPtg/QuaoBRsyHTI7U+xoYROs
 CCAY+F6IMDV8M0lPeug==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-31_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605310217

On 5/31/26 19:49, Ronald Claveau wrote:
> On 5/31/26 10:41 AM, Daniel Lezcano wrote:
>> On 5/31/26 09:51, Ronald Claveau via B4 Relay wrote:
>>> From: Ronald Claveau <linux-kernel-dev@aliel.fr>

[ ... ]

>>> +#if IS_ENABLED(CONFIG_MESON_SM)
>>> +
>>>    struct meson_sm_firmware *meson_sm_get(struct device_node
>>> *firmware_node);
>>>    int meson_sm_get_thermal_calib(struct meson_sm_firmware *fw, u32
>>> *trim_info,
>>>                       u32 tsensor_id);
>>
>> Do you really want to compile meson_sm as a module ?
>>
>>
>>
> 
> I don't want, but if I send a patch to change tristate to bool, it will
> raise a warning because 'm' is not valid.
> If it is accepted to ignore this warning, I can send another patch.


Sorry, I don't get your point :/

'm' is a config option, make menuconfig should set it to yes or not set.

Compiling the firmware as a module means it must be loaded before the 
amlogic thermal driver, right ? Where is the dependency declared in the 
module ?

If the sm_meson is in the platform, it should be selected as part of the 
platform's component. No need to have an option for that, no ?


