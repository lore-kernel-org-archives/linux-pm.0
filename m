From: Anisse Astier <anisse@astier.eu>
Subject: Re: [PATCH v3 2/4] PM / Hibernate: prepare for SANITIZE_FREED_PAGES
Date: Mon, 11 May 2015 09:59:23 +0200
Message-ID: <CALUN=q+OZFarqRoWMynRZy0ckv7qnsAQvWr9wkvdK_JmA=oomw@mail.gmail.com>
References: <1430980452-2767-1-git-send-email-anisse@astier.eu>
 <1430980452-2767-3-git-send-email-anisse@astier.eu> <20150509154455.GA32002@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20150509154455.GA32002@amd>
Sender: owner-linux-mm@kvack.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, Mel Gorman <mgorman@suse.de>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, David Rientjes <rientjes@google.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, PaX Team <pageexec@freemail.hu>, Brad Spengler <spender@grsecurity.net>, Kees Cook <keescook@chromium.org>, Andi Kleen <andi@firstfloor.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, linux-mm@kvack.org, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Pavel,

Thanks a lot for taking the time to review this.

On Sat, May 9, 2015 at 5:44 PM, Pavel Machek <pavel@ucw.cz> wrote:
>> +#ifdef CONFIG_SANITIZE_FREED_PAGES
>> +             clear_free_pages();
>> +             printk(KERN_INFO "PM: free pages cleared after restore\n");
>> +#endif
>> +     }
>>       platform_leave(platform_mode);
>>
>>   Power_up:
>
> Can you move the ifdef and the printk into the clear_free_pages?

Sure. I put the printk out originally because i thought there might be
other uses, but since this is the sole call site right now it
shouldn't be an issue.

>
> This is not performance critical in any way...
>
> Otherwise it looks good to me... if the sanitization is considered
> useful. Did it catch some bugs in the past?
>

I've read somewhere that users of grsecurity claim that it caught bugs
in some drivers, but I haven't verified that personally; it's probably
much less useful than kasan (or even the original grsec feature) as a
bug-catcher since it doesn't clear freed slab buffers.

I'll wait a few more days for more reviews before sending the next
version, particularly on the power management part, and in general on
the usefulness of such feature.

Regards,

Anisse

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
