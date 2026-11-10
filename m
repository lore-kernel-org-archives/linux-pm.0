Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794349543;
	b=4mjhJiFmWk/KiOFvYtsbazoTl3JnSdIJrZG+MRdHUHxEo+eItWVYi7vUaeNniEpaGBMt
	 hY/wIwCFyEI+LcTf8ag1XGdEXElfvQLefnJ8GHTrqr51S2dpVDhd3iwJs76/hEsRbjixu
	 yk2cNu1SXbFPGxDUwx14EIkjLfuQtEPyT7lFHyklwmKSjIfQBWtGVEwTtTU/GPPkhmGeM
	 mp2z7Jr/1UeO6dNYcwRu/4YN5BDca1GAGnBiS3IOoWF/XQVj4eXhpPiuaGJqtVPd40ton
	 hdHlT3u7W20niGfynmpkEwFTN8PFESGlP3QBKd0oh+mR6QBcIoRJ2euQq1ERLJiQWWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794349543;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=rFR07zZ7CA7ruaUhfGP1DElQrItxL3fk+/y1XmeQu+8=;
	b=3TRufTBE1ladAoSquEW75Na3lXz15ubZwHYa3NCHHAEEIMRXwymM66c8YtWOnRQJrT9h
	 Gqhlg2X5pZrSUycKH9TVhPog54n/ZBECMp6ElMP5/I5mrpJqeQSQLFGZTA+HjbJPnITS/
	 QM/MBxH+bxhn80V3Gwbvd+EWEh7mp4s0vKBLlDwv81DL2RXVBqV5UhWAJSJ8OSqS5nC3D
	 z3chY2oV9CtXiXy8X8gbz4mwjZ5pA1G+jqEYZ5RsjnUa7gJ4yEBg1WGN+6FjDlPPR2c0J
	 B3Vau93UgjMv0ISDx2kVRW2m/AIYU3GqKX2c8bhwMCZxH0VId5AY4osIWVB6F+Vvmyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=FWX9bXuO;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30552606A31C;
	Tue, 10 Nov 2026 22:25:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30552606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=FWX9bXuO
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 409261477;
	Tue, 10 Nov 2026 14:25:38 -0800 (PST)
Received: from [10.57.15.53] (unknown [10.57.15.53])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 428183F85F;
	Tue, 10 Nov 2026 14:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794349541; bh=oW7L7gPeQ+Ay/BcA5QLJVKSf56GeWibtLdxcGOAqMVk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FWX9bXuOdn5hcICHmtU+lwoFmjGyd1NcsjGjnuGgUtNERi8vxN4MmDhwkmUMXI0DI
	 L3AJAmnZfZiHtLq5sEmZU4lTUW5MIGj+dyXnL8r6pctqKEOFvP7ra/7sAGoDYN9QWo
	 kSMBbryUgpV8D60U3mH4oBh5rv1o85Si1K9jN6cE=
Message-ID: <77dc00cf-49ce-4f3e-a2fd-32c80f9b8b5a@arm.com>
Date: Tue, 10 Nov 2026 22:25:38 +0000
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
Subject: Re: [PATCH 1/2] cpuidle: Skip miss accounting for timer broadcast
 fallbacks
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261030083633.1699270-1-christian.loehle@arm.com>
 <20261030083633.1699270-2-christian.loehle@arm.com>
 <CAJZ5v0g7gZH=Eod5xXcP0adN1r=-eLqpKA-CpS+hYXjgndZFHg@mail.gmail.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <CAJZ5v0g7gZH=Eod5xXcP0adN1r=-eLqpKA-CpS+hYXjgndZFHg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/10/26 20:16, Rafael J. Wysocki (Intel) wrote:
> On Fri, Oct 30, 2026 at 9:36 AM Christian Loehle
> <christian.loehle@arm.com> wrote:
>>
>> A failed tick_broadcast_enter() can force a shallower state than the
>> governor selected. Exclude successful broadcast fallbacks from above/below
>> miss accounting while retaining their usage, residency and governor
>> feedback.
> 
> Is this a theoretical problem, or can it be observed in practice?
> 
> In either case, it would be good to add some information on that here.

It's very much a real problem, see the cover letter, it's about 5% of
the accounted idle_misses on arm64.

> 
>> Fixes: 04dab58a39d4 ("cpuidle: Add 'above' and 'below' idle state metrics")
>> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
>> ---
>>  drivers/cpuidle/cpuidle.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
>> index 2d2f40a2cb81..faa29f58738e 100644
>> --- a/drivers/cpuidle/cpuidle.c
>> +++ b/drivers/cpuidle/cpuidle.c
>> @@ -222,6 +222,7 @@ noinstr int cpuidle_enter_state(struct cpuidle_device *dev,
>>
>>         struct cpuidle_state *target_state = &drv->states[index];
>>         bool broadcast = !!(target_state->flags & CPUIDLE_FLAG_TIMER_STOP);
>> +       bool broadcast_failed = false;
>>         ktime_t time_start, time_end;
>>
>>         instrumentation_begin();
>> @@ -232,6 +233,7 @@ noinstr int cpuidle_enter_state(struct cpuidle_device *dev,
>>          * CPU as a broadcast timer, this call may fail if it is not available.
>>          */
>>         if (broadcast && tick_broadcast_enter()) {
>> +               broadcast_failed = true;
>>                 index = find_deepest_state(drv, dev, target_state->exit_latency_ns,
>>                                            CPUIDLE_FLAG_TIMER_STOP, false);
>>
>> @@ -306,6 +308,13 @@ noinstr int cpuidle_enter_state(struct cpuidle_device *dev,
>>                 dev->states_usage[entered_state].time_ns += diff;
>>                 dev->states_usage[entered_state].usage++;
>>
>> +               /*
>> +                * The broadcast constraint forced a shallower state, do not
>> +                * account for it as a cpu_idle_miss.
>> +                */
>> +               if (broadcast_failed)
>> +                       goto out;
>> +
>>                 if (diff < drv->states[entered_state].target_residency_ns) {
>>                         for (i = entered_state - 1; i >= 0; i--) {
>>                                 if (dev->states_usage[i].disable)
>> @@ -338,6 +347,7 @@ noinstr int cpuidle_enter_state(struct cpuidle_device *dev,
>>                 dev->states_usage[index].rejected++;
>>         }
>>
>> +out:
>>         instrumentation_end();
>>
>>         return entered_state;
>> --
>> 2.34.1
>>

