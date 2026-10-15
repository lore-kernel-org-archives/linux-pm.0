Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5365293F5
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 13:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792070836; cv=none; b=UJuyxZqSKyjZ3vmZd2K7YcRutGb0d290r0rPoGzlRnzwLsQJvGTKm1jeQAPJpbGx0xku+hKCMDKHjg+dnOU59VjpSPEbZTKR5fegui2K89dhf4ul9Ss2eNW7W79NdSZLvBChMzsNzHgcg++PNQuulVoeRp88bTm8JpWwnrQ7JPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792070836; c=relaxed/simple;
	bh=43d/IfQVGd0ktFWwh2ih4+KRV9k/SSk0R5GiuclYlrE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cUv8uBcb10NI5pwhG8aCsL43hQW1pMDaKAefH2PiaO6a9G0dKNq7jtViDAF4T2iMoXkPqxaYKNaYcbF4+eASJnegvQD5DtM0YYzDnqKnKviEkdUZycWI2vVjTFCew4KmBG82OJIWHUuJBQBi6XEYETkDDH5HNrDyK7Y2YlYzAUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=URXVUZpM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JZgIKgIv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="URXVUZpM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JZgIKgIv"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F9jn9w3408857
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 13:27:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gGSmw4Qk0kQC5B4pGDw36PFQPUykZhpZLLcEgaeZJKQ=; b=URXVUZpMb+iTSGzd
	FhgdBR8fbYC6wbxrWrKX7KR1VfZMaEJdfTOFw9nmcbnlJobC1ZnlHKevcBO7MAr8
	Rl/YGxro7eMc9g/P4VENTjqF1PZrrMx1BjAoHm6MIafJcGHfmt+ywfPpwS9rMZvk
	YIEByCDRszRmsYJanSDKpQnDRea9Mi0DD1N3ZV0cVR2mOFvwUwOzbhBWaf6ZjSYc
	W3flCtHYVQ9AHTVz+0bGWF/rqI0y//P6eciFqZscOOOQl6tDNk0KgFpDmvKX+L9e
	ubyPHUoG//9i8SGDiAVw9MCqS14/I9rGm34ugmLvZdimuarYLkU1Hqx11bjFSZnd
	Rb36Cg==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hakwn2xtb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 13:27:13 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-5de7ad7cdbfso205160e0c.1
        for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 06:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792070832; x=1792675632; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gGSmw4Qk0kQC5B4pGDw36PFQPUykZhpZLLcEgaeZJKQ=;
        b=JZgIKgIvSvYC/HpnvE5baG4AziXZ03ooZLYjEOova+oaa4m8sL8amdcnyszXQB0DxU
         kwJulSznKq/kYDfs05Z6vfOLYaB65F7VfOKrLOYEadytqB7jW+oTlSac8rF96dRJWw1s
         xehYASqQkSRpsOvqciuktHsW1NfNarTOnPbtlLILq9MjUnkRHIB9vdc5pWknSvQxYbyn
         IYFwctjZ1iTyRrru5/+rhL+O6j80xMR/eaM6M016XHTDWdB1NcwITGBt3oBhAbC8vvVF
         JTEqjuiRNdUNHhL5uAg7p0ulZXbBz/LhG6uwoTZobc+aiLGT0lqt0Uu/0i0+IOx5ne1c
         x93A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792070832; x=1792675632;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gGSmw4Qk0kQC5B4pGDw36PFQPUykZhpZLLcEgaeZJKQ=;
        b=jNV41TsI8W5INipMG1ZC8/C6TNku7yKs4I7NN+XS5mMCxUzihAObFTN+qxr8rLnQeL
         PeOD8wgB/huWuLi5JTTKvEK5bT/2YmzEzlJ9wAGMi+nECdeWXLp7i78dthjns8LiOIVV
         m2uDMVMi98qhn4N+NAwIab8aZ1BlUFh+aqpIuywh+nIsBD/lxt14fGo0UiEkzS63OAFy
         eQothC7v7Rfk9wAgutlv+KmL+O1zRgNSnaB1OzIjto4v5XbhZmLdmKeADr6EfQ+5riUt
         d/FnL/Kr/6M/tjtrSldxbgouKwcgsuxagJgYB64/VTt1YyTSx31aiyGN7AB8Z4q7erHj
         JZyA==
X-Forwarded-Encrypted: i=1; AKwUvByx17onPFy/qET3C33Y86bqMnRgp2POtGLwrOvgVRaEPgEsQEfC+Q52OjPoiyYXHEODcBcjJoprAA==@vger.kernel.org
X-Gm-Message-State: AFq9FYKiuBJDs5k348WG5EFcvZ840GLadXIt2INUCvlx4sCVyVpUcT7B
	A6eiDh+nct2QqNmPNh5++CklgR9+7uAy80Lmr+4mSu3L6SefwQb3O1njPgEBax1AcyQv8OcLbnO
	n/E+ZiqJBQNVkuz6+0pADZKQ0X706rPA2zifW4AyIw9Q9iuIKI5VHoQAaKDTO0MonYpPDaw==
X-Gm-Gg: AYBFou1dIhIIE+fWSSBPpb96wRkd7vcG7Rw8zXKK0+JuIPeCG0fpvfAVzgvk7gtvG6U
	WLJF0iAJuMaN+5ZV3xC9gJwrlfKbtI4CKZ3cTTJhtTZvnl59X7uBhvSp6EIp/D5on539VKbkHBV
	yxobgjXmtGkFuu5gElkKvfJWL7A40nSlmsSAkoYHytJbhs3RmzQBhL4zUdHzoa1lQVSM4ODa+K8
	pyElcW4Gw5exSr5CETdbCqeLhpqqJ3Rj6KKQICt9vWaNaNt6nYM3aNe8YrPObH9k/jGl+c3MzOe
	mwmpnJHCkpolhAdfSvg7YYgMJ6Ulguo7DteZozLdsxKQ3EgSwqyr6M6RgsA5tVUX39eIwtTQRyc
	IukpArpVqnnofmUf6G5nPMA==
X-Received: by 2002:a05:6123:5c4:10b0:5e6:589b:eeec with SMTP id 71dfb90a1353d-5e91f52a44bmr3913993e0c.5.1792070832452;
        Thu, 15 Oct 2026 06:27:12 -0700 (PDT)
X-Received: by 2002:a05:6123:5c4:10b0:5e6:589b:eeec with SMTP id 71dfb90a1353d-5e91f52a44bmr3913981e0c.5.1792070831845;
        Thu, 15 Oct 2026 06:27:11 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c3eda62768fsm125977266b.73.2026.10.15.06.27.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 06:27:10 -0700 (PDT)
Message-ID: <d3a67d47-9072-4094-85a0-7e1b75e08314@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 15:27:07 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] power: supply: qcom_battmgr: do not report power_now on
 SM8750
To: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>, linux-pm@vger.kernel.org,
        Sebastian Reichel <sre@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261013002124.332111-1-xiaqinghuan@mail.ustc.edu.cn>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261013002124.332111-1-xiaqinghuan@mail.ustc.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA1MyBTYWx0ZWRfX4jTpPiiBsjxU
 Wf/YLk29o5MDQEK8HpBEOt5G5lwLkYNqxGQwdG/2VS7Tar1HQ0VBkCs+eCr73JdgLJVqadEm7ql
 TvhkPIcp6UxZVJCnB9iu7GlkROFaHbYZI94i4pon45l5osryJ3TwORLGDwrgeD5qN0rNln0pfZj
 9tuzLDj5uAIFXyrTOv3kFJYod1xNh95kzTEHXKH8pIMNBNC/++qEtvZ1iFP6RTjUm9ervZg6h5P
 BVH/No7dh3sodA6rorvtUoW2/VfKzFZlCI6kJC0WRbd08+ccFKk7lTF0y5pVOO5Ikq6wsfNSIIV
 IDdfrHx3Cx9vDatLLqNA00/HKg5bZVgfos23j22Z7kcpsx6ziUOxwlf7KVkti/Zg9hgXIq+5aCi
 4+8TL8MhUY4FmtuecO6cFUgYSjUQ+2BQY6mU2dQTtyBDSz/S+0J9JE6UDSi97qFBIFWA+1BTgpY
 74CVq49cC1hzi9Bw9Tg==
X-Proofpoint-GUID: dTWnT7pt8dqyzwiE0VWuN3txc4eVQHhT
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA1MyBTYWx0ZWRfX1A+TXQ+wJktY
 xisDYYX8dKaGa0FDfAVmnHyjIWH6UDIP+afxqT1U/fqB2kLF4l+Ls94t+5uzTLVPqhwxGF4RPn3
 qo0h1eLIz/zOUgT6mTg8OtnTKmXExCo=
X-Authority-Analysis: v=2.4 cv=BqUIUoX5 c=1 sm=1 tr=0 ts=6ad0d4b1 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=AUfae7s1ju6HdZB4z7sA:9 a=QEXdDO2ut3YA:10 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-ORIG-GUID: dTWnT7pt8dqyzwiE0VWuN3txc4eVQHhT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610150053

On 10/13/26 2:21 AM, Qianhui Xu wrote:
> From: Xu Qianhui <xiaqinghuan@mail.ustc.edu.cn>
> 
> The SM8750 QBG firmware fills BATT_POWER_NOW via its maximum-load updater
> instead of an instantaneous measurement: the property getter indexes
> context + 0x6a8 + 4 * property, so property 22 (BATT_POWER_NOW) reads the
> offset written by the maximum-load path.  Exposing that as power_now makes
> userspace report e.g. 89 W while the battery is charging below 1 W, or
> above 100 W while discharging at about 4 W.
> 
> The SM8750 PMIC GLINK node is already described in DT
> ("qcom,sm8750-pmic-glink" in sm8750-mtp/qrd), but the driver has no entry
> for it, so it falls back to QCOM_BATTMGR_SM8350 and advertises POWER_NOW.
> 
> Add the SM8750 variant and a battery descriptor that reuses the SM8550
> properties without POWER_NOW.  The property array is reordered so that
> POWER_NOW is the last entry, which keeps the new descriptor a two-line
> addition; property ordering itself is not ABI.
> 
> Voltage, current, charge counters and the charge-control thresholds are
> retained.
> 
> Tested on Lenovo Legion Y700 Gen4 (TB322FC, SM8750P): charging and
> discharging, UPower state-of-charge and rate are unchanged and power_now
> is no longer exposed.
> 
> Signed-off-by: Xu Qianhui <xiaqinghuan@mail.ustc.edu.cn>
> ---

+Fenglin would we know if this is an issue on all SM8750 devices, or
perhaps something OEM-specific?

Konrad

>  drivers/power/supply/qcom_battmgr.c | 29 +++++++++++++++++++++++++++--
>  1 file changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
> index 7716eb9e1a..dbc98ac8a7 100644
> --- a/drivers/power/supply/qcom_battmgr.c
> +++ b/drivers/power/supply/qcom_battmgr.c
> @@ -24,6 +24,7 @@ enum qcom_battmgr_variant {
>  	QCOM_BATTMGR_SC8280XP,
>  	QCOM_BATTMGR_SM8350,
>  	QCOM_BATTMGR_SM8550,
> +	QCOM_BATTMGR_SM8750,
>  	QCOM_BATTMGR_X1E80100,
>  };
>  
> @@ -916,9 +917,13 @@ static const enum power_supply_property sm8550_bat_props[] = {
>  	POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG,
>  	POWER_SUPPLY_PROP_INTERNAL_RESISTANCE,
>  	POWER_SUPPLY_PROP_STATE_OF_HEALTH,
> -	POWER_SUPPLY_PROP_POWER_NOW,
>  	POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD,
>  	POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD,
> +	/*
> +	 * Kept last on purpose: SM8750 reuses this list without POWER_NOW,
> +	 * see sm8750_bat_psy_desc.
> +	 */
> +	POWER_SUPPLY_PROP_POWER_NOW,
>  };
>  
>  static const struct power_supply_desc sm8550_bat_psy_desc = {
> @@ -931,6 +936,23 @@ static const struct power_supply_desc sm8550_bat_psy_desc = {
>  	.property_is_writeable = qcom_battmgr_bat_is_writeable,
>  };
>  
> +/*
> + * The SM8750 QBG firmware fills BATT_POWER_NOW from its maximum-load updater
> + * instead of from an instantaneous measurement, so the published value is not
> + * a present power reading (it reports the maximum load, e.g. 89 W while the
> + * battery is actually charging below 1 W).  Do not advertise POWER_NOW on
> + * this platform.
> + */
> +static const struct power_supply_desc sm8750_bat_psy_desc = {
> +	.name = "qcom-battmgr-bat",
> +	.type = POWER_SUPPLY_TYPE_BATTERY,
> +	.properties = sm8550_bat_props,
> +	.num_properties = ARRAY_SIZE(sm8550_bat_props) - 1,
> +	.get_property = qcom_battmgr_bat_get_property,
> +	.set_property = qcom_battmgr_bat_set_property,
> +	.property_is_writeable = qcom_battmgr_bat_is_writeable,
> +};
> +
>  static int qcom_battmgr_ac_get_property(struct power_supply *psy,
>  					enum power_supply_property psp,
>  					union power_supply_propval *val)
> @@ -1617,6 +1639,7 @@ static const struct of_device_id qcom_battmgr_of_variants[] = {
>  	{ .compatible = "qcom,sc8180x-pmic-glink", .data = (void *)QCOM_BATTMGR_SC8280XP },
>  	{ .compatible = "qcom,sc8280xp-pmic-glink", .data = (void *)QCOM_BATTMGR_SC8280XP },
>  	{ .compatible = "qcom,sm8550-pmic-glink", .data = (void *)QCOM_BATTMGR_SM8550 },
> +	{ .compatible = "qcom,sm8750-pmic-glink", .data = (void *)QCOM_BATTMGR_SM8750 },
>  	{ .compatible = "qcom,x1e80100-pmic-glink", .data = (void *)QCOM_BATTMGR_X1E80100 },
>  	/* Unmatched devices falls back to QCOM_BATTMGR_SM8350 */
>  	{}
> @@ -1690,7 +1713,9 @@ static int qcom_battmgr_probe(struct auxiliary_device *adev,
>  			return dev_err_probe(dev, PTR_ERR(battmgr->wls_psy),
>  					     "failed to register wireless charing power supply\n");
>  	} else {
> -		if (battmgr->variant == QCOM_BATTMGR_SM8550)
> +		if (battmgr->variant == QCOM_BATTMGR_SM8750)
> +			psy_desc = &sm8750_bat_psy_desc;
> +		else if (battmgr->variant == QCOM_BATTMGR_SM8550)
>  			psy_desc = &sm8550_bat_psy_desc;
>  		else
>  			psy_desc = &sm8350_bat_psy_desc;
