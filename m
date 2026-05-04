Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B558037C909
	for <linux-pm@vger.kernel.org>; Mon,  4 May 2026 09:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777888775; cv=none; b=dnTKAUI8MnmCdvrgBhUZWNJNQMD7FHEOm58zInrgJK9c6Q4vS2CIlAkHmA6x0zX9xQCWv4WGNXXILR71yHNX1AaxOjX6X2S4pAESI5dM2aadwpw8UPO/nIC2J/61eax+FGcgftGwxJabs5v+M480r3rrsi7Hx91MSLnJp2NaOdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777888775; c=relaxed/simple;
	bh=S6XM/tTueF0luZTVGpxLRoxf3UTzcDP7I32kCO0rWns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jCHYj9mfJ9Km2kK3jJ2Dl67eMdttXkA0g73rbA4HxopzI3+qr9QM4UgjQFJRYCARNNwdSTbOoCnLfW4mVZPSsNpn8084w0Qhggvj7Z2fjJwRyCaQlvln0K7paev8ZAO/0IM4jrH7+djPk03WAXzkUqAGo5bWd/y3O99zB7WtftE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gJUgw7m7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VRESxUIf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gJUgw7m7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VRESxUIf"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6448g8FP488178
	for <linux-pm@vger.kernel.org>; Mon, 4 May 2026 09:59:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mH/Zs0Wy0agigprn/34jYuT07jxCmlmcVLk1cbgZ5bE=; b=gJUgw7m79thqlmPt
	8jkpuOyXJlmvxguoq9GLOKc7rYN/LD8ZB5sEMwV8g2bGTErPNhmSpLWfLvwySDjq
	xpKFVLUejVVdm+N63Vm2SsvSYi5fq9l6XpNJ7gEbvyXHsqGnCnKfQA+P5bhtYVbI
	ZJOYO7JIQU/xAVYG1o/zU2VCavIDgv/LhXJIEiZd0yiyMgU07gtFEazBodnVd0Bt
	h9IYRqsN7SqvtTzNE9/qxkDe4D4/cyl7bwSPSPc3pzMHbj2sjD+BFYd0C0ZNgifd
	dLN0+D6QCofHDgpSYxN9wslwgA1r05q/IbEjcF5BOuV/JMwm1IJChdB33wF3LQ0S
	9Gp8Ow==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dw8uxn7rh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 04 May 2026 09:59:32 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-60feeae5dd3so331923137.0
        for <linux-pm@vger.kernel.org>; Mon, 04 May 2026 02:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777888771; x=1778493571; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mH/Zs0Wy0agigprn/34jYuT07jxCmlmcVLk1cbgZ5bE=;
        b=VRESxUIfdZmPYIRMN1OCw1dEooMVdoHyZ9TIVHwWuZRPe63C2ydQ0JD+Dky6qA91oM
         IFlljrI79MvUbnrx45JelGX5RpJ4op1ILpTF0c/RF6ltB24XdJYo00vDZWO9Kw1MLpV8
         +APKXqIwZ0bLOHiWlktva1u7g21kW535tn0ZMd1UFvv7hw6hZEmtGC3coGGEGW/cdgp5
         8XuGTZPFs6XJNx7OMana9+PGD00XFyiHqeTQ9tcoc4/F6dvlv+51offZAlUPn6JI+omW
         BSEgLzEWMtwCj1OvLLOjS5HwVopfsMAaBqFyrgPL4Ow7W+B2tvMWK1CLY73bqT9To4Iw
         QNyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777888771; x=1778493571;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mH/Zs0Wy0agigprn/34jYuT07jxCmlmcVLk1cbgZ5bE=;
        b=VQv0cOp6tvNbyMVW/Dx2HxvKBGkMp0una0E2fMlQT9H13xKl9zzRPGGO2lfzC9q3LD
         A+ICRuFRAAnKveJK87viP9XHj3J9ZL/kIuCMZ4Z8veeJxW6pp7dMxjw/XsYWGQLQqn9c
         ajytdsX91TiH8Xds2kvx4gm+GE7/z0lDN21fJDsdjPt9DmGgizckeY0oHydX/i+gxRk0
         op46IvBE6npt5g2Ug66WhYmUvWyJrkniiEOTOWjak4UxQ17nQl4zENge3jbFgqD9aaMb
         JJfHL8W3xcdfgJos5BVAa9cBnLB3AJ+w8RCgXbXQjdVgJ82W/v0U5raPE22gYCAbukFj
         IJug==
X-Gm-Message-State: AOJu0Yw1Tfs+vrNPh1KhUHDziincNi/3G4SdCcDe8aAPj/c/ZK9o1L+g
	Q1nlrEpDAjrW8JxEClmal/dx3I9692n0QhPF9og27g2uX9UCGZWytNktMAom3H5DeWKH/4UZt58
	Tag4AmBgLaD00e5lz3D2yY4ZnB1LjlfuvxNDm5Vw3lRXJa2/uH95lrTqTBVbj6pLayvYsAw==
X-Gm-Gg: AeBDietuJm8d+XlzF4Wgg4ATnwOiqqEplUAzSFNVdGEyyZdQExHbV1f0HE6bIhenjgl
	/OckF5KgtO9raM/xVRanEiGPZIP9AgHNmhk7PJ0g/VqcBLl9zkVuDqQAoLwStfV0wj/b100XLEK
	cA4S1vDygONglV2U+LD+VMLTYyo9IYFP374w17Q0uSGzO3NmRiqMDSU2qNpKLwEyNHO5bduAp3v
	JUaXtudLZQwIGbgvScrg/fkvBuGZdEBf6KITlfE7/mXKTpIOT4kukOKHOZfJ304yLmEyi1ujQS0
	AVqDbnkHCDMOKr61VVyQVh6TPRg/3yhbWIhBTXCp5bk44r7RU8HTW0dy40TwcpHvBFXsCbzk3Wz
	/5SKBn1hoejRjYYjJ2qlFwnR/53Cs5iYsSxL3kNsmyqCF7T2FlIdf4wpjE1PbWvGsfwgPi+2YXM
	whKh1ZTx46sEc4FA==
X-Received: by 2002:a05:6122:a5c7:10b0:56d:a70d:7f06 with SMTP id 71dfb90a1353d-5750c2f4acemr992713e0c.0.1777888771491;
        Mon, 04 May 2026 02:59:31 -0700 (PDT)
X-Received: by 2002:a05:6122:a5c7:10b0:56d:a70d:7f06 with SMTP id 71dfb90a1353d-5750c2f4acemr992703e0c.0.1777888771051;
        Mon, 04 May 2026 02:59:31 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bc1e8b5e698sm117031966b.0.2026.05.04.02.59.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 02:59:30 -0700 (PDT)
Message-ID: <a90cc3e2-73ba-4ee2-a607-e73160cd3e9d@oss.qualcomm.com>
Date: Mon, 4 May 2026 11:59:27 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] thermal: qcom: tsens: atomic temperature read with
 hardware-guided retries
To: Priyansh Jain <priyansh.jain@oss.qualcomm.com>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, manaf.pallikunhi@oss.qualcomm.com
References: <20260430054422.2461150-1-priyansh.jain@oss.qualcomm.com>
 <20260430054422.2461150-2-priyansh.jain@oss.qualcomm.com>
 <c369dcd6-eca0-4d01-89f5-d19a41fd1477@oss.qualcomm.com>
 <10c07347-a0df-42d3-b216-5150817b9ed2@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <10c07347-a0df-42d3-b216-5150817b9ed2@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ppY2Gfm8zawe5VE7-SiiACh2FJYg7eaE
X-Authority-Analysis: v=2.4 cv=QqxuG1yd c=1 sm=1 tr=0 ts=69f86e04 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=jjc_y6zsabJUVXo2qFUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-GUID: ppY2Gfm8zawe5VE7-SiiACh2FJYg7eaE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDEwNSBTYWx0ZWRfX8nhKrdRoiy8m
 b9zzD0EbcY1evmc9hiI98aVyYYowQkL4R03os7U/xYgQcMMu2FTbMA/p+W1UUJ2flpCApnM4gH1
 k2aT6shOFkRPwjdBt8a06Grz1xRDFx9pme4a47G0LGyVbIe/IZ1ZXBrzp1I5Fiu2DkW9T5QzPlW
 3M3eQV94T1Kij2VCso+K37W9FviUJW3bx3zoPsfkF0gQhuLlCnjjz/p5DFV21Or3IP9iT/T2Nlb
 9tldqsaIRG3Xs+94lukXmSDPDZL1yFRehvygKJHORfN0th8tKwOO/47OPcIF15f+Ix3u6x2FwkH
 ayZNUc4EUP/4NLCFcGSow0GJKtsC7ldS+ClDCXsSpe5TaIMzujDtkfGQbXqpEalXrCSe4V4CwCK
 praXHF4uSdXI5nBwvr4L6yMcoLySOCwg88rmSpqQ0XFvKaS3k0Mh4d2KYF92LgKgiwJo9hlUmkR
 zrR79lsp7CXla2NPs6w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_03,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605040105

On 5/4/26 11:42 AM, Priyansh Jain wrote:
> 
> On 30-04-2026 09:21 pm, Konrad Dybcio wrote:
>> On 4/30/26 7:44 AM, Priyansh Jain wrote:
>>> The existing TSENS temperature read logic polls the valid bit and then
>>> reads the temperature register. When temperature reads are triggered
>>> at very short intervals, this can race with hardware updates and allow
>>> the temperature field to be read while it is still being updated.
>>>
>>> In this case, the valid bit may already be asserted even though the
>>> temperature value is transitioning, resulting in an incorrect reading.
>>>
>>> Hardware programming guidelines require the temperature value and the
>>> valid bit to be sampled atomically in the same read transaction. A
>>> reading is considered valid only if the valid bit is observed set in
>>> that same sample.
>>>
>>> The guidelines further specify that software should attempt the
>>> temperature read up to three times to account for transient update
>>> windows. If none of the attempts observe a valid sample, a stable
>>> fallback value must be returned: if the first and second samples match,
>>> the second value is returned; otherwise, if the second and third
>>> samples match, the third value is returned.
>>>
>>> Update the TSENS sensor read logic to implement atomic sampling along
>>> with the recommended retry-and-compare fallback behavior. This removes
>>> the race window and ensures deterministic temperature values in
>>> accordance with hardware requirements.
>>>
>>> Signed-off-by: Priyansh Jain<priyansh.jain@oss.qualcomm.com>
>>> ---

[...]

>>> @@ -125,8 +128,7 @@ static const struct reg_field tsens_v2_regfields[MAX_REGFIELDS] = {
>>>       [WDOG_BARK_COUNT]  = REG_FIELD(TM_WDOG_LOG_OFF,             0,  7),
>>>         /* Sn_STATUS */
>>> -    REG_FIELD_FOR_EACH_SENSOR16(LAST_TEMP,       TM_Sn_STATUS_OFF,  0,  11),
>>> -    REG_FIELD_FOR_EACH_SENSOR16(VALID,           TM_Sn_STATUS_OFF, 21,  21),
>>> +    REG_FIELD_FOR_EACH_SENSOR16(LAST_TEMP,       TM_Sn_STATUS_OFF,  0,  21),
>> ..this change feels rather odd - the existing regfields seem like a good
>> place to handle this register map difference
> This change is required to ensure that both the VALID bit and LAST_TEMP
> are read as part of a single transaction, in order to avoid a race condition where
> the VALID bit may already be asserted while the temperature value is still transitioning,
> potentially resulting in an incorrect reading. If needed, I can rename the field from
> LAST_TEMP to something that more clearly reflects a combined representation
> of the temperature value and the VALID bit.
> 
> Let me know you thoughts on this.

Hm, I somehow managed to skip the connection between the two..

I think we could retain the current (pretty good) containment of all
register differences between the versions as-is, with something like
this diff:

-	ret = regmap_field_read(priv->rf[field], &status);
+	/* Fields within the STATUS register are only valid if read atomically */
+	ret = regmap_read(priv->rf[field].reg, &status);
	if (ret)
		return ret;

and then falling back to the prior definitions of the VALID mask etc.

Konrad
