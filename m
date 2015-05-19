From: "PaX Team" <pageexec@freemail.hu>
Subject: Re: [PATCH v4 0/3] Sanitizing freed pages
Date: Tue, 19 May 2015 22:59:16 +0200
Message-ID: <555BA424.2410.2365DFC8@pageexec.freemail.hu>
References: <1431613188-4511-1-git-send-email-anisse@astier.eu>, <20150519124644.GD2462@suse.de>
Reply-To: pageexec@freemail.hu
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <owner-linux-mm@kvack.org>
In-reply-to: <20150519124644.GD2462@suse.de>
Content-description: Mail message body
Sender: owner-linux-mm@kvack.org
To: Anisse Astier <anisse@astier.eu>, Mel Gorman <mgorman@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, David Rientjes <rientjes@google.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Brad Spengler <spender@grsecurity.net>, Kees Cook <keescook@chromium.org>, Andi Kleen <andi@firstfloor.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, linux-mm@kvack.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 19 May 2015 at 13:46, Mel Gorman wrote:

> On Thu, May 14, 2015 at 04:19:45PM +0200, Anisse Astier wrote:
> > Hi,
> > 
> > I'm trying revive an old debate here[1], though with a simpler approach than
> > was previously tried. This patch series implements a new option to sanitize
> > freed pages, a (very) small subset of what is done in PaX/grsecurity[3],
> > inspired by a previous submission [4].
> > 
> > There are a few different uses that this can cover:
> >  - some cases of use-after-free could be detected (crashes), although this not
> >    as efficient as KAsan/kmemcheck
> 
> They're not detected, they're hidden.

this is a qualitative argument that cuts both ways. namely, you could say
that uninitialized memory does *not* trigger any bad behaviour exactly
because the previous content acts as valid data (say, a valid pointer)
whereas a null dereference would pretty much always crash (both in userland
and the kernel). not to mention that a kernel null deref is no longer an
exploitable bug in many/most situations which can't be said of arbitrary
uninitialized (read: potentially attacker controlled) values.

that said, i always considered this aspect of page sanitization as a
(potentially useful) side effect, not the design goal.

> >  - finally, it can reduce infoleaks, although this is hard to measure.
> > 
> 
> It obscures them.

i don't understand, what is being obscured exactly? maybe the term 'infoleaks'
is ambiguous, in case of page sanitization it refers to the reduction of data
lifetime (mostly userland anonymous memory, as per the original design). if
you were thinking of kernel->userland kind of leaks then i'd say that page
sanitization has little effect there because all the bugs i can think of were
not leaking from freed memory (where sanitization would have prevented the
leak).

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
