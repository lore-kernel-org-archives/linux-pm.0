Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B274A2A4B
	for <linux-pm@vger.kernel.org>; Wed,  2 Sep 2026 14:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788359760; cv=none; b=UhoF1JjDuk7nzhCy/f7nhTBM7RSxDMdq9zMSwORpUzR9Ac2Cw2smsGuYPhnoLu9zNR7oKRU2auEqUrYykA9y98gYHObHa/dHIyiA+lipkYfENsfL5RgvFYuk+GadWgbBLaeI2mleO8Ow6+fStH63Bfs3RoGVFGVfVNiDYdX3sWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788359760; c=relaxed/simple;
	bh=99Ch+3LYFJ9N7TSsuHX98/Uy8K9XP6/jMla2yvTy2pQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FfsdIMcvCKnnRxI84Jlvn/rMdeBBFoLfY4ZTF8YxIGtTevS6tRYJ/a6VUypJOx04ySZSLPdoQSRwxLHbri933OPXO22R/i4m19x1hBs576grUhMDwsCYTSr/Ut1z7+rbo/tIOnNbtzudv8rXH7PvpBlrgsRbTh6yvnyC8M79bao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RtZDvrbU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GQ/wXtjn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RtZDvrbU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GQ/wXtjn"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682DI0rV1873042
	for <linux-pm@vger.kernel.org>; Wed, 2 Sep 2026 14:35:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yyLhoiY022AQ3A7dmKbaF46+l4kfEuJhlZPs9i/eMFc=; b=RtZDvrbU3o+ONCHj
	MZVRtG39PdHqIzVvQhmGgPTm1uAjU3lDDumsAkY8CrLMc5FUg8yw1XFfVNbY8xKF
	NlRokiijjifPaIj5MReq0aTURNweJZpykPyoMReodH8YX7czofD51MzkQQ4+sNv7
	QVC51UA0pUn94mG5T/F6YBlnVShxtNKoFUICPtO1GNPQEqe0OgPpi/wUCO5iU6bh
	+UlXXZ5lQyQZlYwhCN+qDE2nImvb8CNt53wNRrVUHc2hXxH0I7wyAM05AouaXhro
	F38CR0pbXIT5HXYHRPQpNW3wz39COje4JhQcbR/MjVm8OVKd3QAQc/NZZCQw+cw2
	Kr1NiQ==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gemjh89sn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 02 Sep 2026 14:35:58 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-97cc5388db1so9933241.2
        for <linux-pm@vger.kernel.org>; Wed, 02 Sep 2026 07:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788359757; x=1788964557; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yyLhoiY022AQ3A7dmKbaF46+l4kfEuJhlZPs9i/eMFc=;
        b=GQ/wXtjn9AAfSeGj58d8uxMtxM3mSx0ziLne7gaY3aF8ntGtdVfTrCU9mZ6L6H79fN
         5BKMb/5oqmrh/pMerZxRtN2I2YV/XGQqpaSvBxScwH04gGrvCbfVaEdhbJsVx5N0Z+bu
         ZK9rzVTAqCDkiBk9HoJrGngNAZukarI4da5L/SvyBZUqPxHYCLrMO67VK2IJQUrJ37NW
         Wm7/FeQNG8jWncTXcR2qez27GjFhYETjpgEc2eQ+shsFqeB8T9Z/rlEY+4km5WQ13uiJ
         +UYjPhi4WeD8br8kUck2Ot4qctUhMQBO/RX02rkIvmG73Mw48eWYoVSHNdeYwRu8flXr
         bjHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788359757; x=1788964557;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yyLhoiY022AQ3A7dmKbaF46+l4kfEuJhlZPs9i/eMFc=;
        b=ZqTjhdiK3EjmOcfVeoGU5+ZfnGUN7HSzH12T3Jtghe9mLJJPoN8mKptnTERHgW7Xq9
         aFhPpl+k2RK0E97ABkz/V1GphrQXOwZtpK71huaEjTIpLe7Qr9eJmGoAGHNAWRs7qznH
         3a1UbwOfdoyH1TynHlm4YXeJnzmxuATQQ72RwRSuQUnKaBOHhOG6YDU3mQZ8ICaZgyBt
         SIVb33XhzdxfE/S8KgWoUXnuMNc11+ku/E6z3PMoRS5oJi+fki19duuHfGI7sZuS+GBj
         uCbgtaQaDrSZRUtpbvUdibqDJ1gHaO+psvbZwBpSeekEKg8YAJBEdWfYL6Kx76OdhmJn
         sdRA==
X-Forwarded-Encrypted: i=1; AKwUvBxKQw9us0UAjHIaCYFMGdZ3RWW/o2L+v+rNveVg1vTJUvQLObxEaEH1Cj+BdJ9uYlRpNnIcb34ALw==@vger.kernel.org
X-Gm-Message-State: AFuF++mqYlCdPBlyjASE3CsUJVZMaaPu/pnDsUXMPfw8rYL0wheGj6vm
	0B7sweOTiSQs1wCgkRQ3/lnWZAQx0anMBwXIes3SjFlI2omarapFyVhSVJtVfRiZYLXqlUhqPKe
	JmXdV6Bv6YGoftvlW2e2bEp05rho1qa3MicAgauz5HWpe4YWLVZdm/ajtaSIQBw==
X-Gm-Gg: AYBFou0dJTbAYjSSb/XfRLJQ23pCt/KRrCSM3xIGSnEw9ycd2LnXbs5PTHba4eZxtxe
	7k7fmRXFwCL6yiseBcOj3qGY0rS2OTMKUHpkM76B+FhW1jiFEJWpvJkXdmyU6CziTZmmuAXKW6u
	FMk1Cp4sntp65CWzRZmNID94vWPfnSgAxOIZhNPjnqC0csUJIajsdOrRXWeAOKVqvJgRurCX+mY
	dSxxeSNFblZ6ZtykNT676zFzf39uJgIcDSPpRgbpuMMkWRhSJpzGLjdooHfSFVmbeEuYO7AySnA
	tnM1KCj9m6QpT4bBqAcIxiG3zuz6cy+aqnFFcTVp0kmesmGNXlp0SbEkCtMmITZR3l3sBz7i9bj
	A3DInY4jJvtLyhh/lgWE1fA==
X-Received: by 2002:a05:6102:6884:b0:786:8d84:5aca with SMTP id ada2fe7eead31-78a1f339246mr824456137.2.1788359757508;
        Wed, 02 Sep 2026 07:35:57 -0700 (PDT)
X-Received: by 2002:a05:6102:6884:b0:786:8d84:5aca with SMTP id ada2fe7eead31-78a1f339246mr824434137.2.1788359756585;
        Wed, 02 Sep 2026 07:35:56 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b606b22ab3sm635362e87.30.2026.09.02.07.35.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2026 07:35:55 -0700 (PDT)
Message-ID: <838a68e1-c12d-4f1d-ad89-24b799f02a5e@oss.qualcomm.com>
Date: Wed, 2 Sep 2026 16:35:53 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] power: supply: qcom_battmgr: fix CHARGE_FULL* on
 SM8350-class firmware
To: Jan-Michael Brummer <jan.brummer@tabos.org>, sre@kernel.org
Cc: andersson@kernel.org, neil.armstrong@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260829054546.86210-1-jan.brummer@tabos.org>
 <20260829054546.86210-2-jan.brummer@tabos.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260829054546.86210-2-jan.brummer@tabos.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: i4yJzPLdswXklDVYX-1Ymwhk8WJI64RO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDEyOCBTYWx0ZWRfX/UeqP5HQSA5a
 td1iTb2b5z+0IgevVrS/APMy+MoC6r4pbZAYG+wZH8GWwux8enlo05Xewwl/y+Jf6MrUevSMW9+
 Xl16D4JlTtHZXBPxPSDCkT5wJxj6sX5mocFshI94l6ThsVdffpTm9LgdQE3h99E8Hrq+DzsRTR1
 8Gv5r0l56VFEsQZcKcXT39GLBMbKJIeFmopRMkRD55X+QTO2BuRlqUSCGHBzqUPRqGx7qWxmoWl
 n8Q7kIQFVAXuPpLzoy6xvyYOpRL1k6u2idtCPaMD+p85/eOD2In4SqVosVfqtWGKuPHsp2P03pp
 EEV4nwZlypSYYiAZ1DpZolEj9dnC/2wUvP2WNrN3grCkI2yPCHMpA1faN3UNLAKYi5fTpNIpGCs
 /BaxdyzgsYSrctus5Jpv1ezy8ByPA54TxiUP4PJ2xtiKPUVw/EGk7Ge4ntgfcUZ0SC8MVyGNvt1
 J09eq7x9g5Gm66qpDhQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDEyOCBTYWx0ZWRfX1sX0f21gg48h
 fD7zfto5U57dViIC+3KJ4XhdI6HU6mAMr/gL48lDBGyCumr2bHR/nxsktqf5m2UQTHXLsf4gMo2
 bXjRLwIZlP6J7SvvY6/0Q1ZT5a85YZo=
X-Authority-Analysis: v=2.4 cv=ErHiaycA c=1 sm=1 tr=0 ts=6a98344e cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=DYa_1O34AAAA:8 a=C9CdgfQ6oJW3jvxbsIcA:9 a=QEXdDO2ut3YA:10
 a=o1xkdb1NAhiiM49bd1HK:22 a=piCpHeHFVjWJlYWd443B:22
X-Proofpoint-ORIG-GUID: i4yJzPLdswXklDVYX-1Ymwhk8WJI64RO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_03,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609020128

On 8/29/26 7:45 AM, Jan-Michael Brummer wrote:
> battmgr->unit is only ever assigned in the BATTMGR_BAT_INFO handler of
> the SC8280XP callback. The SM8350-class firmware does not implement that
> request - every property is fetched individually via
> BATTMGR_BAT_PROPERTY_GET - so unit keeps its zero-initialised value,
> QCOM_BATTMGR_UNIT_mWh.
> 
> POWER_SUPPLY_PROP_CHARGE_FULL and POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN
> are guarded by 'if (unit != QCOM_BATTMGR_UNIT_mAh) return -ENODATA;',
> hence both properties always fail on these platforms, even though the
> values are requested from the firmware and stored in
> info.last_full_capacity and info.design_capacity on every access:
> 
>   $ cat /sys/class/power_supply/qcom-battmgr-bat/charge_full
>   cat: read error: No data available
> 
> Without a full charge value userspace cannot derive an absolute energy
> level, so UPower reports a zero energy level and never computes a
> time-to-empty/time-to-full estimate:
> 
>     energy:              0 Wh
>     energy-full:         0 Wh
>     energy-rate:         12.4713 W
>     percentage:          59%
> 
> The firmware of this class reports charge domain values, so set the unit
> statically when registering the SM8350/SM8550 power supplies. With this
> patch the properties read back consistently on a Fairphone 5:
> 
>   charge_full         4116000
>   charge_full_design  4260000
>   capacity            85
> 
> Fixes: 29e8142b5623 ("power: supply: Introduce Qualcomm PMIC GLINK power supply")
> Signed-off-by: Jan-Michael Brummer <jan.brummer@tabos.org>
> ---

This also implicitly unlocks reporting

POWER_SUPPLY_PROP_CHARGE_EMPTY
POWER_SUPPLY_PROP_CHARGE_NOW

which are not populated and will always report 0.

We should probably further limit that.

Konrad
