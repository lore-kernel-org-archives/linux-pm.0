Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794933698;
	b=c1jWzfBHZ6d1LOmaNLgAzAmk2NafJNbJ4nSk0NUH7nh1m+3FwRfr6sEluFCvQ4ahGQqt
	 eLSquRQ3KC4yKym6Yau2gpLKEMhWXqZ4kE8SH3t+C0KjuhAln0wk5Zc/h2AoZ/lPmZBOD
	 8YAXHh+0eGyNScVU7uyab6VI897I/wafHY9LlCoXJx3+vUzANqxggdtpsOTmz4xmweMaj
	 unTiGTinc5NjaVFnC0Ig88IWgCwekJ8OVKA3kL7/uO4+aYdJISHNPEmSLv+ktfhnj1d82
	 2N5H3qw078sgxMe9YkxilMnDxCESXd4okpS43uSPRRxPwXraVNbp0xHaBII9GSbjS8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794933698;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=lsQeeO/m5gZy4yZbSiIu6qEx1RtdKB6BMqBAZ7ZnPnk=;
	b=T8WjKRl3jrEjektAf/TXxsg6bOrRXVgYVTO0TRlZz4aLvjS3Qjmcm0e1i2pKERub85G/
	 mPZioyXeHA/oMCR0wvxZX6P4o0qnydIXqOxkfdBMdbSSSp1c6wqm9ylxYwUetAgB+fFVM
	 2a1dgJvAPFRitH5AyXEEQpYE8RqWovb4BbGMs7533rAwLE33tUcZIy60PlP9uc835RNTk
	 gKOgzYMqkEggByVgq17k4IxjoxqsG7mfqqfYxRtSXKf7lsJaG0rFRQyrLhoY3fFa+M2ti
	 k3jSOuFl8IBPFB+fuMezKkp7F9RYO4N/Do/fDrGzBEdX6dFuIQkK6i6Jiv3xUxM9yoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=ju3Fz5N1;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92807606A31C;
	Tue, 17 Nov 2026 16:41:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92807606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=ju3Fz5N1
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 892CA1A00;
	Tue, 17 Nov 2026 08:41:32 -0800 (PST)
Received: from [10.0.130.226] (e127648.arm.com [10.0.130.226])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E2BD83F632;
	Tue, 17 Nov 2026 08:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794933695; bh=YherG2Yg3jzmZQQdxvL6nZhdMSxHYpFgy9Mh2n0l1NY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ju3Fz5N1+mjPIrM823RIW38NwU7qV62Zh7p5q0HmPPxOmoVbNDq2EBNDJIon6D8LW
	 7ej62e0QvbW//vEkBPVKpj0wyAny213ewftc5z69ySbyD7fOaSlSfjpgRvPijjsOqC
	 aiuW9kY0mT/6tvHPJciGOVdDA9lI9y+e9RhqtzQ8=
Message-ID: <56a7a762-7667-4186-973c-ca0fcb399ecc@arm.com>
Date: Tue, 17 Nov 2026 16:41:32 +0000
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
Subject: Re: [PATCH] thermal: samsung: acpm-tmu: Fix spurious CPU throttling
To: Tudor Ambarus <tudor.ambarus@linaro.org>, bzolnier@gmail.com
Cc: krzk@kernel.org, rafael@kernel.org, daniel.lezcano@kernel.org,
 lukasz.luba@arm.com, linux-kernel@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
 Juan Yescas <jyescas@google.com>
References: <20261117083442.830549-1-christian.loehle@arm.com>
 <3ea5d94b-6913-4534-816a-3935c689225b@linaro.org>
From: Christian Loehle <christian.loehle@arm.com>
Content-Language: en-US
In-Reply-To: <3ea5d94b-6913-4534-816a-3935c689225b@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/17/26 15:37, Tudor Ambarus wrote:
> Hi, Christian,
> 
> Thanks for the patch!
> 
> On 11/17/26 10:34 AM, Christian Loehle wrote:
>> acpm_tmu_set_trips() supplies two thresholds, but the ACPM command
>> writes all eight slots, zero-filling the rest. On GS101, slot 7
>> controls autonomous CPU throttling even when its interrupt is masked.
>> Programming it to 0 C limits all three CPU clusters to about 200 MHz
>> on Pixel 6, while cpufreq continues to report the requested
>> frequencies.
> 
> Could you share how you discovered this? I don't have access to the
> ACPM firmware sources, and the downstream driver doesn't state it
> either.

Neither do I, I discovered this randomly through running regression tests
on Energy-Aware Scheduling on the Pixel6 and acpm-tmu (7.4-rc1) causes a
massive energy regression (+~1000%) for the same workloads.
The reason is this DVFS throttling.

> 
> How did you measure the actual CPU frequency, given that cpufreq
> keeps reporting the requested one?

PMU counters CPU_CYCLES

> 
> Do you know whether slots 2-6 have any side effects as well?

I hadn't discovered any.

> 
> Also note that Daniel has already queued a set of acpm-tmu fixes in
> thermal/linux-next, so this patch will need to be reworked on top of
> them.

will rebase then!

> 
>>
>> Program slot 7 from the zone's critical trip before enabling the
>> sensor and preserve it when updating the low/high interrupt window.
>> Cache the three temperatures so a writable critical trip can update
>> the hardware without changing that window.
> 
> I think this can be handled with a smaller change: look up the
> critical trip in .set_trips() itself. The zone lock is held there, so
> for_each_thermal_trip() can be used. That avoids caching
> low/high/critical, the .set_trip_temp() callback and the probe changes.

Ah yep you're right, will fix and resend.
Thanks!
