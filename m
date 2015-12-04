From: James Morse <james.morse@arm.com>
Subject: Re: [PATCH v3 09/10] PM / Hibernate: Publish pages restored in-place
 to arch code
Date: Fri, 04 Dec 2015 16:26:41 +0000
Message-ID: <5661BEC1.5040400@arm.com>
References: <1448559168-8363-1-git-send-email-james.morse@arm.com> <1448559168-8363-10-git-send-email-james.morse@arm.com> <20151203120925.GA2220@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:55328 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754657AbbLDQ1e (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 4 Dec 2015 11:27:34 -0500
In-Reply-To: <20151203120925.GA2220@red-moon>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Will Deacon <will.deacon@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Kevin Kang <kkang@intrinsyc.com>, Geoff Levand <geoff@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, wangfei <w.f@huawei.com>, Marc Zyngier <marc.zyngier@arm.com>

Hi Lorenzo,

On 03/12/15 12:09, Lorenzo Pieralisi wrote:
> On Thu, Nov 26, 2015 at 05:32:47PM +0000, James Morse wrote:
>> @@ -2427,25 +2434,31 @@ static void *get_buffer(struct memory_bitmap *bm, struct chain_allocator *ca)
>>  	if (PageHighMem(page))
>>  		return get_highmem_page_buffer(page, ca);
> 
> I know it is not a problem for arm64, but you should export the
> "restored" highmem pages list too because arch code may need to use
> it for the same reasons this patch was implemented.

I'm not sure it can be for the same reasons:
kernel/power/snapshot.c:swap_two_pages_data() does the copy for highmem
pages, and then kunmap-s them... if the page is to be used for
execution, it needs to be re-mapped first, possibly at a different address.
The place to do cache maintenance is in the kunmap/kmap calls.


Thanks,

James
