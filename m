From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: suspend2 merge (was Re: [Suspend2-devel] Re: CFS and
	suspend2: hang in atomic copy)
Date: Thu, 26 Apr 2007 21:02:37 +0200
Message-ID: <200704262102.38568.rjw__30913.9918456369$1177613963$gmane$org@sisk.pl>
References: <20070425072350.GA6866@ucw.cz> <200704262040.31760.rjw@sisk.pl>
	<1177612802.6814.121.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1177612802.6814.121.camel@johannes.berg>
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

On Thursday, 26 April 2007 20:40, Johannes Berg wrote:
> On Thu, 2007-04-26 at 20:40 +0200, Rafael J. Wysocki wrote:
> 
> > >  * it surfaces kernel implementation details about pm_ops and thus makes
> > >    the whole thing very fragile
> > 
> > Can you elaborate?
> 
> Well it tells userspace about pm_ops->enter/prepare/finish etc.
> Also, it seems that it needs a "release memory now" operation instead of
> just releasing it when the fd is closed?

Yes.  That's because we want to be able to repeat creating the image
without closing the fd in some situations.

> > >  * it has yet another interface (yuck) to determine whether to reboot,
> > >    shut down etc, doesn't use /sys/power/disk
> > 
> > Yes.  In fact it was meant as a replacement for /sys/power/disk at one point.
> 
> Heh.
> 
> > >  * I generally had no idea wtf it is doing in some places
> > 
> > I could have told you if you had asked. :-)
> 
> I was offline ;)
> 
> > Do we need hibernate_ops at all?  There's only one user anyway and I'm not
> > sure there will be more of them in the future.
> 
> I'm pretty sure there won't be, but there's no way to do it cleanly
> without pm_ops since even acpi doesn't do this all the time but only
> when some set of conditions is true. Hence, it needs to be able to
> determine the availability of the platform mode at run time rather than
> build time (build time => we could use weak symbols, arch hooks, ...)

Still, we could use a global var 'platform_hibernation' or something like this,
I think.  Then, we can do

#define platform_hibernation	0

on the architectures that don't need it and make ACPI use it instead of this
"dynamic linking".

Greetings,
Rafael
