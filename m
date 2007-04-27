From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: suspend2 merge (was Re: [Suspend2-devel] Re: CFS and
	suspend2: hang in atomic copy)
Date: Fri, 27 Apr 2007 14:09:55 +0200
Message-ID: <200704271409.56687.rjw__39370.5136063092$1177675670$gmane$org@sisk.pl>
References: <20070425072350.GA6866@ucw.cz> <200704271218.07120.rjw@sisk.pl>
	<1177669179.7828.53.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1177669179.7828.53.camel@johannes.berg>
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

On Friday, 27 April 2007 12:19, Johannes Berg wrote:
> On Fri, 2007-04-27 at 12:18 +0200, Rafael J. Wysocki wrote:
> 
> > 1) We define platform_hibernation if CONFIG_ACPI is set.
> 
> Let's just define it always then in the common code so we don't have
> even more magic bits platforms need to define even if they don't care at
> all. And please don't put #ifdef CONFIG_ACPI into the common code ;)
> Maybe #ifdef CONFIG_ARCH_NEEDS_HIBERNATE_HOOKS or something.
> 
> > 2) In the ACPI code we do
> > 
> > if (can do S4)
> > 	platform_hibernation = 1;
> 
> Gotcha.
> 
> > 3) We have functions arch_platform_prepare()/finish()/enter() that are defined
> > to be noops for anything but ACPI systems and for ACPI systems they are
> > defined like this:
> > 
> > int arch_platform_enter(void)
> > {
> > 	if (!platform_hibernation)
> > 		return 0;
> > 
> > 	...
> > }
> > 
> > I think it should work.
> 
> You could reduce code churn in all other platforms by making these weak
> symbols like the irq hooks I did for pm_ops. It looks like it can work
> and possibly is even less intrusive than my hibernate_ops patch. Though
> then again my hibernate_ops patch removed a lot of stuff that is now no
> longer necessary, and also completely removed the PM_SUSPEND_DISK foo...
> we probably want that regardless of how we invoke ACPI.

Yes.  Still, I'd like to rework your patch to deal with ACPI without
introducing hibernate_ops .  I'm going to do this later today if you don't
mind. :-)

Rafael
