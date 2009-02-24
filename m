From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 2/2] PM: Rework handling of interrupts
	during suspend-resume
Date: Wed, 25 Feb 2009 00:07:11 +0100
Message-ID: <200902250007.13069.rjw__28600.3804686063$1235517001$gmane$org@sisk.pl>
References: <200902221837.49396.rjw@sisk.pl> <200902242342.07721.rjw@sisk.pl>
	<alpine.LFD.2.00.0902241449221.3111@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0902241449221.3111@localhost.localdomain>
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
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@elte.hu>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday 24 February 2009, Linus Torvalds wrote:
> 
> On Tue, 24 Feb 2009, Rafael J. Wysocki wrote:
> >
> > > The only safe way on x86 to shutdown a level triggered ioapic irq
> > > outside of irq context is for the driver to program the hardware to
> > > not generate an irq.
> > 
> > Well, that changes things quite a bit, because it means we can't change the
> > suspend-resume sequence in a way we thought we could without fixing all
> > drivers first, but this is exactly what we'd like to avoid by changing the
> > core.
> 
> Calling "disable_irq()" is perfectly fine.
> 
> What is not possible on that broken IO-APIC (among other things) is to 
> actually turn the interrupts off at the apic (ie the whole ->shutdown() 
> thing). But that's not what we even want to do. What we care about is 
> just disabling the interrupt from a drievr perspective.
> 
> IOW, the patches I have seen are fine, and all the comments from Eric are 
> just confusion about what we want done.

Ah, OK.  Thanks for the explanation, I got confused too.

> WE DO NOT WANT TO TURN OFF THE IO-APIC. That may or may happen later, but 
> that's totally unrelated to this whole "suspend_device_irq()" thing.

Yeah.

Rafael
