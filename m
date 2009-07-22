From: Deepak Saxena <dsaxena@plexity.net>
Subject: Re: x86: Expected system state when resumed
Date: Wed, 22 Jul 2009 07:17:10 -0700
Message-ID: <20090722141710.GA17721@plexity.net>
References: <20090721164542.GA30390@plexity.net>
	<200907212248.18050.rjw@sisk.pl>
Reply-To: dsaxena@plexity.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200907212248.18050.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Jul 21 2009, at 22:48, Rafael J. Wysocki was caught saying:
> On Tuesday 21 July 2009, Deepak Saxena wrote:
> > 
> > I am working on getting suspend/resume working on an x86 system
> > (OLPC XO-1.5) where we are implementing ACPI based suspend/resume
> > using Open Firmware and what I am seeing right now is that on 
> > resume, we're not receiving interrupts so the system locks
> > up in the suspend path when msleep() is called from the EHCI
> > HCD resume code. lapic_resume() is being called so the APIC
> > is being restored.  I'm looking for information on what else
> > Linux's expectation from the firmware when control is handed back 
> > before I start dumping every system register pre and post resume.
> 
> If that's 2.6.30 or later and your timer interrupt is MSI, for example, please
> check if the timer interrupt is marked as IRQF_TIMER.  If it's not,
> suspend_device_irqs() will mark it as disabled and it won't work during
> early resume.

Thanks. I am using 2.6.30.1 and the standard x86 HPET driver which has 
IRQF_TIMER set so this is not the issue. I've determined that if I boot 
with "noapic", I can suspend/resume, but the system runs very slow as the
PATA controller is now polled instead of irq driven.

~Deepak

-- 
In the end, they will not say, "those were dark times,"  they will ask
"why were their poets silent?" - Bertold Brecht
