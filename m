From: Anisse Astier <anisse@astier.eu>
Subject: Re: [PATCH v4 1/3] PM / Hibernate: prepare for SANITIZE_FREED_PAGES
Date: Wed, 20 May 2015 14:07:36 +0200
Message-ID: <CALUN=q+0mUTeJKE0OV8Bkny33M2Psdp4U5dF3vBcyo+mxNb-Nw@mail.gmail.com>
References: <1431613188-4511-1-git-send-email-anisse@astier.eu>
 <CALUN=qLrXryb-aZTjXqoUhzjz68fvOae1bDxitYcJ3jBn_1EDg@mail.gmail.com>
 <1526358.9aMpXL2Hv2@vostro.rjw.lan> <555C73E7.23237.269170A5@pageexec.freemail.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:34939 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751182AbbETMH6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 May 2015 08:07:58 -0400
Received: by wicmx19 with SMTP id mx19so152370334wic.0
        for <linux-pm@vger.kernel.org>; Wed, 20 May 2015 05:07:57 -0700 (PDT)
In-Reply-To: <555C73E7.23237.269170A5@pageexec.freemail.hu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: PaX Team <pageexec@freemail.hu>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, Mel Gorman <mgorman@suse.de>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, David Rientjes <rientjes@google.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Brad Spengler <spender@grsecurity.net>, Kees Cook <keescook@chromium.org>, Andi Kleen <andi@firstfloor.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, linux-mm@kvack.org, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Wed, May 20, 2015 at 1:45 PM, PaX Team <pageexec@freemail.hu> wrote:
>
>> Moreover, why is the resume code path the only one where freed pages need to
>> be sanitized?
>
> ... i had a bug report before (http://marc.info/?l=linux-pm&m=132871433416256)
> which is why i asked Anisse to figure this out before upstreaming the feature.
> i've also asked him already to explain why his approach is the proper fix for
> the problem (which should include the description of the root cause as a start)
> but he hasn't answered that yet.
>
> anyway, the big question is how there can be free memory pages after resume
> which are not sanitized. now i have no idea about the hibernation logic but
> i assume that it doesn't save/restore free pages so the question is how the
> kernel gets to learn about these free pages during resume and whether there's
> a path where __free_page() or some other wrapper around free_pages_prepare()
> doesn't get called at all.

In my opinion the free pages left are those used by the loading kernel.
If I understand correctly, a suspend (hibernate) image contains *all*
the memory necessary for the OS to work; so when you restore it, you
restore it all, page tables, and kernel code section included. So when
the kernel does a hibernate restoration, it loads it all the pages
into memory, then architecture-specific code will jump into the new
"resumed" kernel by restoring page table entries and CPU context. When
it does that, it leaves the "loader" kernel memory hanging; this
memory is seen as free pages by the resumed kernel, but it isn't
cleared.

Rafael, am I getting something wrong on the hibernation resume process
? What do you think of this analysis ?

Regards,

Anisse
