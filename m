Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794349990;
	b=yyp0Hf9dVSxLZA1hw20882aTOA/rIrExj1gwkqFmNG76RO6jQyj2byIRnyAenEPu3oQI
	 G/ZAiZqddczjx166PChdCv0LvohOX5aOBzWzE1loFD1snpDx76TUDkpDDrWXB0bljV86V
	 IwZ9bgDcrYpa2Rb1Mhi0eJ17oS0QoCJLsT3Nc3hcZlVePQ/fvZn+OfgmiA0SG/6EXIFGe
	 YzX6ulH8sDssMv0XR15ElQcBrGqZ3btIujPeZC1RY8zNOTydf5yFNd5ebqkM7rj0lLa2z
	 JfM5rld+IaBl+CR/htrBVJAzByzCtoUvStb833nhp+arEZV11ja11fgsBan8WaZnc4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794349990;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=3FW5diCNs3k06MVtdXteUz+yE0Gf9dxem9tHiJxG8HU=;
	b=YueS4NqnaDeGK1sA5gE6hlkY8WPTwBNU6FFTjFEKhkiKmnddxlj1E5ViMPb8gNQ1AXgt
	 BfW/rSzY783SG8rOvsBPVMt419osVu10FdTYJjxPMw3emkdbKudW/CM0dpQUWvKI7Qknu
	 YR64eDbduONhBfQbzjHLa7Ew82wl52wq0ElaX5ic7XsUGkARCkF43D5ttjX2jgn5Ql7QS
	 /5tAZMez6ywk+xFFoZCB3fD9G2tDmzJ77nWgIcEDG85AyobbT1IpeLSb1tYYoMKkL2o1q
	 ISYNKi3Tv7h/PdjULOJ2Akhc7dQvxevQiIqk/4Uq6ILE4BHxMVadjbO0hQSEwNN4dWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b="auH9Gj/1";
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57716606A320;
	Tue, 10 Nov 2026 22:33:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57716606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=auH9Gj/1
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2BBD41477;
	Tue, 10 Nov 2026 14:33:06 -0800 (PST)
Received: from [10.57.15.53] (unknown [10.57.15.53])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 737653F85F;
	Tue, 10 Nov 2026 14:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794349989; bh=/s5ep/M3Ae57ab7uvm+FMMfWrp1SR7obtdv62rAoWE4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=auH9Gj/16YGZKmARwNrs44bJrVUuA9N1jwWMHJiMpRVeWPo0+vA52am9//HxLtas0
	 axTSU6PPQeMiXAI5fiL/JMSuh9NlOzWNH+LZy9y8EMWmBhVwhoubJPMBhyaQuUMcvZ
	 2RSjimOYChaQss5vJOfAoNV8FlaC1CBECAGpNLY4=
Message-ID: <f50285a8-61b6-4173-8f91-6259d3e595e8@arm.com>
Date: Tue, 10 Nov 2026 22:33:06 +0000
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
Subject: Re: [PATCH 2/2] cpuidle: Respect latency constraints when accounting
 below misses
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261030083633.1699270-1-christian.loehle@arm.com>
 <20261030083633.1699270-3-christian.loehle@arm.com>
 <CAJZ5v0g2wqNDxe-R9fSQW4uF5XE1uW+8UP1u2UjnDDEWRO3LpQ@mail.gmail.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <CAJZ5v0g2wqNDxe-R9fSQW4uF5XE1uW+8UP1u2UjnDDEWRO3LpQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/10/26 20:13, Rafael J. Wysocki (Intel) wrote:
> On Fri, Oct 30, 2026 at 9:36 AM Christian Loehle
> <christian.loehle@arm.com> wrote:
>>
>> Only count a below miss when an enabled deeper state meets the latency
>> constraint. Save the applicable limit before entry so QoS changes during
>> idle do not affect accounting. Continue checking disable flags on exit.
>>
>> Fixes: 04dab58a39d4 ("cpuidle: Add 'above' and 'below' idle state metrics")
>> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
>> ---
>>  drivers/cpuidle/cpuidle.c | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
>> index faa29f58738e..e9195ea8cfb6 100644
>> --- a/drivers/cpuidle/cpuidle.c
>> +++ b/drivers/cpuidle/cpuidle.c
>> @@ -219,6 +219,7 @@ noinstr int cpuidle_enter_state(struct cpuidle_device *dev,
>>                                  int index)
>>  {
>>         int entered_state;
>> +       s64 latency_req;
>>
>>         struct cpuidle_state *target_state = &drv->states[index];
>>         bool broadcast = !!(target_state->flags & CPUIDLE_FLAG_TIMER_STOP);
>> @@ -244,6 +245,8 @@ noinstr int cpuidle_enter_state(struct cpuidle_device *dev,
>>         if (target_state->flags & CPUIDLE_FLAG_TLB_FLUSHED)
>>                 leave_mm();
>>
>> +       latency_req = cpuidle_governor_latency_req(dev->cpu);
>> +
> 
> What if this is different from what the governor has used?  The limits
> may change at any time.

Right, it's just a few cycles after selection, but you're correct.
I will resend with a version that saves the used latency_req in dev.

> 
>>         /* Take note of the planned idle state. */
>>         sched_idle_set_state(target_state);
>>
>> @@ -327,7 +330,8 @@ noinstr int cpuidle_enter_state(struct cpuidle_device *dev,
>>                         }
>>                 } else if (diff > delay) {
>>                         for (i = entered_state + 1; i < drv->state_count; i++) {
>> -                               if (dev->states_usage[i].disable)
>> +                               if (dev->states_usage[i].disable ||
>> +                                   drv->states[i].exit_latency_ns > latency_req)
>>                                         continue;
>>
>>                                 /*
>> --
>> 2.34.1
>>

