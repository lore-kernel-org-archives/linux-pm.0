Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8D35226B6
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 13:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792070875; cv=none; b=Hylln1sEggzl0QLeYKgHDZpvabNClqpE8qVYd435v9ko/Ax64HyTsKCu4WeBhtQX/DBc1Y6oUlQIeSE32V0dW/VTTzDlSdQVnOJvKtgjh0CD92rSd8GkVxv/1Zo7HPflnnX681juFFWFyCUWbYbGc+vGiU05S12SH8McNUIKsWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792070875; c=relaxed/simple;
	bh=Cy5efQytt+41nF34oSFTJHXGoIio5RSUN47XHf9W3yo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=PxXwu7pzp8GC7Aiy08cuO1g2dewu6UppQJ5rVSK5jm/kLE8+JnkDEddtNpbbRmT8kJHx+LQ9NOZ7BETdU5GIGvB119Rahp/JDnwv6carJ7qLVGyceYdQI0cI9+VUrARDwKhlHu4ZgQno7tltd1HaDz8ssX867GbTi9tx2mb96W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HJ0Xs7fo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VkGbNMMB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HJ0Xs7fo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VkGbNMMB"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F9jgdb3510197
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 13:27:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BOf15NrdkxiPINzdwNBadsG1wlt6SXt9rit5Z9dSmV0=; b=HJ0Xs7foraW16FLZ
	1oX4YqrOsDoSmz+Yu+eG9Y5grHQdrgFlERSKYtZ9bxwVz8OWItS5Uy7Zp7NfExy7
	8mBZUXr4RRxksr88UYO2WLe4PPV3HukslXP6mpx3zmb1j/g6bcFPK1CIIzXXOOnn
	KJHaqtHZXqDWe+wl3wppEfaAYRBn2wzJDLcF1t6OpjjokBuoYEMpST4LG2KPMycW
	Ms27Htc80OG7bh8B/2jomg2EycNy3oW7/8P9x2KhXzv2LHBJoRHsGF5/gb7Bur3D
	C8U6tASJ2zh/AFYF092T4oOd39Gb92OCQnKIv+TI+6Ucm0GPbywrQBCT7BmAb6Jm
	UlTtpg==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haqdsa7xj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 13:27:52 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-7c100f6f8ffso204937137.3
        for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 06:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792070872; x=1792675672; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BOf15NrdkxiPINzdwNBadsG1wlt6SXt9rit5Z9dSmV0=;
        b=VkGbNMMBIRFBenJR/fFjCKb8p8U1n63QupPM698D71Dke0EjL96t6TU9NVGAkFrO3C
         G0r482QNI48/L+AYPmlB3XReG05k1h5oshCwFGZx1hLjx4pPumsAfO6Vxe0i9AT57wHt
         CyY/DrtRXxqiX1A5FA6EJR9Po6z2choyRKIILAAAifP+DUV/hgbjMaOe6vnVziIkWdwX
         wpqoJLvIKo5ghCOXXKn0Vo3t8Zrw6M9qW3eV0PTFp7LJ3zj6jmLK4IxA0tcjRRmE17gY
         G7Hhn/Uaxku9hIFmLUn8+oiXhM75c2Y2vzqllMNt5p1LOYSHdaO4G3incjbEJruHk8ql
         Tksw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792070872; x=1792675672;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BOf15NrdkxiPINzdwNBadsG1wlt6SXt9rit5Z9dSmV0=;
        b=IQ2P+mdBjQGl5VBmQdS0X5+Rtlgrx+PcNc9y5piZUZvcrYjTToVmo7I5CvAUXbUD+n
         HJz3EBUR9EzfAAjP0XvGTXi2KVWg1VIQbmsyjrwgycZiy6Xn5/5xR/jTMEe0N8b3Clri
         QbToSRAjPf0BV9OD3ueqYQl1MmBah/cmeaUeY8QEwsFXuNJc7ioUP8jDjtS1z2X6isBL
         iaQRKI4VXA3MTycfdJ3QlTzSy5lGDXmiv92ORl1H5lqgi4q41v+ZZT8QMxiUJR/a20Bf
         83f1Guni962SfkA3kRfd8QiVDjTPG8uha3Z8lam97uLr4kVtnjbC9bRbbWXYFetEyx1B
         /+HQ==
X-Forwarded-Encrypted: i=1; AKwUvBzXZVBzQpE35AlRlpdbQB5UEGVRv0wgq4cRRFf8lhVvY8A1VI76Ta7NYsS62K8UD9u3EuLTFQlJ8g==@vger.kernel.org
X-Gm-Message-State: AFq9FYI5spftKHC/hJnaEYU9cvVqVo9RgsuzBzROjV+hCzoZXma082pX
	7gMZVxDZADgfOvdSwKCZx3k2emxlP3JISrjX+c9uZBJFoSeHxP7RV6CwateIEFcv0fUzkbG2G50
	bIi9anaUqAV6wu5L/8xn4SyzMRw6U70ejNfTnNv++LCCzjIuXJZ/UC3OB/Vhh0Q==
X-Gm-Gg: AYBFou3tqcLdBV+1l1MDyFV07mx7Z/KwI0/l0JhGe/9/e+AKk2S19Q2/dOQw5k/9clO
	KV/AQ8wD+xl5sh0myodeVHncTr5wMI9tzmxO7EZx15PBBbIakxzuP/DifqKwcqCHbltlqSXkzks
	2XEqV0ewHcNLkDigG1uoNTUqPoP1OEISN4GTXYc2xFNINkJ8ZAiEI8Ub8pzCGVdy/9hRCxdfde5
	53dzlXCkWE0qiC37iaYp2MFv3ApxtEI459615eZBSCmsM2AlpE6QEiu0IoOGbSgQLwKFNuvTyU9
	yubrJRLuxho9NHsP1pk5NYRHQZMklS8ppbY5RNeHQyZC+N9on6CiRJ63RupQ7FggN/RGh5GRT1F
	n/3HzJvPtu4LDrl8fa/bthg==
X-Received: by 2002:a05:6122:2c09:b0:5ea:8fce:8a45 with SMTP id 71dfb90a1353d-5ea8fce8d42mr266740e0c.5.1792070867541;
        Thu, 15 Oct 2026 06:27:47 -0700 (PDT)
X-Received: by 2002:a05:6122:2c09:b0:5ea:8fce:8a45 with SMTP id 71dfb90a1353d-5ea8fce8d42mr266728e0c.5.1792070866958;
        Thu, 15 Oct 2026 06:27:46 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b2038a6f4asm2435041a12.31.2026.10.15.06.27.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 06:27:45 -0700 (PDT)
Message-ID: <b957c95e-89b9-4e62-9e88-0c5754771511@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 15:27:43 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] power: supply: qcom_battmgr: do not report power_now on
 SM8750
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
To: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>, linux-pm@vger.kernel.org,
        Sebastian Reichel <sre@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fenglin Wu <fenglin.wu@oss.qualcomm.com>
References: <20261013002124.332111-1-xiaqinghuan@mail.ustc.edu.cn>
 <d3a67d47-9072-4094-85a0-7e1b75e08314@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <d3a67d47-9072-4094-85a0-7e1b75e08314@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: aM0ZNTLkBALyZId8K3LaMGr6RFwlXMEx
X-Authority-Analysis: v=2.4 cv=fNusTpae c=1 sm=1 tr=0 ts=6ad0d4d8 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=JDoO2zy-Mf1dR4DM0PkA:9 a=QEXdDO2ut3YA:10 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA1MyBTYWx0ZWRfX0rFSHYV/KYEY
 JMD7HRf4Esz9QfwbNVUGnVmAjiCHtVbI+DNbFjaEQt7/rx0Wwws2lqP0Gk53N/gpwWVLF4MGZEY
 h/W2ytjXqHHJ/Jvx1Pt/0yf7iEnmeUlPXfNLGynIDxc7K9BK7YQMV9P/AQZNBZc/lvmUks7EGBy
 hYkTIt2x6Ib/NDf3d+5xHclaM94q+X3a71EouQGkzFqbANoXiDcbdrPd+xNEu9k1Sj+YtbTXahF
 9OxXXSWUhHvz8ArPu/pjiYWhsDhF9FOLkhUh9rDpjgmI4XSM3wu0kslgR3Yed45NPfFIq/cP44K
 sAS4CMTCifbwlQUcRLUQMtifygGuOrVLLsYd1b68G52WnYlWow8Rv46jvE2Uy36n9B/2APzxA9X
 n7IjDenYUmvf3TJCt8JaRjXJJAEhLMIUjlpT45KkPndzkDZrQVIMqknUckU7nGccm8WAIzcmNyP
 TvSBYEB6GbBroUr9uFA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA1MyBTYWx0ZWRfXxecykSe1dGgC
 2gHma3oy2hRwl1PDbEbKV8BY61fCk/L0e8Cnjq5bSkfVCXRts72zDTQGc+iTVbJyAP43A34VwTW
 jzeLXUieYLErdl/TfddH4rQM0/Sq1FI=
X-Proofpoint-GUID: aM0ZNTLkBALyZId8K3LaMGr6RFwlXMEx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150053

On 10/15/26 3:27 PM, Konrad Dybcio wrote:
> On 10/13/26 2:21 AM, Qianhui Xu wrote:
>> From: Xu Qianhui <xiaqinghuan@mail.ustc.edu.cn>
>>
>> The SM8750 QBG firmware fills BATT_POWER_NOW via its maximum-load updater
>> instead of an instantaneous measurement: the property getter indexes
>> context + 0x6a8 + 4 * property, so property 22 (BATT_POWER_NOW) reads the
>> offset written by the maximum-load path.  Exposing that as power_now makes
>> userspace report e.g. 89 W while the battery is charging below 1 W, or
>> above 100 W while discharging at about 4 W.
>>
>> The SM8750 PMIC GLINK node is already described in DT
>> ("qcom,sm8750-pmic-glink" in sm8750-mtp/qrd), but the driver has no entry
>> for it, so it falls back to QCOM_BATTMGR_SM8350 and advertises POWER_NOW.
>>
>> Add the SM8750 variant and a battery descriptor that reuses the SM8550
>> properties without POWER_NOW.  The property array is reordered so that
>> POWER_NOW is the last entry, which keeps the new descriptor a two-line
>> addition; property ordering itself is not ABI.
>>
>> Voltage, current, charge counters and the charge-control thresholds are
>> retained.
>>
>> Tested on Lenovo Legion Y700 Gen4 (TB322FC, SM8750P): charging and
>> discharging, UPower state-of-charge and rate are unchanged and power_now
>> is no longer exposed.
>>
>> Signed-off-by: Xu Qianhui <xiaqinghuan@mail.ustc.edu.cn>
>> ---
> 
> +Fenglin would we know if this is an issue on all SM8750 devices, or
> perhaps something OEM-specific?

(helps to actually Cc someone when you say you do..)

> 
> Konrad
> 
>>  drivers/power/supply/qcom_battmgr.c | 29 +++++++++++++++++++++++++++--
>>  1 file changed, 27 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
>> index 7716eb9e1a..dbc98ac8a7 100644
>> --- a/drivers/power/supply/qcom_battmgr.c
>> +++ b/drivers/power/supply/qcom_battmgr.c
>> @@ -24,6 +24,7 @@ enum qcom_battmgr_variant {
>>  	QCOM_BATTMGR_SC8280XP,
>>  	QCOM_BATTMGR_SM8350,
>>  	QCOM_BATTMGR_SM8550,
>> +	QCOM_BATTMGR_SM8750,
>>  	QCOM_BATTMGR_X1E80100,
>>  };
>>  
>> @@ -916,9 +917,13 @@ static const enum power_supply_property sm8550_bat_props[] = {
>>  	POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG,
>>  	POWER_SUPPLY_PROP_INTERNAL_RESISTANCE,
>>  	POWER_SUPPLY_PROP_STATE_OF_HEALTH,
>> -	POWER_SUPPLY_PROP_POWER_NOW,
>>  	POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD,
>>  	POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD,
>> +	/*
>> +	 * Kept last on purpose: SM8750 reuses this list without POWER_NOW,
>> +	 * see sm8750_bat_psy_desc.
>> +	 */
>> +	POWER_SUPPLY_PROP_POWER_NOW,
>>  };
>>  
>>  static const struct power_supply_desc sm8550_bat_psy_desc = {
>> @@ -931,6 +936,23 @@ static const struct power_supply_desc sm8550_bat_psy_desc = {
>>  	.property_is_writeable = qcom_battmgr_bat_is_writeable,
>>  };
>>  
>> +/*
>> + * The SM8750 QBG firmware fills BATT_POWER_NOW from its maximum-load updater
>> + * instead of from an instantaneous measurement, so the published value is not
>> + * a present power reading (it reports the maximum load, e.g. 89 W while the
>> + * battery is actually charging below 1 W).  Do not advertise POWER_NOW on
>> + * this platform.
>> + */
>> +static const struct power_supply_desc sm8750_bat_psy_desc = {
>> +	.name = "qcom-battmgr-bat",
>> +	.type = POWER_SUPPLY_TYPE_BATTERY,
>> +	.properties = sm8550_bat_props,
>> +	.num_properties = ARRAY_SIZE(sm8550_bat_props) - 1,
>> +	.get_property = qcom_battmgr_bat_get_property,
>> +	.set_property = qcom_battmgr_bat_set_property,
>> +	.property_is_writeable = qcom_battmgr_bat_is_writeable,
>> +};
>> +
>>  static int qcom_battmgr_ac_get_property(struct power_supply *psy,
>>  					enum power_supply_property psp,
>>  					union power_supply_propval *val)
>> @@ -1617,6 +1639,7 @@ static const struct of_device_id qcom_battmgr_of_variants[] = {
>>  	{ .compatible = "qcom,sc8180x-pmic-glink", .data = (void *)QCOM_BATTMGR_SC8280XP },
>>  	{ .compatible = "qcom,sc8280xp-pmic-glink", .data = (void *)QCOM_BATTMGR_SC8280XP },
>>  	{ .compatible = "qcom,sm8550-pmic-glink", .data = (void *)QCOM_BATTMGR_SM8550 },
>> +	{ .compatible = "qcom,sm8750-pmic-glink", .data = (void *)QCOM_BATTMGR_SM8750 },
>>  	{ .compatible = "qcom,x1e80100-pmic-glink", .data = (void *)QCOM_BATTMGR_X1E80100 },
>>  	/* Unmatched devices falls back to QCOM_BATTMGR_SM8350 */
>>  	{}
>> @@ -1690,7 +1713,9 @@ static int qcom_battmgr_probe(struct auxiliary_device *adev,
>>  			return dev_err_probe(dev, PTR_ERR(battmgr->wls_psy),
>>  					     "failed to register wireless charing power supply\n");
>>  	} else {
>> -		if (battmgr->variant == QCOM_BATTMGR_SM8550)
>> +		if (battmgr->variant == QCOM_BATTMGR_SM8750)
>> +			psy_desc = &sm8750_bat_psy_desc;
>> +		else if (battmgr->variant == QCOM_BATTMGR_SM8550)
>>  			psy_desc = &sm8550_bat_psy_desc;
>>  		else
>>  			psy_desc = &sm8350_bat_psy_desc;
