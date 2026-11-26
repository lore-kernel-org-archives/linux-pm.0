Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795705310;
	b=yNc5YjpcT4vyHtjiKdFliS84UrTXioNIp4NeXv4I3ViSiphfwQjD61ajthWXo3dmUeB9
	 wC3aKTahBGvn0i8F4QUo8/HN2iJPYIEEKFighSxJlOnL10btrPQ6onRALebRTOpGNWU53
	 v/021MaZ2XSy6mQ3MiQ/6quTcpbHSxxRuivvpMdzV205CbkH6LqUJeiPs+Uui2vdCN6vA
	 YHjGUPQQZA4xxaTPYxS4KBMy+xkKhnn27jF1phgRGA1VnAiI+YeQruRcAp7edP0nSmalo
	 p/oSfPrxNiM5+V1Tx5295CsbiYzTmgvKzCtIryztVR8wUSqH8ZiC2vp2EweUZayzqZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795705310;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=9pYcO5w1lWnU3LcG/lV8xW3siO5fUaDfkMFhAjIz8xI=;
	b=cBhr9unbwQDok1jJRvZLX1fIn9r2V0nrBK5iO2XseXPOZ9T4oGURwrs0APWO1N52Pdrg
	 hOsZsh1moQU69qGF35UOtNiaVYfqN74u2ujbT1Ku33tfBOrt/XK1LRDj7pTf3yGCPY7CQ
	 yLAQwsMe4xQVuAI2ylyZqht3B2NUq/9SFmuNWmZ7BhS6d52dGmg8Ur+cOpRzSUBCnIowC
	 IUEJSOeeySO9+uu7F/uPexmCvkqpLc2qZ4+iO9+se4dR0yrf9+wCVCBdmSGAb+SJzAfI6
	 Y3fH6SYouh3TqeIvq0cs2KcXtP9zxYbay6/6zGkNuYdZQ6mblPxzLQxpZe3Ix1KxcEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=mGdON0z5;
	arc=none smtp.remote-ip=209.85.218.47
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EC9606A33D
	for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 15:01:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59EC9606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=mGdON0z5
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c4395d31228so1212448766b.1
        for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 07:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795705309; x=1796310109; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9pYcO5w1lWnU3LcG/lV8xW3siO5fUaDfkMFhAjIz8xI=;
        b=mGdON0z5Hd2gUiYXS+tF/sU4H5tRqVTowVDdto0ksgy9JEQhONQYVH1Rt5nx8L4xnj
         ukoUh93VXrojd4IOz6idsh/09361GsT+h7sDiIWt1vQ7QTd9LamPcxkPIl8Stz3bQxck
         wTIvIhtJGHKGlvtNt71ValTst3GOG9fMLz6BCFzT7Ck+46i930sDGnRklTBTyZ0LBZCH
         jiTXzEBfUDgsTFjT0+Yh6uXQPKh8pRnbrmdgAPqUF8lCskQ06Nnm4QA0rsWdXo7YanGs
         zH5HUpl0PCr8jJnsrOcD1jPY4o7DzWgs644rj80UXaEo24gnzyTc44VTz3NJfOFkYEfm
         qOkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795705309; x=1796310109;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9pYcO5w1lWnU3LcG/lV8xW3siO5fUaDfkMFhAjIz8xI=;
        b=qzGq5u0YFz654TDRhz7Kyv+oG97IPYLgLYFTRffY3IBHbrmVsWjJGB9mEH9rSyz2fS
         4OsFbXd+UGw+53GcDZOZmXn0U02rptbq0FlR7ek+m/SX+Tw2E5v/SZWtCPH5zEmXI7j7
         ThcCnJeuMKMkHJhrampR56B7bQ9qq+FaEbDk96fk2U7ycUMulUTk32KLzcCghsvmMP7f
         VQcSA+mMebSy7eyGBhhZY47rd+hMCO1rGf6jc4OQcsdzGU+eaaB/esDuDOFvyWZ4UdHC
         uI5Ml5YqPJXgedjqqvDnMPWd8HvPYfQ7uOZoIZ9/sbZL/nhmaN2i70CsqoYVmCyhlT1/
         T/fw==
X-Forwarded-Encrypted: i=1; AL+hErHh0h3WUSuK4ovCakO+MQtmuG16rj0lwqfNVXd4bMQfY+CP3pIW7HcoyVN4yuPFsQLNdZzINulGGg==@vger.kernel.org
X-Gm-Message-State: APuU4Z9IZwbTL/V/XmMmPvk/4c7xUtVj08jFaZfuMJQejXunAnOXwJQS
	1MYvG4AovbBjtrm/4rXHSgE2wCL/et2pcX77y4viDddo/MeGkBY+PVDHO4645m/FTbk=
X-Gm-Gg: AZFdTZco0Zw/0kq+2/CZ/7QvdwXe12SDyfLyhrxrXSyuxQLBumQqibZywbOdBsjn8Zn
	P9zFHix4X2lTzfFYGBDRMmPPphghKjgKWoe8dXe3cY1jNAc1JraUwNxgox9ruFk51AFPs24ehLH
	k1KCf4cuQbp2FD4DPzt3zIgT5ggIdYYtrYbQEJ1HOhk0D2WZz/AkpQWphOQgLYWNvN+UQoTy+Pl
	NKyJ9Hx3PtPDwiSfkBNUssX9apHVxZ/u12tPSkWbtoVy2asN06wRSbrX46orVjpqFf1lU7pMudw
	wYwgxMHE4v5YhjPdKQ5wyxGeGM0bSzTGVrBKdGaGtKYReY09oFWUBJIiR0hNNgkArGz1S9RV2OJ
	T1akP7M1p3crXa5wgD1Zk6u4nOiOTd/2f48RxgdrJ52rhVuB/zadCKvd0vvmjx4K33FS02L+4Bn
	sCfd7KN2/ixlcG6Mjuhms7b1JRBwJCI4mGnwUDxwwnKu2XJh8FmJqkv/lZepThJKwyT6soR9AjG
	vUMm5dWNpWVIeu5BXlPxhXtwZCE1LJlBl4luud000by1+s3pGsUXDqIoVi5iJaSdaxKqhjccH07
	9kcthWnP4dBSkQGdWLy5Y3tvaeilqSz/jC3PbA==
X-Received: by 2002:a17:906:d54d:b0:c51:cbde:cbd7 with SMTP id a640c23a62f3a-c51cbded0bbmr129708166b.17.1795705308647;
        Thu, 26 Nov 2026 07:01:48 -0800 (PST)
Received: from [10.11.12.111] ([79.115.63.240])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a67fe75sm47430756f8f.24.2026.11.26.07.01.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 07:01:48 -0800 (PST)
Message-ID: <e329ce21-5a24-4301-9328-917d0ae4fdb1@linaro.org>
Date: Thu, 26 Nov 2026 17:01:45 +0200
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3] thermal/drivers/samsung/acpm-tmu: Fix spurious CPU
 throttling
To: Alexey Klimov <alexey.klimov@linaro.org>,
 Christian Loehle <christian.loehle@arm.com>
Cc: bzolnier@gmail.com, krzk@kernel.org, rafael@kernel.org,
 daniel.lezcano@kernel.org, lukasz.luba@arm.com,
 linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-pm@vger.kernel.org, =?UTF-8?Q?Andr=C3=A9_Draszik?=
 <andre.draszik@linaro.org>, Peter Griffin <peter.griffin@linaro.org>,
 Juan Yescas <jyescas@google.com>
References: <20261125173959.2198116-1-christian.loehle@arm.com>
 <CANgGJDp02H7-wLv6DoaPMeiy4UvDUC2nvSR=+mngEZ+Z4Hqgog@mail.gmail.com>
 <2162b02c-642a-446c-973e-ca80607da294@arm.com>
 <CANgGJDrnH7R9aTXhH-nj710OjwNcUTfpxE7eWGSP=9a3eoUnug@mail.gmail.com>
 <4adc1712-3608-4fd7-9eba-79b129c67b77@linaro.org>
 <DN586284T46G.271ABU0A683IZ@linaro.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <DN586284T46G.271ABU0A683IZ@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 11/26/26 4:50 PM, Alexey Klimov wrote:
> On Thu Nov 26, 2026 at 2:43 PM GMT, Tudor Ambarus wrote:
>>
>>
>> On 11/26/26 1:51 PM, Alexey Klimov wrote:
>>> On Thu, 26 Nov 2026 at 10:50, Christian Loehle <christian.loehle@arm.com> wrote:
>>>>
>>>> On 11/26/26 09:16, Alexey Klimov wrote:
>>>>> Hi Christian, Tudor,
>>>>>
>>>>> On Wed, 25 Nov 2026 at 17:40, Christian Loehle <christian.loehle@arm.com> wrote:
>>>>>>
>>>>>> acpm_tmu_set_trips() supplies two thresholds, but the ACPM command writes
>>>>>> all eight slots, zero-filling the rest. On GS101, slot 7 limits CPU clocks
>>>>>> independently of its interrupt mask. Setting it to 0 C limits all three
>>>>>> clusters to about 200 MHz while cpufreq reports the requested frequencies.
>>>>>> This was found through trial and error while tracking EAS regressions.
>>>>>
>>>>> Cpufreq reports the requested frequencies — are these cached values
>>>>> being reported?
>>>>> Or is this what the kernel gets via the ACPM call?
>>>>
>>>> Requested frequencies are reported. The 200MHz I only deduced from PMU counters.
>>>
>>> Tudor, your thoughts?
>>> Is ACPM reporting an incorrect rate or are those cached values?
>>
>> Both. I checked with debug prints in cpufreq:
>>
>> - scaling_cur_freq returns the cached policy->cur.
>> - cpuinfo_cur_freq gets the freq via ACPM call. The value always matched
>>   policy->cur
>>
>> So ACPM reports the DVFS level it was asked to set, not the throttled
>> clock. With the hot trip lowered via sysfs so that the slot 7 throttle
>> engages, on the X1 (cpu6):
>>
>>       zone     cycles/s (perf)   scaling_cur_freq   cpuinfo_cur_freq
>>       68 C     0.85-1.21 GHz     2802000            2802000
>>
>> Without throttling, the three agree (e.g. 2.19 GHz measured, 2188000
>> reported).
>>
>> It would be good to specify in the commit message that the governors
>> don't see the throttle. Something like:
>>
>> Program slot 7 from the lowest hot trip. Above that temperature the
>> firmware throttles the CPU clusters on its own, without cpufreq or the
>> thermal governors noticing, so the hot trip must stay above the range
>> where the governors regulate. This matches the downstream setup.
> 
> Ain't that mean that ACPM ->dvfs.set_rate() call doesn't work?

No, set_rate() works. Without throttling, the measured frequency follows
every requested level (1.80/2.25/2.76 GHz at the cluster maxima, 2.19 GHz
for 2188000, and scaling_max_freq caps take effect). FREQ_GET returns the
level that was set; the throttle is applied by hardware below that level.

> I don't remember all the detauls but I think you mentioned that
> downstream doesn't execute set_rate() ACPM call and does the SFR
> (mmio) reads, basically what we have on Exynos850.
> 

Downstream sets CPU rates through ACPM as well: cal_dfs_set_rate() calls
exynos_acpm_set_rate() for ACPM vclks and caches the rate in vclk->vrate.
cal_dfs_get_rate() returns that cached value and only asks ACPM when
nothing is cached. So GS101 doesn't need the E850 approach, since its
firmware implements FREQ_GET.

> What about clocks and corresponding PLL clocks?
> 

Upstream has no CMU_CPUCLx driver. I'd expect a PLL readback to show the
DVFS level too.

Cheers,
ta
