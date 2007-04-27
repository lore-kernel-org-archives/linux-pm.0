From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: suspend2 merge (was Re: [Suspend2-devel] Re: CFS and
	suspend2: hang in atomic copy)
Date: Fri, 27 Apr 2007 12:18:05 +0200
Message-ID: <200704271218.07120.rjw__34106.0554761954$1177668890$gmane$org@sisk.pl>
References: <20070425072350.GA6866@ucw.cz> <200704262102.38568.rjw@sisk.pl>
	<1177666915.7828.35.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1177666915.7828.35.camel@johannes.berg>
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

On Friday, 27 April 2007 11:41, Johannes Berg wrote:
> On Thu, 2007-04-26 at 21:02 +0200, Rafael J. Wysocki wrote:
> 
> > Yes.  That's because we want to be able to repeat creating the image
> > without closing the fd in some situations.
> 
> Oh yeah, I just checked and it's not in fact necessary. I'm just
> confused.
> 
> > Still, we could use a global var 'platform_hibernation' or something like this,
> > I think.  Then, we can do
> > 
> > #define platform_hibernation	0
> > 
> > on the architectures that don't need it and make ACPI use it instead of this
> > "dynamic linking".
> 
> No, because acpi doesn't know at build time whether it can actually do
> S4 or not.

That's not a problem, I think.

1) We define platform_hibernation if CONFIG_ACPI is set.

2) In the ACPI code we do

if (can do S4)
	platform_hibernation = 1;

3) We have functions arch_platform_prepare()/finish()/enter() that are defined
to be noops for anything but ACPI systems and for ACPI systems they are
defined like this:

int arch_platform_enter(void)
{
	if (!platform_hibernation)
		return 0;

	...
}

I think it should work.

Greetings,
Rafael
