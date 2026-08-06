Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B204B049C
	for <linux-pm@vger.kernel.org>; Thu,  6 Aug 2026 23:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786060561; cv=none; b=rzwpoiQdenRd74eCpcO5D60cWtwLZnNSDF4lLM6oXj8/hFN4Cn6v+XcaEOcuKFDzQZ9HEXJCYZDeJ7dfgJ6zmPGr1x+BgJ7t20l+n7vy4HaJbu0QixWt6clVQtPE5Q5EUHqCjsY5wCnu+X7dw+mbWkwxMAEFGu4yjPMberAet9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786060561; c=relaxed/simple;
	bh=Yzna//NwtR8zPjpm9cs8EXwZP+V0ywgfzo046gOQPio=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B4WDqzEU1hw2VnS1xcOXhk4N7mZt0KBLVh1k9Pv1J0Z1o81uUhAAx5xkkdH/TazHLFe/CZdF0xaRsSwmrV/mCeDzM5lG4GnFYNGJGK5i5ZsHsn4GtcrbeysZCpanQrl8aHkNnWXsnSyx2aUwPuBsBaaSQ9AMvvo1UYa3NZfdXP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d1K03ep2; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d1K03ep2"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-84a652535dcso1889034b3a.3
        for <linux-pm@vger.kernel.org>; Thu, 06 Aug 2026 16:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786060559; x=1786665359; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C/T+n8sN5VnkglxyfMBw6K8D9WLEnW5GbMB82HdKKrE=;
        b=d1K03ep2e50w/0jsAC/zKw00Xf7HwSVljrNl57yYUddSu03oPP0O4l0RhSgaAZ9mmB
         fTpcYSnnxRDL31dmYM+glTYU98XskX03xvRJ1LHfBPm/cWfW6oTCwwlCKTIt/cJZNa/j
         bguAQbMMSQtzUWvz7ui4WxtC4+7gTmt2QG56XHwzgAXyY/eIDgDyM7Pkvc5ZZ0grAbxk
         J7iiXgx3BjFl6FE43XXMQ0ySQCMWcsZY7HBjhRbisaNq+kTQ/ONPy/W9agKAflzheblQ
         nnsaLV469hMdFHvnPndDdpBgQt5o2oMnkaNEfDtGBEOrLLNhA1dtRe+HIkkdGkbK4UAn
         v3OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786060559; x=1786665359;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C/T+n8sN5VnkglxyfMBw6K8D9WLEnW5GbMB82HdKKrE=;
        b=nYaog5+k6pyokFD5xqxhGSmRY/SJSAjfgsfCwhTRyzIJYJnmHPRZAcZ8NYdxce03wg
         Z4QM7IAVTtO5yD9kquEziIBeZDwa3XMp6o2Gz39qGbd9hFzWtTtFtiefdW5tGAA1JKik
         bn5AOohQjrwA5F+A1Nl4QVZCXUrpwkOFuUS7J8hZthdRHffDVhvs1R9XHeQsm/XyQb2k
         aPS9PBC44IHaCS2yY2RY4HQ+KE1S3KvIoEANrvLWlkMj+evHFQPLjYf7zFvk4/lE4owJ
         fH+mWx5yjPiXhHnHshJ8l568bSMNYkgANWNV5Yi04yvmbZPROa1aDf532zXPfldpcGGM
         JoyA==
X-Forwarded-Encrypted: i=1; AHgh+Rr9aaIooXl+4ibg4yPf7iYxBvEw6TkE6xN+jEM/JVd1KAyUFuwjRAA4DlNJzvhlIB7h9mauOteIPQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzQIi2B76eR5aegiOXdm3RePUx6olidmgBwxLAa+VrpdeMciUdg
	KdywKW4ZeNEWZ25EGymHCLopCbnT439/Ji5hbLYKPdI32mtvU+Y/Y5ykFyHx8njSRw==
X-Gm-Gg: AR+sD11jDw0Ql0ACplngKV8p6u8A7LPFkZoewUrzXzEHbJGApTZjGI5JLzYaadDTzST
	6k9Fjwglk17J6crHBegSAqoIUc6tDY1UaVZiuSgLJiYA7qtwFn8BAXzxlCVdx1+W7/vN2Ri+A8X
	A5obbFD6Z3ijYcX39pxdC+N8MprsZk0Z4robwGxWjMnUyDRR0qy1HxBZQdMauVP7qdXe1urTcWH
	Fk7fa3CtbE29r2K2yGpexKAD8MdvnOoM4hZ8PkI6E/ck3YOnq1GQN03T/llq6603eRjBH4MO9G0
	twjja64Jbm7WmJ69UJ5ArekGC5YI3EQ/onlbHRt4RlDqF7QdAFDeUf3KI5xk1ig9TTkd5XIe1IQ
	gtXaYOwU9J5HylD3WBXj4aKEIjmHoud8XaPMbRepnM2oSzv3vien9Z4Q+dIffHVeZ75NqmtvKac
	w5rQeQ9f7rRhzEXebLG3D6WfRHvOqX6c/iP7jsvbPxP/FDx9MjLkGbc8XNDkqg5r6xah5gcQGeW
	ow7M01xRx/D6k+MvodttQeKyrVkZVAzKuXCWo26z0U3XUyqiRL/5+NmmYtt2Ok6y8cqSbxu87zF
	Y3f7FfoOm61QueLjuwin7pueLkM=
X-Received: by 2002:a05:6a20:da12:b0:3b4:75c0:3ec0 with SMTP id adf61e73a8af0-3cb85ea6f79mr21308619637.30.1786060557536;
        Thu, 06 Aug 2026 16:55:57 -0700 (PDT)
Received: from ?IPV6:2a00:79e0:2e7c:8:b0e:e09a:2979:5a02? ([2a00:79e0:2e7c:8:b0e:e09a:2979:5a02])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315be86f98esm344844eec.6.2026.08.06.16.55.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 16:55:56 -0700 (PDT)
Message-ID: <a37923ca-ce08-43c7-bc90-19c63b7a5830@google.com>
Date: Thu, 6 Aug 2026 16:55:54 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] usb: typec: tcpm: Add support for Battery Status
 response message
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Badhri Jagan Sridharan <badhri@google.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hans de Goede <hansg@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
 Purism Kernel Team <kernel@puri.sm>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Tudor Ambarus <tudor.ambarus@linaro.org>,
 Peter Griffin <peter.griffin@linaro.org>, RD Babiera <rdbabiera@google.com>,
 Kyle Tso <kyletso@google.com>
References: <20260714-batt-status-v5-0-9de4aa900b69@google.com>
 <20260714-batt-status-v5-2-9de4aa900b69@google.com> <amVJ1u67qHENBQ5l@venus>
 <5cdf0238-24f8-402f-a72a-d490f8d9c99a@google.com> <amvLtvDbJ8g-1rJ3@venus>
Content-Language: en-US
From: Amit Sunil Dhamne <amitsd@google.com>
In-Reply-To: <amvLtvDbJ8g-1rJ3@venus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sebastian,


On 7/30/26 3:24 PM, Sebastian Reichel wrote:
> Hi,
> 
> On Wed, Jul 29, 2026 at 05:56:29PM -0700, Amit Sunil Dhamne wrote:
>> [...]
>>
>>>> +/*
>>>> + * As per USB PD Spec Rev 3.18 (Sec. 6.5.13.11), the number of fixed batteries
>>>> + * that a port can be queried is restricted to 4.
>>>> + */
>>>> +#define MAX_NUM_FIXED_BATT				4
>>>
>>> If I understand the spec correctly, the presence of a fixed battery
>>> should never change for fixed batteries. I guess the rationale is,
>>> that one only has to the battery capabilities once for these kind of
>>> batteries. But for the Linux kernel this concept does not exist and
>>> all batteries are potentialle hot-swappable. For real hardware with
>>> TCPM and hot-swappable battery, this code will now incorrectly
>>> expose them as fixed battery and violate the spec. I think this should
>>> at least be mentioned in the commit message.
>>>
>>
>> You are completely right. I was approaching this primarily from the
>> smartphone side (Pixel 6), where batteries are effectively fixed and
>> inaccessible to the user. Because I don't have a setup with TCPM +
>> hot-swappable (in the context of the spec) batteries to test with, I only
>> implemented the fixed case.
>>
>> I mentioned this constraint in the cover letter, but I agree it could
>> have been in the commit message as well. Since Greg has already picked
>> this series up into his tree, I can't amend the commit message now.
>> However, if you think it's necessary, I can send a small incremental
>> patch to add a comment in the code clarifying this assumption.
>> Otherwise, we can leave it as-is until someone has the hardware to
>> properly implement and test the hot-swappable support. Let me know what
>> you prefer.
> 
> You tested only the fixed variant, but your implementation is in the
> generic TCPM and does not check if it runs on a Pixel 6. If you
> touch generic code you need to think generic :)
> 
> Generally I would expect it is "safer" to expose batteries as
> hot-swappable when they are fixed than the other way around.
> FWIW the kernel's power-supply framework has no concept of fixed
> batteries.
> 

Misclassifying a battery would lead to compliance failures. Also, 
classifying a fixed battery as hot-swappable (even if it's a telemetry 
message to the port partner) may indicate to users that it's safe to 
hot-swap batteries which may not be the case (either for mechanical 
reasons or data corruption when suddenly removing battery from live 
battery powered devices). So I don't think it'd be safer.

Would it make sense to introduce a device-tree property (e.g., something 
like fixed-batteries label) so the hardware can explicitly define this? 
Let me know what you think the best path forward is.

>>>> [...]
>>>> +	batt = port->fixed_batt[batt_id];
>>>> +	ret = power_supply_get_property(batt, POWER_SUPPLY_PROP_PRESENT, &val);
>>>> +	if (ret)
>>>> +		tcpm_log(port,
>>>> +			 "Failed to fetch power_supply_prop_present ret %d",
>>>> +			 ret);
>>>> +	else
>>>> +		batt_present = val.intval > 0;
>>>> +
>>>> +	ret = power_supply_get_property(batt, POWER_SUPPLY_PROP_CHARGE_NOW,
>>>> +					&val);
>>>> +	if (!ret) {
>>>> +		charge_now = val.intval;
>>>> +		ret = power_supply_get_property(batt,
>>>> +						POWER_SUPPLY_PROP_VOLTAGE_AVG,
>>>> +						&val);
>>>> +		if (!ret) {
>>>> +			energy_now = div_u64((u64)charge_now * val.intval,
>>>> +					     1000000);
>>>> +
>>>> +			/*
>>>> +			 * Battery Present Charge is reported in
>>>> +			 * increments of 0.1WH.
>>>> +			 */
>>>> +			present_charge = (u16)UW_TO_W(energy_now * 10);
>>>> +		}
>>>> +	}
>>>> [...]
>>>
>>> What about fuel gauges, which expose POWER_SUPPLY_PROP_ENERGY_NOW
>>> instead of POWER_SUPPLY_PROP_CHARGE_NOW?
>>
>> Good point. Our fuel gauge uses charge_* properties, so charge_now was
>> sufficient for our immediate use case, but it makes sense to support
>> energy_now natively for other users.
>>
>> Since the original patch is already merged, I could write an incremental
>> follow-up patch that checks POWER_SUPPLY_PROP_ENERGY_NOW first, and if
>> it's not supported, falls back to calculating it via CHARGE_NOW *
>> VOLTAGE_AVG. Please let me know if this works?
> 
> That sounds sensible to me.

I will send a new patch for this.

Regards,
Amit

> 
> Greetings,
> 
> -- Sebastian

