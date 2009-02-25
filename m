From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][PATCH 2/2] PM: Rework handling of interrupts
 during suspend-resume
Date: Tue, 24 Feb 2009 20:26:29 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0902242020120.3111@localhost.localdomain>
References: <200902221837.49396.rjw@sisk.pl> <200902232239.05926.rjw@sisk.pl>
	<m1iqn01ph3.fsf@fess.ebiederm.org> <200902242342.07721.rjw@sisk.pl>
	<alpine.LFD.2.00.0902241449221.3111@localhost.localdomain>
	<m18wnvup53.fsf@fess.ebiederm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <m18wnvup53.fsf@fess.ebiederm.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org



On Tue, 24 Feb 2009, Eric W. Biederman wrote:
> The question I was asking is:
> Can we get the broken cpu hotunplug code out of the suspend path?

I think we can move it around. I don't think we can get rid of it.

> If we can get the devices into a low power state and not generating
> interrupts by the time we disable cpus then we do not need to migrate
> irqs from process context and risk hitting the ioapic bugs.

At least one issue is that the actual final "go to sleep" is something 
that has to happen on just one CPU. And I'm pretty sure the others have to 
have gone through the shutdown sequence before that.

And knowing ACPI, the ordering requirements will boil down to something 
insane, like "you have to turn off the other CPU's _before_ you turn off 
some od the core devices, because turning off the other CPU's may involve 
them". 

So if what you would _want_ to do is to move the "turn off CPU's" into the 
very innermost layer, so that different architectures can then decide 
whether they even need to go through that whole thing or not (because 
turning off one core will automatically turn off all the others, simply 
because the power was turned off), I suspect the answer is "no".

So you were probably hoping to never have to have that whole horrible 
issue with moving interrupts around. I'm afraid I'm not seeing it happen. 
But maybe we can have it happen after we've disabled all the non-system 
devices, so that in practice there simply won't be any new interrupts 
coming in any more.

			Linus
