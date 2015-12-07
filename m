From: James Morse <james.morse@arm.com>
Subject: Re: [PATCH v3 09/10] PM / Hibernate: Publish pages restored in-place
 to arch code
Date: Mon, 07 Dec 2015 11:28:44 +0000
Message-ID: <56656D6C.5010004@arm.com>
References: <1448559168-8363-1-git-send-email-james.morse@arm.com> <1448559168-8363-10-git-send-email-james.morse@arm.com> <20151205093534.GA7569@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:36232 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755927AbbLGL3i (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 7 Dec 2015 06:29:38 -0500
In-Reply-To: <20151205093534.GA7569@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <will.deacon@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Kevin Kang <kkang@intrinsyc.com>, Geoff Levand <geoff@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, wangfei <w.f@huawei.com>, Marc Zyngier <marc.zyngier@arm.com>

Hi Pavel,

On 05/12/15 09:35, Pavel Machek wrote:
> On Thu 2015-11-26 17:32:47, James Morse wrote:
>> Some architectures require code written to memory as if it were data to be
>> 'cleaned' from any data caches before the processor can fetch them as new
>> instructions.
>>
>> During resume from hibernate, the snapshot code copies some pages directly,
>> meaning these architectures do not get a chance to perform their cache
>> maintenance. Create a new list of pages that were restored in place, so
>> that the arch code can perform this maintenance when necessary.
> 
> Umm. Could the copy function be modified to do the neccessary
> flushing, instead?

The copying is done by load_image_lzo() using memcpy() if you have
compression enabled, and by load_image() using swap_read_page() if you
don't.

I didn't do it here as it would clean every page copied, which was the
worrying part of the previous approach. If there is an architecture
where this cache-clean operation is expensive, it would slow down
restore. I was trying to benchmark the impact of this on 32bit arm when
I spotted it was broken.

This allocated-same-page code path doesn't happen very often, so we
don't want this to have an impact on the 'normal' code path. On 32bit
arm I saw ~20 of these allocations out of ~60,000 pages.

This new way allocates a few extra pages during restore, and doesn't
assume that flush_cache_range() needs calling. It should have no impact
on architectures that aren't using the new list.


> Alternatively, can you just clean the whole cache before jumping to
> the new kernel?

On arm64, cleaning the whole cache means cleaning all of memory by
virtual address, which would be a high price to pay when we only need to
clean the pages we copied. The current implementation does clean all the
page it copies, the problem is the ~0.03% that are copied behind its
back. This patch publishes where those pages are.



Thanks!

James

