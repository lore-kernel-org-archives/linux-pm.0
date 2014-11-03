From: Hui Zhu <teawater@gmail.com>
Subject: Re: [PATCH 0/4] (CMA_AGGRESSIVE) Make CMA memory be more aggressive
 about allocation
Date: Mon, 3 Nov 2014 16:46:23 +0800
Message-ID: <CANFwon2a2oRXaSUi3uXJwg=4T0p2yaWcGdo8SgYp+u_Ypitmvg@mail.gmail.com>
References: <1413430551-22392-1-git-send-email-zhuhui@xiaomi.com>
 <543F8812.2020002@codeaurora.org> <5450FD15.4000708@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <5450FD15.4000708@suse.cz>
Sender: owner-linux-mm@kvack.org
To: Vlastimil Babka <vbabka@suse.cz>, iamjoonsoo.kim@lge.com
Cc: Laura Abbott <lauraa@codeaurora.org>, Hui Zhu <zhuhui@xiaomi.com>, rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, m.szyprowski@samsung.com, Andrew Morton <akpm@linux-foundation.org>, mina86@mina86.com, aneesh.kumar@linux.vnet.ibm.com, hannes@cmpxchg.org, Rik van Riel <riel@redhat.com>, mgorman@suse.de, minchan@kernel.org, nasa4836@gmail.com, ddstreet@ieee.org, Hugh Dickins <hughd@google.com>, mingo@kernel.org, rientjes@google.com, Peter Zijlstra <peterz@infradead.org>, keescook@chromium.org, atomlin@redhat.com, raistlin@linux.it, axboe@fb.com, Paul McKenney <paulmck@linux.vnet.ibm.com>, kirill.shutemov@linux.intel.com, n-horiguchi@ah.jp.nec.com, k.khlebnikov@samsung.com, msalter@redhat.com, deller@gmx.de, tangchen@cn.fujitsu.com, ben@decadent.org.uk, akinobu.mita@gmail.com, sasha.levin@oracle.com, vdavydov@parallels.com, suleiman@google.com, linux-kern
List-Id: linux-pm@vger.kernel.org

On Wed, Oct 29, 2014 at 10:43 PM, Vlastimil Babka <vbabka@suse.cz> wrote:
> On 10/16/2014 10:55 AM, Laura Abbott wrote:
>>
>> On 10/15/2014 8:35 PM, Hui Zhu wrote:
>>
>> It's good to see another proposal to fix CMA utilization. Do you have
>> any data about the success rate of CMA contiguous allocation after
>> this patch series? I played around with a similar approach of using
>> CMA for MIGRATE_MOVABLE allocations and found that although utilization
>> did increase, contiguous allocations failed at a higher rate and were
>> much slower. I see what this series is trying to do with avoiding
>> allocation from CMA pages when a contiguous allocation is progress.
>> My concern is that there would still be problems with contiguous
>> allocation after all the MIGRATE_MOVABLE fallback has happened.
>
>
> Hi,
>
> did anyone try/suggest the following idea?
>
> - keep CMA as fallback to MOVABLE as is is now, i.e. non-agressive
> - when UNMOVABLE (RECLAIMABLE also?) allocation fails and CMA pageblocks
> have space, don't OOM immediately, but first try to migrate some MOVABLE
> pages to CMA pageblocks, to make space for the UNMOVABLE allocation in
> non-CMA pageblocks
> - this should keep CMA pageblocks free as long as possible and useful for
> CMA allocations, but without restricting the non-MOVABLE allocations even
> though there is free memory (but in CMA pageblocks)
> - the fact that a MOVABLE page could be successfully migrated to CMA
> pageblock, means it was not pinned or otherwise non-migratable, so there's a
> good chance it can be migrated back again if CMA pageblocks need to be used
> by CMA allocation
> - it's more complex, but I guess we have most of the necessary
> infrastructure in compaction already :)

I think this idea make CMA allocation part become complex but make
balance and shrink code become easy because it make CMA become real
memory.
I just worry about the speed of migrate memory with this idea.  :)

Thanks,
Hui


>
> Thoughts?
> Vlastimil
>
>> Thanks,
>> Laura
>>
>
> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo@kvack.org.  For more info on Linux MM,
> see: http://www.linux-mm.org/ .
> Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
