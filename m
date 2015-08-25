From: Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm/khugepaged: Allow to interrupt allocation sleep again
Date: Tue, 25 Aug 2015 11:08:24 +0200
Message-ID: <55DC3088.7050701@suse.cz>
References: <1440429203-4039-1-git-send-email-pmladek@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:48553 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754002AbbHYJI2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 25 Aug 2015 05:08:28 -0400
In-Reply-To: <1440429203-4039-1-git-send-email-pmladek@suse.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Petr Mladek <pmladek@suse.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, David Rientjes <rientjes@google.com>, Ebru Akagunduz <ebru.akagunduz@gmail.com>, Mel Gorman <mgorman@suse.de>, linux-mm@kvack.org, linux-pm@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

On 08/24/2015 05:13 PM, Petr Mladek wrote:
> The commit 1dfb059b9438633b0546 ("thp: reduce khugepaged freezing
> latency") fixed khugepaged to do not block a system suspend. But
> the result is that it could not get interrupted before the given
> timeout because the condition for the wait event is "false".
>
> This patch puts back the original approach but it uses
> freezable_schedule_timeout_interruptible() instead of
> schedule_timeout_interruptible(). It does the right thing.
> I am pretty sure that the freezable variant was not used in
> the original fix only because it was not available at that time.
>
> The regression has been there for ages. It was not critical. It just
> did the allocation throttling a little bit more aggressively.
>
> I found this problem when converting the kthread to kthread worker API
> and trying to understand the code.
>
> Signed-off-by: Petr Mladek <pmladek@suse.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>   mm/huge_memory.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 7109330c5911..eb115aaa429c 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2368,8 +2368,12 @@ static void __collapse_huge_page_copy(pte_t *pte, struct page *page,
>
>   static void khugepaged_alloc_sleep(void)
>   {
> -	wait_event_freezable_timeout(khugepaged_wait, false,
> -			msecs_to_jiffies(khugepaged_alloc_sleep_millisecs));
> +	DEFINE_WAIT(wait);
> +
> +	add_wait_queue(&khugepaged_wait, &wait);
> +	freezable_schedule_timeout_interruptible(
> +		msecs_to_jiffies(khugepaged_alloc_sleep_millisecs));
> +	remove_wait_queue(&khugepaged_wait, &wait);
>   }
>
>   static int khugepaged_node_load[MAX_NUMNODES];
>

