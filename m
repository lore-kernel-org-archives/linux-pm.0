From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [RFC][PATCH 2/2] PM: Rework handling of interrupts
	during suspend-resume
Date: Mon, 23 Feb 2009 01:22:55 -0800
Message-ID: <m17i3ha4nk.fsf__15294.9795512997$1235381189$gmane$org@fess.ebiederm.org>
References: <200902221837.49396.rjw@sisk.pl>
	<alpine.LFD.2.00.0902220946070.3111@localhost.localdomain>
	<200902222342.08285.rjw@sisk.pl> <200902230048.33635.rjw@sisk.pl>
	<m1ab8ddfbr.fsf@fess.ebiederm.org> <20090223084400.GB9582@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090223084400.GB9582@elte.hu> (Ingo Molnar's message of "Mon\,
	23 Feb 2009 09\:44\:00 +0100")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, pm list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:


> I think this aspect has been well-understood during the 
> discussion of this topic and it's just a slightly misleading 
> changelog.

As I was a member of that discussion I did not see that.

It took me several passes through the patches to realize
the goal is to allow drivers to be able to sleep while they
are in their late pm shutdown routines.

Why we want this I don't know.  But it seems simple enough
to implement, and it makes it harder to get the late pm
suspend routines wrong, which is always good.

> The new suspend code does not rely on truly disabling IRQs on 
> the low level. The purpose is to not get IRQs to drivers - which 
> might crash/hang/race/misbehave.

Reasonable.  I expect one of the problems with drivers getting it
wrong is that the interface is too complex for mortal humans to
understand.

> Still, it might make sense to not just use the ->disable 
> sequence but primarily the ->shutdown irqchip method (when it's 
> available in the irqchip).

Disable seems fine to me.  This is interesting in the context
of all of the irqs that will when masked show up somewhere
else (think boot interrupts).

> While we obviously cannot turn off the PIC that delivers timer 
> IRQs at this stage - there's no theoretical reason why the 
> suspend sequence couldnt power down some secondary PICs as well 
> - in some arch code, or maybe even in the generic driver suspend 
> sequence if the device tree is structured carefully enough so 
> that the PIC gets turned off last.

If the point is simply to prevent deliver of irqs to the drivers
I don't see the point of anything more than what the patch does
now.

Eric
