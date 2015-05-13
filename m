From: "PaX Team" <pageexec@freemail.hu>
Subject: Re: [PATCH v3 2/4] PM / Hibernate: prepare for SANITIZE_FREED_PAGES
Date: Wed, 13 May 2015 11:50:20 +0200
Message-ID: <55531E5C.32539.21B688F@pageexec.freemail.hu>
References: <1430980452-2767-1-git-send-email-anisse@astier.eu>, <20150509154455.GA32002@amd>, <CALUN=q+OZFarqRoWMynRZy0ckv7qnsAQvWr9wkvdK_JmA=oomw@mail.gmail.com>
Reply-To: pageexec@freemail.hu
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <owner-linux-mm@kvack.org>
In-reply-to: <CALUN=q+OZFarqRoWMynRZy0ckv7qnsAQvWr9wkvdK_JmA=oomw@mail.gmail.com>
Content-description: Mail message body
Sender: owner-linux-mm@kvack.org
To: Pavel Machek <pavel@ucw.cz>, Anisse Astier <anisse@astier.eu>
Cc: Andrew Morton <akpm@linux-foundation.org>, Mel Gorman <mgorman@suse.de>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, David Rientjes <rientjes@google.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Brad Spengler <spender@grsecurity.net>, Kees Cook <keescook@chromium.org>, Andi Kleen <andi@firstfloor.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, linux-mm@kvack.org, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mathias Krause <minipli@googlemail.com>
List-Id: linux-pm@vger.kernel.org

On 11 May 2015 at 9:59, Anisse Astier wrote:

> > Otherwise it looks good to me... if the sanitization is considered
> > useful. Did it catch some bugs in the past?
> >
> 
> I've read somewhere that users of grsecurity claim that it caught bugs
> in some drivers, but I haven't verified that personally; it's probably
> much less useful than kasan (or even the original grsec feature) as a
> bug-catcher since it doesn't clear freed slab buffers.

the PaX SANITIZE feature wasn't developed for catching use-after-free bugs
but to help reduce data lifetime from the kernel while not killing too much
performance (this is why i was reluctant to add a finer grained version to
do slab object sanitization until Mathias Krause came up with a workable
compromise).

another reason page zeroing isn't good at catching these bugs is that the
0 fill value will produce NULL pointers which are often explicitly handled
already. on the other hand changing the fill value would not allow the
__GFP_ZERO performance optimization (the slab sanitization feature is a
different story however, we have a non-0 fill value and it keeps triggering
use-after-free bugs).

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
