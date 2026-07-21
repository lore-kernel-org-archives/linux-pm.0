Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB645480959;
	Tue, 21 Jul 2026 10:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784630601; cv=none; b=iJv1cyzyJGYSD2OT1sUCv02yidBl6FC5SJnPe+4IrWAuZ9H4MJpX4kS3HvsNmC8YyjbbVzSSpmEg2XiExKLH4S8jqvAbHBteY2HOsbEueb2YBeREGOLNlbQXr79pHJ4egCrKnTF6HpN3PoS5oFjva+/nQD7/ZKg3KuSimpT4hOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784630601; c=relaxed/simple;
	bh=ArAK5eqqqsAwRJw9a12ekL0SmbGFQuXBHELKAchUZ2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XKnrGSrOQRc+5jb95GHjRdeePX+WWzl3v3JEufMQpjj+Vlrce9HLP3aj3xiD6uYcuZ3JbC5shUqLiFRAO5S9fACndBjwfpMX+9E/I21m6Vnfb1FHckGHziczLtrfG4y+LtqNIuNmaKpMp7XIarFBdSmaGCl2XFLp70ZJEN73MAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=crWUlhcA; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="crWUlhcA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1784630591;
	bh=ArAK5eqqqsAwRJw9a12ekL0SmbGFQuXBHELKAchUZ2A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=crWUlhcAh3AbBhIOV9712HCInJrmYECt0XPRLkQQ+8axoEOnwGU8Czco2MEe3Ppyj
	 e9ewF0Fo/mfM8ZYrrw6fLbFlU2cp/RZoxQWEqAMRqNauF2Sr1pmL0GvQwO1x034ied
	 OJn4Zwq42CDE59ECSzH9BLRRGgr4UWQ9wW8KM4/8yfHpTFipYX2eBFjVQz7S0GuUQz
	 Apf+6IDXSjsWXOchI/oRA5XHNBsPMYW7m+cehXIUirM3505ACZ+IAlXcnzN/idpwzw
	 HV9tnVP0+7nRfF3RelmhW4RtzxCxOXtHpoODUNPl2jKyvdmGczykkEGWztpD10330N
	 Wbtzf8PT6ufrQ==
Received: from [100.64.1.21] (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 02E4117E0018;
	Tue, 21 Jul 2026 12:43:10 +0200 (CEST)
Message-ID: <8a9aed82-5f0c-4ad8-91c5-1e1ac169781d@collabora.com>
Date: Tue, 21 Jul 2026 12:43:10 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal/drivers/mediatek/lvts_thermal: Make reset
 optional for MT8196
To: Philipp Zabel <p.zabel@pengutronix.de>, rafael@kernel.org
Cc: daniel.lezcano@kernel.org, rui.zhang@intel.com, lukasz.luba@arm.com,
 matthias.bgg@gmail.com, laura.nao@collabora.com, fshao@chromium.org,
 wenst@chromium.org, jiapeng.chong@linux.alibaba.com,
 frank-w@public-files.de, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, kernel@collabora.com
References: <20260720144244.88877-1-angelogioacchino.delregno@collabora.com>
 <16651472d6a782bdef63e1c9742444de08c59f1e.camel@pengutronix.de>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <16651472d6a782bdef63e1c9742444de08c59f1e.camel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/21/26 09:53, Philipp Zabel wrote:
> On Mo, 2026-07-20 at 16:42 +0200, AngeloGioacchino Del Regno wrote:
>> Depending on the SoC+Firmware combination, the LVTS hardware may be
>> may be actively used by one or even multiple concurrent MCUs!
>> In this case, resetting it may produce either a severe slowdown of
>> the entire system, or even a thermal protection AP reset, as some
>> MCU(s) may be reading a very high or very low temperature while the
>> LVTS is being reset.
>>
>> On those, don't fail if no reset is found as that may be omitted on
>> purpose, but still check if there's one, because some board(s) may
>> be running on a different bootchain with reduced firmwares or using
>> firmwares with reduced functionality.
>>
>> Add a new "optional_reset" member to lvts_data and use it to check
>> whether the resets should be mandatory or not.
>>
>> Also, while at it, since devm_reset_control_get_by_index() is now
>> deprecated, change the probe function to instead call function
>> devm_reset_control_get_exclusive_by_index(), which does the same.
> 
> Why is this using _by_index() at all? mediatek,lvts-thermal.yaml
> specifies a single reset, so the driver should just
> devm_reset_control_get_exclusive(dev, NULL).
> 
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   drivers/thermal/mediatek/lvts_thermal.c | 29 ++++++++++++++++++++++---
>>   1 file changed, 26 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
>> index 92711896ce24..6670b5458f2c 100644
>> --- a/drivers/thermal/mediatek/lvts_thermal.c
>> +++ b/drivers/thermal/mediatek/lvts_thermal.c
>> @@ -160,6 +160,7 @@ struct lvts_data {
>>   	int gt_calib_bit_offset;
>>   	unsigned int def_calibration;
>>   	u16 msr_offset;
>> +	bool optional_reset;
> 
> No need to complicate things. It's not the driver's business to check
> device tree correctness. Just make the reset optional, as the commit
> message says.
> 
>>   };
>>   
>>   struct lvts_sensor {
>> @@ -1473,9 +1474,29 @@ static int lvts_probe(struct platform_device *pdev)
>>   	if (IS_ERR(lvts_td->base))
>>   		return dev_err_probe(dev, PTR_ERR(lvts_td->base), "Failed to map io resource\n");
>>   
>> -	lvts_td->reset = devm_reset_control_get_by_index(dev, 0);
>> -	if (IS_ERR(lvts_td->reset))
>> -		return dev_err_probe(dev, PTR_ERR(lvts_td->reset), "Failed to get reset control\n");
>> +	/*
>> +	 * Depending on the SoC+Firmware combination, the LVTS hardware may be
>> +	 * may be actively used by one or even multiple concurrent MCUs!
>> +	 * In this case, resetting it may produce either a severe slowdown of
>> +	 * the entire system, or even a thermal protection AP reset, as some
>> +	 * MCU(s) may be reading a very high or very low temperature while the
>> +	 * LVTS is being reset.
>> +	 *
>> +	 * On those, don't fail if no reset is found as that may be omitted on
>> +	 * purpose, but still check if there's one, because some board(s) may
>> +	 * be running on a different bootchain with reduced firmwares or using
>> +	 * firmwares with reduced functionality.
>> +	 */
>> +	lvts_td->reset = devm_reset_control_get_exclusive_by_index(dev, 0);
> 
> So this should be:
> 
> 	lvts_td->reset = devm_reset_control_get_optional_exclusive(dev, NULL);
> 
>> +	if (IS_ERR(lvts_td->reset)) {
>> +		if (lvts_data->optional_reset) {
>> +			dev_dbg(dev, "No reset found. LVTS may be used by firmware.\n");
>> +			lvts_td->reset = NULL;
> 
> This is not necessary then.
> 
>> +		} else {
>> +			return dev_err_probe(dev, PTR_ERR(lvts_td->reset),
>> +					     "Failed to get reset control\n");
>> +		}
> 
> And this part could be kept as before.
> 
>> +	}
>>   
>>   	irq = platform_get_irq(pdev, 0);
>>   	if (irq < 0)
>> @@ -2163,6 +2184,7 @@ static const struct lvts_data mt8196_lvts_mcu_data = {
>>   	.num_cal_offsets = LVTS_NUM_CAL_OFFSETS_MT8196,
>>   	.msr_offset = LVTS_MSR_OFFSET_MT8196,
>>   	.ops = &lvts_platform_ops_mt8196,
>> +	.optional_reset = true,
> 
> But mediatek,lvts-thermal.yaml still specifies the reset as required
> for mediatek,mt8196-lvts-ap. That should be changed instead.
> 
>>   };
>>   
>>   static const struct lvts_data mt8196_lvts_ap_data = {
>> @@ -2175,6 +2197,7 @@ static const struct lvts_data mt8196_lvts_ap_data = {
>>   	.num_cal_offsets = LVTS_NUM_CAL_OFFSETS_MT8196,
>>   	.msr_offset = LVTS_MSR_OFFSET_MT8196,
>>   	.ops = &lvts_platform_ops_mt8196,
>> +	.optional_reset = true,
> 
> Same as above, but for mediatek,mt8196-lvts-mcu.
> 

Ack. Will send a v2 shortly.

Thanks,
Angelo
