Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E6037757C;
	Wed, 19 Aug 2026 08:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787129214; cv=none; b=BW3Cn2cy7L7DhPcfvMFIk357ebTGj9PSx3NXyy2Wnpx9QKxxR4yIexBCuLFBG6DQ+/II8w0w08u8+eYTiLpqzAGzFLwYMqgbuvfTS1E0fseLnou+X+1rESFlb5I2spzPNLrcoCSF/LdJUFJA/OJl8TmDf5ubFeCoMnUKIWg30AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787129214; c=relaxed/simple;
	bh=qtReDZfQcsC7dI3fNfUdgrUWPLwCfmGEEQroby26i5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XGIwKkIuguQoXG+5QUJ/M2wuNwNH9YaxuijDfKCuHKG+ZewJMZUVQxvQxrnOUn+J6Y2sVJXzyrBk0lLEpd1c7ltYkk5yctMAr+TlvIfO3JSxaMcHdnX3J8ST8nZHm4siPwmZXHI1mJW4d6Fy18XioxTChclexXf1BgLsfR95rr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=okF7yE/j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="okF7yE/j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B4F01F000E9;
	Wed, 19 Aug 2026 08:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787129212;
	bh=F1nyvbfof6JrpjrJht0isidAdnRE/sXPrd41XBUjejM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=okF7yE/jqP9CoRzMyHcPRYoWsy7fkjsUweIt+BMudn2PEXMJoKBsnciONV4blJTeJ
	 zVuIepp7tYY/n3OQy9wgR7tXOUGe05kznGDrHi7VUJYGxhmKPcgT2nE39TrBK0xUp1
	 db/Pq7Qf/ti5Bg3jXL/U0QRTN9UYEvXlHt5AUtB/jbuL4XNy50flFES+++ubi01PID
	 dgJ0SGAYtNllzJdy0cIu+P2AfMbxExnicGZB7Bbyga12WPCHl8zKzXcwMQugl2qXXq
	 +xK3rtE1rdL0j4nqcEII0iuZxZ5B2rliimxHtMMlLsmTXiHazyAtgClx8xA3naYHkr
	 kUompnMgd+V+w==
Message-ID: <021027bd-fb6e-4dca-bf16-80f6a67e8cb8@kernel.org>
Date: Wed, 19 Aug 2026 10:46:46 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] power: supply: qcom_battmgr: add Xiaomi taoyao
 support
To: Stanislav Zaikin <zstaseg@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20260818151039.409767-1-zstaseg@gmail.com>
 <20260818151039.409767-3-zstaseg@gmail.com>
 <20260819-slick-spotted-chamois-962510@quoll>
 <590e7881-de96-4de4-bb50-1e91439b92ef@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <590e7881-de96-4de4-bb50-1e91439b92ef@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/08/2026 10:37, Stanislav Zaikin wrote:
> On 8/19/26 9:11 AM, Krzysztof Kozlowski wrote:
>> On Tue, Aug 18, 2026 at 05:10:38PM +0200, user.email wrote:
>>> From: Stanislav Zaikin <zstaseg@gmail.com>
>>>
>>> The Xiaomi taoyao firmware defines an additional BATT_CONSTANT_CURRENT
>>> property (ID 12) between BATT_CHG_CTRL_LIM_MAX and BATT_TEMP, shifting
>>> all higher battery property IDs by one.
>>>
>>> Signed-off-by: Stanislav Zaikin <zstaseg@gmail.com>
>>> ---
>>>   drivers/power/supply/qcom_battmgr.c | 86 +++++++++++++++++++++++++++--
>>>   1 file changed, 82 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
>>> index 490137a23d00..390d7c75e36f 100644
>>> --- a/drivers/power/supply/qcom_battmgr.c
>>> +++ b/drivers/power/supply/qcom_battmgr.c
>>> @@ -24,6 +24,7 @@ enum qcom_battmgr_variant {
>>>   	QCOM_BATTMGR_SM8350,
>>>   	QCOM_BATTMGR_SM8550,
>>>   	QCOM_BATTMGR_X1E80100,
>>> +	QCOM_BATTMGR_TAOYAO,
>>
>> T < X, do not introduce entries in random order
> 
> Hello Krzysztof,
> Thank you for the review.
> 
> Will fix in v3.
> 
>>> @@ -1381,6 +1453,11 @@ static void qcom_battmgr_sm8350_callback(struct qcom_battmgr *battmgr,
>>>   	switch (opcode) {
>>>   	case BATTMGR_BAT_PROPERTY_GET:
>>>   		property = le32_to_cpu(resp->intval.property);
>>> +
>>> +		if (battmgr->variant == QCOM_BATTMGR_TAOYAO &&
>>> +		    property < ARRAY_SIZE(taoyao_to_canonical))
>>> +			property = taoyao_to_canonical[property];
>>
>> So device is or is not compatible with sm7325? Above code suggests that
>> it is not. How does it work when bound by sm7325 compatible?
> 
> The device is sm7325-based and when bound to sm7325-pmic-glink it falls 
> back to QCOM_BATTMGR_SM8350 property map. However, due to shifted 
> property IDs baked into taoyao's firmware the parsing of roughly the 2nd 
> half of properties is broken.
> 
> And any userspace process that reads the battery properties via sysfs 
> suffers from 1s timeouts and it basically hangs my DE.

So basically it is not compatible with sm7325-pmic-glink and it should
be expressed/fixed. I wonder though how was the DTS even tested in this
matter.

> 
> Since this is an RFC: do you think this approach is better than what I 
> described in cover letter? (manually shifting property IDs)

Every patch is RFC... or are you saying this is a RFC in a meaning it is
 not ready for review?

> 
>>> @@ -1617,6 +1694,7 @@ static const struct of_device_id qcom_battmgr_of_variants[] = {
>>>   	{ .compatible = "qcom,sc8280xp-pmic-glink", .data = (void *)QCOM_BATTMGR_SC8280XP },
>>>   	{ .compatible = "qcom,sm8550-pmic-glink", .data = (void *)QCOM_BATTMGR_SM8550 },
>>>   	{ .compatible = "qcom,x1e80100-pmic-glink", .data = (void *)QCOM_BATTMGR_X1E80100 },
>>> +	{ .compatible = "xiaomi,taoyao-pmic-glink", .data = (void *)QCOM_BATTMGR_TAOYAO },
>>
>> And here as well wrong order
> 
> Will fix in v3.
> 
> --
> Best regards,
> Stanislav
> 


Best regards,
Krzysztof
