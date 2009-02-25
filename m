From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [RFC][PATCH 2/2] PM: Rework handling of interrupts
	during suspend-resume
Date: Tue, 24 Feb 2009 20:59:43 -0800
Message-ID: <m1eixnru0w.fsf__19429.9683360898$1235538170$gmane$org@fess.ebiederm.org>
References: <200902221837.49396.rjw@sisk.pl> <200902232239.05926.rjw@sisk.pl>
	<m1iqn01ph3.fsf@fess.ebiederm.org> <200902242342.07721.rjw@sisk.pl>
	<alpine.LFD.2.00.0902241449221.3111@localhost.localdomain>
	<m18wnvup53.fsf@fess.ebiederm.org>
	<alpine.LFD.2.00.0902242020120.3111@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0902242020120.3111@localhost.localdomain> (Linus
	Torvalds's message of "Tue\,
	24 Feb 2009 20\:26\:29 -0800 \(PST\)")
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
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Tue, 24 Feb 2009, Eric W. Biederman wrote:
>> The question I was asking is:
>> Can we get the broken cpu hotunplug code out of the suspend path?
>
> I think we can move it around. I don't think we can get rid of it.
>
>> If we can get the devices into a low power state and not generating
>> interrupts by the time we disable cpus then we do not need to migrate
>> irqs from process context and risk hitting the ioapic bugs.
>
> At least one issue is that the actual final "go to sleep" is something 
> that has to happen on just one CPU. And I'm pretty sure the others have to 
> have gone through the shutdown sequence before that.
>
> And knowing ACPI, the ordering requirements will boil down to something 
> insane, like "you have to turn off the other CPU's _before_ you turn off 
> some od the core devices, because turning off the other CPU's may involve 
> them". 
>
> So if what you would _want_ to do is to move the "turn off CPU's" into the 
> very innermost layer, so that different architectures can then decide 
> whether they even need to go through that whole thing or not (because 
> turning off one core will automatically turn off all the others, simply 
> because the power was turned off), I suspect the answer is "no".
>
> So you were probably hoping to never have to have that whole horrible 
> issue with moving interrupts around. I'm afraid I'm not seeing it happen. 
> But maybe we can have it happen after we've disabled all the non-system 
> devices, so that in practice there simply won't be any new interrupts 
> coming in any more.

Right.  That is what I am hoping for.  No device interrupts coming into the
cpus at the time we turn them off.

We can disable the devices and thus disable the interrupts the devices
are sending before we disable the cpus.  That should make cpu disable
on suspend much easier to get solid then general x86 cpu hot-unplug.

Eric
