From: James Morse <james.morse@arm.com>
Subject: Re: [PATCH v3 09/10] PM / Hibernate: Publish pages restored in-place
 to arch code
Date: Wed, 16 Dec 2015 09:55:41 +0000
Message-ID: <5671351D.3090109@arm.com>
References: <1448559168-8363-1-git-send-email-james.morse@arm.com> <1448559168-8363-10-git-send-email-james.morse@arm.com> <20151205093534.GA7569@amd> <56656D6C.5010004@arm.com> <20151208081923.GA22680@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:54171 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932907AbbLPJ4i (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 16 Dec 2015 04:56:38 -0500
In-Reply-To: <20151208081923.GA22680@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <will.deacon@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Kevin Kang <kkang@intrinsyc.com>, Geoff Levand <geoff@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, wangfei <w.f@huawei.com>, Marc Zyngier <marc.zyngier@arm.com>

Hi Pavel,

On 08/12/15 08:19, Pavel Machek wrote:
>> I didn't do it here as it would clean every page copied, which was the
>> worrying part of the previous approach. If there is an architecture
>> where this cache-clean operation is expensive, it would slow down
>> restore. I was trying to benchmark the impact of this on 32bit arm when
>> I spotted it was broken.
> 
> You have just loaded the page from slow storage (hard drive,
> MMC). Cleaning a page should be pretty fast compared to that.

(One day I hope to own a laptop that hibernates to almost-memory speed
nvram!)

Speed is one issue - another is I don't think its correct to assume that
any architecture with a flush_icache_range() function can/should have
that called on any page of data.

There is also the possibility that an architecture needs to do something
other than flush_icache_range() on the pages that were copied. (I can
see lots of s390 hooks for 'page keys', Intel's memory protection keys
may want something similar...)

This patch is the general-purpose fix, matching the existing list of
'these pages need copying' with a 'these pages were already copied'.


>> This allocated-same-page code path doesn't happen very often, so we
>> don't want this to have an impact on the 'normal' code path. On 32bit
>> arm I saw ~20 of these allocations out of ~60,000 pages.
>>
>> This new way allocates a few extra pages during restore, and doesn't
>> assume that flush_cache_range() needs calling. It should have no impact
>> on architectures that aren't using the new list.
> 
> It is also complex.

Its symmetric with the existing restore_pblist code, I think that this
is the simplest way of doing it.


>>> Alternatively, can you just clean the whole cache before jumping to
>>> the new kernel?
>>
>> On arm64, cleaning the whole cache means cleaning all of memory by
>> virtual address, which would be a high price to pay when we only need to
>> clean the pages we copied. The current implementation does clean all
> 
> How high price to pay? I mean, hibernation/restore takes
> _seconds_. Paying miliseconds to have cleaner code is acceptable
> price.

I agree, but the code to clean all 8GB of memory on Juno takes ~3
seconds, and this will probably scale linearly. We only need to clean
the ~250MB that was copied by hibernate, (and of that, only the
executable pages). The sticking point is the few pages it copies, but
doesn't tell us about.

I will put together the flush_icache_range()-during-decompression
version of this patch... it looks like powerpc will suffer the most from
this, from the comments, its flush_icache_range() code pushes data all
the way out to memory...


Thanks,

James
