From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: suspend2 merge (was Re: [Suspend2-devel] Re: CFS and
	suspend2: hang in atomic copy)
Date: Thu, 26 Apr 2007 20:40:30 +0200
Message-ID: <200704262040.31760.rjw@sisk.pl>
References: <20070425072350.GA6866@ucw.cz> <20070426113005.GU17387@elf.ucw.cz>
	<1177605074.6814.93.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1177605074.6814.93.camel@johannes.berg>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Nick Piggin <npiggin@suse.de>, Nigel Cunningham <nigel@nigel.suspend2.net>, Ingo Molnar <mingo@elte.hu>, Pavel Machek <pavel@ucw.cz>, Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org, Con Kolivas <kernel@kolivas.org>, suspend2-devel@lists.suspend2.net, linux-pm <linux-pm@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, 26 April 2007 18:31, Johannes Berg wrote:
> On Thu, 2007-04-26 at 13:30 +0200, Pavel Machek wrote:
> 
> > > From looking at pm_ops which I was recently working with a lot, it seems
> > > that it was designed by somebody who was reading the ACPI documentation
> > > and was otherwise pretty clueless, even at that level std tries to look
> > > like suspend. IMHO that is one of the first things that should be ripped
> > > out, no pm_ops for STD, it's a pain to work with.
> > 
> > That code goes back to Patrick, AFAICT. (And yes, ACPI S3 and ACPI S4
> > low-level enter is pretty similar).
> > 
> > Patches would be welcome
> 
> That was easier than I thought. This applies on top of a patch that
> makes kernel/power/user.c optional since I had no idea how to fix it,
> problems I see:
>  * it surfaces kernel implementation details about pm_ops and thus makes
>    the whole thing very fragile

Can you elaborate?

>  * it has yet another interface (yuck) to determine whether to reboot,
>    shut down etc, doesn't use /sys/power/disk

Yes.  In fact it was meant as a replacement for /sys/power/disk at one point.

>  * I generally had no idea wtf it is doing in some places

I could have told you if you had asked. :-)

> Anyway, this patch is only compile tested, it
>  * introduces include/linux/hibernate.h with hibernate_ops and
>    a new hibernate() function to hibernate the system

Do we need hibernate_ops at all?  There's only one user anyway and I'm not
sure there will be more of them in the future.

>  * rips apart a lot of the suspend code and puts it back together using
>    the hibernate_ops
>  * switches ACPI to hibernate_ops (the only user of pm_ops.pm_disk_mode)
>  * might apply/compile against -mm, I have all my and some of Rafael's
>    suspend/hibernate work in my tree.
>  * breaks user suspend as I noted above
>  * is incomplete, somewhere pm_suspend_disk() is still defined iirc

I think I can fix it up, just give me some time.

The idea is good, I think we should do someting like this.

Greetings,
Rafael
