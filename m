From: Anisse Astier <anisse@astier.eu>
Subject: Re: [PATCH v4 1/3] PM / Hibernate: prepare for SANITIZE_FREED_PAGES
Date: Mon, 18 May 2015 12:23:00 +0200
Message-ID: <CALUN=qLrXryb-aZTjXqoUhzjz68fvOae1bDxitYcJ3jBn_1EDg@mail.gmail.com>
References: <1431613188-4511-1-git-send-email-anisse@astier.eu>
 <1431613188-4511-2-git-send-email-anisse@astier.eu> <7216052.tCNGRiLFYJ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <7216052.tCNGRiLFYJ@vostro.rjw.lan>
Sender: owner-linux-mm@kvack.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, Mel Gorman <mgorman@suse.de>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, David Rientjes <rientjes@google.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, PaX Team <pageexec@freemail.hu>, Brad Spengler <spender@grsecurity.net>, Kees Cook <keescook@chromium.org>, Andi Kleen <andi@firstfloor.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, linux-mm@kvack.org, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

Thanks for taking the time to review this.

On Sat, May 16, 2015 at 2:28 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Thursday, May 14, 2015 04:19:46 PM Anisse Astier wrote:
>> SANITIZE_FREED_PAGES feature relies on having all pages going through
>> the free_pages_prepare path in order to be cleared before being used. In
>> the hibernate use case, free pages will automagically appear in the
>> system without being cleared, left there by the loading kernel.
>>
>> This patch will make sure free pages are cleared on resume; when we'll
>> enable SANITIZE_FREED_PAGES. We free the pages just after resume because
>> we can't do it later: going through any device resume code might
>> allocate some memory and invalidate the free pages bitmap.
>>
>> Signed-off-by: Anisse Astier <anisse@astier.eu>
>> ---
>>  kernel/power/hibernate.c |  4 +++-
>>  kernel/power/power.h     |  2 ++
>>  kernel/power/snapshot.c  | 22 ++++++++++++++++++++++
>>  3 files changed, 27 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
>> index 2329daa..0a73126 100644
>> --- a/kernel/power/hibernate.c
>> +++ b/kernel/power/hibernate.c
>> @@ -305,9 +305,11 @@ static int create_image(int platform_mode)
>>                       error);
>>       /* Restore control flow magically appears here */
>>       restore_processor_state();
>> -     if (!in_suspend)
>> +     if (!in_suspend) {
>>               events_check_enabled = false;
>>
>> +             clear_free_pages();
>
> Again, why don't you do that at the swsusp_free() time?

Because it's too late, the kernel has already been through device
resume code, and the free pages bitmap isn't valid anymore; device
resume code might allocate memory, and we'd be clearing those pages as
well.


>> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
>> index 5235dd4..2335130 100644
>> --- a/kernel/power/snapshot.c
>> +++ b/kernel/power/snapshot.c
>> @@ -1032,6 +1032,28 @@ void free_basic_memory_bitmaps(void)
>>       pr_debug("PM: Basic memory bitmaps freed\n");
>>  }
>>
>> +void clear_free_pages(void)
>> +{
>> +#ifdef CONFIG_SANITIZE_FREED_PAGES
>> +     struct memory_bitmap *bm = free_pages_map;
>> +     unsigned long pfn;
>> +
>> +     if (WARN_ON(!(free_pages_map)))
>
> One paren too many.

Thanks, will be fixed.

>
>> +             return;
>> +
>> +     memory_bm_position_reset(bm);
>> +     pfn = memory_bm_next_pfn(bm);
>> +     while (pfn != BM_END_OF_MAP) {
>> +             if (pfn_valid(pfn))
>> +                     clear_highpage(pfn_to_page(pfn));
>
> Is clear_highpage() also fine for non-highmem pages?
>

Yes, it works fine for low memory too because kmap_atomic will just
return the page address if it's already mapped.

Regards,

Anisse

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
