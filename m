Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793698645;
	b=2p1af+hsmjYlItOXAVn143L3QraC27524ipFRRrCx8GTvMdKdlgPKa6VMX6C2UHK11GO
	 geH5j6iZty+kZx79Phx/lBLpS+T5J2yfsWoQ1R323/xH9V1B7frHcS7VDOAEE6vyr5m69
	 E4GCBHe8EHAa15ncAZ64zOB7h7ntpYk1mk/qXGzgfwrJs+2JOeOIsSi0jTDTLc2LHbY+F
	 iYCi9GwIELpY5iDbP4hj5SkzwsSJIZukgQcTpdvyFMIMrw55fnWgf/PbQHDZ2y/qURLHn
	 QJ/fI53sCbkeFQK870GmzxMQtRfWjfyVgqEiklErpGxVf4zp88iacwV0LcP7hmWeD0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793698645;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:From:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=lZRs1mh8clZfojHLrAwgtXfzj6EvyuT7nj0JvBT+Z5E=;
	b=SuLhe58brUaeJIuxxT4HgZo8AZ7LSlpoE9LODRrtpeR4iQWTk+p2I1mSiPWudktJwTEz
	 Ffrhtjg0pKStC7elhWxAVm//Rh6bWuEjBVo4zWC9GIqL01RpGYRZ0EMrs9+ZyTF9C49nb
	 chKstneiXsUEmM6aGvfaeAVx3ChLaARZ7HA+769hbuYwHwb91yVXLeJ1XgqAEXlpsJIBl
	 K+DajQ75Ykv0RXc+dEmK6z9I5r8msoTesIa+EMT2sB9bNDcw/p3B97/fGPOhLHZTJYzgh
	 A/lm7Q/e9sXeKJt9yFxKKHlSA2wXE9eMRfbE+HqmrXBz+wBBdw/EKIrAzEVXkHStYQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=j6z1gFE9;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC39606A324;
	Tue,  3 Nov 2026 09:37:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0DC39606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=j6z1gFE9
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E74F16F3;
	Tue,  3 Nov 2026 01:37:20 -0800 (PST)
Received: from [10.57.15.76] (unknown [10.57.15.76])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BE8E73F632;
	Tue,  3 Nov 2026 01:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793698643; bh=7QDQ7pc/gnWwpqj4MUth7NieA0YgqoBhtCAT6FAK5mk=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=j6z1gFE9FN6ZhKEuSuCr1zTfgj6efFtTQmZpYQKWkpGAqWkIxXGcGYEdE6tJQtL0k
	 Fmf4hivKP1c0+iTQX1hXn4BLPhjHTd1TRISiMjuloQmS0ylhsTnU0qm+QBLWeDaPld
	 9z5MEO2WiiV58NnfR9CUDT/Osmgpx14CozX6muwc=
Message-ID: <2c3df215-3f64-4697-805f-11e6e39c7d4d@arm.com>
Date: Tue, 3 Nov 2026 09:37:51 +0000
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
From: Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [PATCH] PM: EM: Rank boost and non-boost frequencies separately
To: Guo Chen <guo.chen@oss.qualcomm.com>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 Matthias Kaehlcke <mka@chromium.org>,
 Vincent Donnefort <vincent.donnefort@arm.com>, Len Brown <lenb@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, xin.liu@oss.qualcomm.com,
 aiqun.yu@oss.qualcomm.com, tengfei.fan@oss.qualcomm.com,
 tingwei.zhang@oss.qualcomm.com, Pavel Machek <pavel@kernel.org>
References: <20261030-em-rank-boost-separately-v1-1-238a6b2bb888@oss.qualcomm.com>
 <3ed2a68b-d066-4a3a-b3ed-30a5ca00ae38@arm.com>
 <738c61fa-0397-4faa-acae-e9b42f901d1d@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <738c61fa-0397-4faa-acae-e9b42f901d1d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Guo

On 11/3/26 07:16, Guo Chen wrote:
> 
> On 11/2/2026 11:28 PM, Lukasz Luba wrote:
>>
>>
>> On 10/30/26 08:10, Guo Chen wrote:
>>> em_compute_costs() ranks all the frequencies of the table, boost ones
>>> included. A non-boost frequency can be marked inefficient only because
>>> a faster boost frequency has a lower or equal cost, e.g.
>>>
>>>    3.9 GHz  4.0 GHz (cost C)  4.1 GHz (boost, cost C)
>>>

[snip]

>>> +        bool boost = table[i].frequency > max_nonboost;
>>> +
>>> +        if (boost != prev_boost) {
>>
>> We expect in EM fwk that the frequencies are sorted ascending
>> and we return error during setup if the driver callback fails
>> to provide that.
>> Therefore, in this code we don't have to deal with random
>> 'boost' labels with gaps between.
>>
> Hi Lukasz,
> 
> Thanks for the review.
> 
> You are right. The boundary is derived from the highest non-boost
> frequency, so with an ascending table the boost states always form a
> contiguous top segment, and prev_boost is redundant.
> 
>> Let's make all OPPs which are 'boost' equally possible
>> to reach (at least in theory), so label them as
>> 'efficient'. I think this is fair in 'boosting' case scenario
>> and energy has not that importance in it.
>>
>> So simply something like, would be enough IMHO:
>>
>> if (boost)
>>     prev_cost = ULONG_MAX;
>>
> Agreed, this is simpler and gives the same result for the non-boost
> states. Boost states are no longer compared with each other, which is
> also a sensible semantic. I will drop prev_boost and use the above in v2.

Cool, please make sure in your new implementation for the
corner case with the first non-boost OPP from top to be marked as
efficient (you can even force that).

Regards,
Lukasz

> 
> Thanks,
> Guo
