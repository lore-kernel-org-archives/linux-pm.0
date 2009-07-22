From: Wu Zhangjin <wuzhangjin@gmail.com>
Subject: Re: x86: Expected system state when resumed
Date: Wed, 22 Jul 2009 10:09:01 +0800
Message-ID: <1248228542.12360.14.camel@falcon>
References: <20090721164542.GA30390@plexity.net>
	<200907212248.18050.rjw@sisk.pl>
Reply-To: wuzhangjin@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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

On Tue, 2009-07-21 at 22:48 +0200, Rafael J. Wysocki wrote:
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

Hi, Rafael

This IRQF_TIMER flag also works for me, thanks very much.

is there a need to tell all the guys who are maintaining the
platform-specific STR/Standby to mark their external timer interrupt to
IRQF_TIMER? or, pushing a patch to fix all of the relative timer
interrupts existing in the kernel. otherwise, they will waste time to
debug and fix this problem, hope they can search this E-mail and the
relative commits:

1. commit fee803b2f0c28c78984fc319bd4b88ad47117368
    x86: hpet: Mark per cpu interrupts IRQF_TIMER to prevent resume
failure
2. commit 936577c61d0c10b8929608a92c98d839b22053bc
    x86: Add IRQF_TIMER to legacy x86 timer interrupt descriptors

Regards,
Wu Zhangjin
