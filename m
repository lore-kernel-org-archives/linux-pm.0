From: Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm/khugepaged: Allow to interrupt allocation sleep again
Date: Tue, 25 Aug 2015 11:12:46 +0200
Message-ID: <55DC318E.3090608@suse.cz>
References: <1440429203-4039-1-git-send-email-pmladek@suse.com>
 <20150824133043.23b66633b5c9c91bd6aae190@linux-foundation.org>
 <20150825084217.GB22739@pathway.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20150825084217.GB22739@pathway.suse.cz>
Sender: owner-linux-mm@kvack.org
To: Petr Mladek <pmladek@suse.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, David Rientjes <rientjes@google.com>, Ebru Akagunduz <ebru.akagunduz@gmail.com>, Mel Gorman <mgorman@suse.de>, linux-mm@kvack.org, linux-pm@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>
List-Id: linux-pm@vger.kernel.org

On 08/25/2015 10:42 AM, Petr Mladek wrote:
> On Mon 2015-08-24 13:30:43, Andrew Morton wrote:
>> On Mon, 24 Aug 2015 17:13:23 +0200 Petr Mladek <pmladek@suse.com> wrote:
>>
>>> The commit 1dfb059b9438633b0546 ("thp: reduce khugepaged freezing
>>> latency") fixed khugepaged to do not block a system suspend. But
>>> the result is that it could not get interrupted before the given
>>> timeout because the condition for the wait event is "false".
>>
>> What are the userspace-visible effects of this bug?
>
> I believe that the change will not make any visible difference. It
> is just a bit cleaner code.
>
> If I get it correctly. This function is called when the daemon
> is not able to allocate any new huge page. It is used to throttle the
> attempts. Then the thread is waken in the following situations:
>
>     + when user modifies "alloc_sleep" or "scan_sleep" from sysfs;
>       this is rare

I guess somebody could set a high alloc_sleep value by mistake, and then 
try to fix it back, but khugepaged would keep sleeping until the high 
value expires.

>     + in __khugepaged_enter() when there is a new page to scan and
>       the list was empty before. This is because the same waitqueue
>       is used to wait between scans. IMHO, it is kind of bug to mix
>       these two things. But I guess that this wake is rare as well.
>       Also I guess that it will be solved by Vlastimil's rework.

Yeah this shouldn't matter much.

>     + when the kthread is stopped; this is the only place when it could
>       make a visible difference if the sleep is longer; but this is
>       rare situation as well

If this is what happens on shutdown, it could be indeed annoying to wait 
30 seconds (but I don't know if that's how shutdown works?).

>
> Best Regards,
> Petr
>
>>> This patch puts back the original approach but it uses
>>> freezable_schedule_timeout_interruptible() instead of
>>> schedule_timeout_interruptible(). It does the right thing.
>>> I am pretty sure that the freezable variant was not used in
>>> the original fix only because it was not available at that time.
>>>
>>> The regression has been there for ages. It was not critical. It just
>>> did the allocation throttling a little bit more aggressively.
>>>
>>> I found this problem when converting the kthread to kthread worker API
>>> and trying to understand the code.
>>>
>>> ...

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
