From: Anisse Astier <anisse@astier.eu>
Subject: Re: [PATCH v4 0/3] Sanitizing freed pages
Date: Wed, 20 May 2015 14:24:09 +0200
Message-ID: <CALUN=q+xanBnXOo8bR89DYC8opNmt5j4szG80ZOPPHY6BRgr7Q@mail.gmail.com>
References: <1431613188-4511-1-git-send-email-anisse@astier.eu> <20150519124644.GD2462@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150519124644.GD2462@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Mel Gorman <mgorman@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, David Rientjes <rientjes@google.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, PaX Team <pageexec@freemail.hu>, Brad Spengler <spender@grsecurity.net>, Kees Cook <keescook@chromium.org>, Andi Kleen <andi@firstfloor.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, linux-mm@kvack.org, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, May 19, 2015 at 2:46 PM, Mel Gorman <mgorman@suse.de> wrote:
> On Thu, May 14, 2015 at 04:19:45PM +0200, Anisse Astier wrote:
>> Hi,
>>
>>  - it can help with long-term memory consumption in an environment with
>>    multiple VMs and Kernel Same-page Merging on the host. [2]
>
> This is not quantified but a better way of dealing with that problem would
> be for a guest to signal to the host when a page is really free. I vaguely
> recall that s390 has some hinting of this nature. While I accept there
> may be some benefits in some cases, I think it's a weak justification for
> always zeroing pages on free.

Sure, there's always a better way, like virtio's ballooning. This
approach has the merit of being much simpler to use.



>> I haven't been able to measure a meaningful performance difference when
>> compiling a (in-cache) kernel; I'd be interested to see what difference it
>> makes with your particular workload/hardware (I suspect mine is CPU-bound on
>> this small laptop).
>>
>
> What did you use to determine this and did you check if it was hitting
> the free paths heavily while it's running? It can be very easy to hide
> the cost of something like this if all the frees happen at exit.

I'll admit that it's lacking numbers; I've chosen the simplest
benchmark available (kernel compiles), and couldn't measure a
difference in overall time, but I didn't go as far as using perf to
find where the hot path is.

Another way of thinking about this is just moving the clearing from
allocation to freeing. Userland memory allocated through anonymous
mapping is already cleared on alloc, so this will make allocation
faster. It's a different kind of tradeoff.

Regards,

Anisse
