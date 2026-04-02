Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B2D23A564
	for <linux-pm@vger.kernel.org>; Thu,  2 Apr 2026 01:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775093160; cv=none; b=e22cF+zIEIab/75A/Wur/ZN1KbcMam9Fo2UopKKkQx2i8uGkiPKV2sZaAeuPzXMRumaBj6WIfmt+xd7IAD2rBW7a1DfYQpcu1G/sK29xaFTW1ku7WPPa32fl57MFWJMSRTvYvbX/aJBoBjUb7hcg8cOlLEwprokgtpXwgqmUVRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775093160; c=relaxed/simple;
	bh=evfYIKJkPHZ9+yUV/8inPLH60gyR9XmPjdvpEZbmVHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vft0qidoJYNYRoLLaqkeBJT7wi4INbqp9ZwWSmCWXJt8KScLpj8yhXQdLvXYSuAAvbfeOzPaZ0bCkLMBv7kLwfqH+9CDgPO0zNepmHxEeqCn3FmPbOXvomKikeHVO0npVEeqt1fd/UbR8fTMhoL2gvGMnueaUr/g4e8Gce48BVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pWvMSrP3; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pWvMSrP3"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2c5b3d8eab1so1118475eec.1
        for <linux-pm@vger.kernel.org>; Wed, 01 Apr 2026 18:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775093159; x=1775697959; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w0TTSvzfniH028lzX8No8jAcQ7PnQHkFWjL5CrlFmII=;
        b=pWvMSrP3g3ebFOk9pjA+H3/BmMbMXn55mhxlpTneELsRD5dm9b3Z13QXPMg2wNxWJj
         peOALi5jY/t49jCgxJCk+Awr2EJypLlL+IuRnVWsUidtpceq7KW5crNXY51Rg15XzMXq
         ubwZ12FgnPQK8HJSLDyOfbblGV/s1rTXWnbNkkRusbXqqz7ozQXGIILiDH6LeyQAMCtR
         L2gj/QAR1elR9jjdD0Ow+6pdw/WC/MsdXUwIe4KpBjpixkgr6JQGK5mqjH65hzEZrrh1
         adc7CbKr1xMzgVqNgyjFULbvlFGSo0h38K2UYEmGZJpTThgOrVNwnefrb5r9pttNX0Re
         Fw0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775093159; x=1775697959;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w0TTSvzfniH028lzX8No8jAcQ7PnQHkFWjL5CrlFmII=;
        b=B9YjVEmximJINyI5dNyxdariKZzCc0UFLMaYhekHkdz6khbs18eg6DUdt3rnlJ8Mur
         SPd50pzNCXNintitjg2mJC3PmGZRn5J1V41L81a87A0Cs+w9F7mwIw84Hc5/wPhMb73x
         eFKA2+eaM1GtMjwFeOp9AaeyyNN1U97b6Micqy50Z8dWQJ+x6n1ylgOQi2n3uk1HROtM
         g6rUYun6G9oCjGEOjaAmt18Rhych7zMCqfBF5BNRxZAL9NdEasnZG4eOZxlPLLyc6ME0
         iixRxgWFCXgFDjHs4d9UM6Rmg66DQ0lo+IbEl6FdHPBUNWz6SL4iNmhc+ZoXZs0bUpyb
         IlmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqQofJjCoInuUszAmtF7a8DUNV/lhMfQAJFFuWOld7SteF9XNL9ggLFQrwKjDpqBkF4ODBhpn1zA==@vger.kernel.org
X-Gm-Message-State: AOJu0YySozhSv3d5CrPpjEe5nF111fMMYRTzjeOEsJuwviWVP3A60q4U
	6IQ6A6Yx6eJHRwAIann6PVzMI/YYKkVMvNprAh0DuAidbESrfe7G8X4R3Z4XtooS5Q==
X-Gm-Gg: ATEYQzxTOETdKxVnpDGBAtSNnQwitLk1jTAxEUM3yeuHwa4kTudwiUbV2IXLpozgox8
	T3Vt2tUGAbS2g2gWAH07OfsvP6YiYZ9AeyB0CkBztEhJviv8y7ODiOh+IK3YO3J2NMzMSUd9ZA5
	5C28iPDVT2Gc1w/eWhe9FJl6/nyXWmqoqkplONMYZIF70NJ73+PcG8uhZKBFkCj0m9RlxVBwFLD
	aMNqWrmep42jRU8sUaoC0KlahlzEfp2toj140alkgBo1Z/kp0qR/9eA7JyV6w+rr5hKCSg51gZl
	6rLSWHUIkhMHD89dvlg1OmvqrIgEUJ+DNjwJBU1Npi4/kBgf0waZX3MtZVetyXob6LnNBI4bOQP
	6pOnd3b7aguvCYVm+QRWN+FGLJduCiR1N+7TthcAic/FTKBbeBQ+jc9y0TCfhs49zBUtfITMjE/
	W+Pt7r3as4pAZiLkc3C2VuWnHMOiorkm8Y+FyX3i1G8Ks2rxGaKBwqpv105Mu4OXvvi6pdj5SeZ
	J8IwQmjiohMMR2bJ7+7U5/x1A==
X-Received: by 2002:a05:7301:fa0d:b0:2c1:6676:5ebd with SMTP id 5a478bee46e88-2c930e6b1fbmr3100327eec.10.1775093158301;
        Wed, 01 Apr 2026 18:25:58 -0700 (PDT)
Received: from ?IPV6:2a00:79e0:2e7c:9:862b:f392:67fb:ffb1? ([2a00:79e0:2e7c:9:862b:f392:67fb:ffb1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca7cf1271asm1676362eec.26.2026.04.01.18.25.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2026 18:25:57 -0700 (PDT)
Message-ID: <dc670de4-2dae-4d5e-bf15-ac52c5a0868a@google.com>
Date: Wed, 1 Apr 2026 18:25:55 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 5/6] power: supply: max77759: add charger driver
To: Sebastian Reichel <sre@kernel.org>
Cc: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jagan Sridharan <badhri@google.com>, Mark Brown <broonie@kernel.org>,
 Matti Vaittinen <mazziesaccount@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Peter Griffin <peter.griffin@linaro.org>,
 Tudor Ambarus <tudor.ambarus@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, RD Babiera <rdbabiera@google.com>,
 Kyle Tso <kyletso@google.com>
References: <20260331-max77759-charger-v10-0-76f59233c369@google.com>
 <20260331-max77759-charger-v10-5-76f59233c369@google.com>
 <ac2jYUA2F5oQsA2g@venus>
From: Amit Sunil Dhamne <amitsd@google.com>
Content-Language: en-US
In-Reply-To: <ac2jYUA2F5oQsA2g@venus>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Sebastian,

Thanks for the review!

On 4/1/26 4:17 PM, Sebastian Reichel wrote:
> Hi,
>
> On Tue, Mar 31, 2026 at 11:22:20PM +0000, Amit Sunil Dhamne via B4 Relay wrote:
>> +/* Charge Termination Voltage Limits (in mV) */
>> +static const struct linear_range chg_cv_prm_ranges[] = {
>> +	LINEAR_RANGE(3800, 0x38, 0x39, 100),
>> +	LINEAR_RANGE(4000, 0x0, 0x32, 10),
>> +};
> Let me quote from include/linux/power_supply.h:
>
>  * All voltages, currents, charges, energies, time and temperatures in uV,
>  * µA, µAh, µWh, seconds and tenths of degree Celsius unless otherwise
>  * stated. It's driver's job to convert its raw values to units in which
>  * this class operates.
>
> What makes you think that CONSTANT_CHARGE_VOLTAGE_MAX is
> special?
>
> [...]

It was an oversight, I will fix it.


>
>> +static int max77759_charger_get_property(struct power_supply *psy,
>> +					 enum power_supply_property psp,
>> +					 union power_supply_propval *pval)
>> +{
>> +	struct max77759_charger *chg = power_supply_get_drvdata(psy);
>> +	int ret;
>> +
>> +	switch (psp) {
>> +	case POWER_SUPPLY_PROP_ONLINE:
>> +		ret = get_online(chg);
>> +		break;
>> +	case POWER_SUPPLY_PROP_PRESENT:
>> +		ret = charger_input_valid(chg);
>> +		break;
>> +	case POWER_SUPPLY_PROP_STATUS:
>> +		ret = get_status(chg);
>> +		break;
>> +	case POWER_SUPPLY_PROP_CHARGE_TYPE:
>> +		ret = get_charge_type(chg);
>> +		break;
>> +	case POWER_SUPPLY_PROP_HEALTH:
>> +		ret = get_health(chg);
>> +		break;
>> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
>> +		ret = get_fast_charge_current(chg);
>> +		break;
>> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
>> +		ret = get_float_voltage(chg);
>> +		break;
>> +	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
>> +		ret = get_input_current_limit(chg);
>> +		break;
>> +	default:
>> +		ret = -EINVAL;
>> +	}
>> +
>> +	pval->intval = ret;
>> +	return ret < 0 ? ret : 0;
> As people like to use existing drivers as reference this definitely
> needs a comment, that none of the properties used by this driver
> support negative values. This is not a general thing as e.g. the
> CHARGE current may be negative depending on the battery being
> charged or discharged (OTG mode).

Ah okay, thanks for letting me know. I will add a comment.


As these patches are already in flight and part of usb-next of the usb
tree, I can send the suggested improvements as a separate patch, if that
works for you and Greg.


BR,

Amit

>
> Greetings,
>
> -- Sebastian
