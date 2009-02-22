From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC][PATCH 0/2] Rework disabling of interrupts
 during suspend-resume
Date: Mon, 23 Feb 2009 09:56:25 +1100
Message-ID: <1235343385.8805.218.camel__44307.9484197826$1235343866$gmane$org@pasglop>
References: <200902221837.49396.rjw@sisk.pl> <m1skm6cd3z.fsf@fess.ebiederm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <m1skm6cd3z.fsf@fess.ebiederm.org>
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
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sun, 2009-02-22 at 14:37 -0800, Eric W. Biederman wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> 
> > Moreover, the real purpose of these changes is to be able to execute the
> > "late" suspend and "early" resume device callbacks with timer interrupts
> > enabled, so that they can use mutexes etc.  However, x86 currently doesn't set
> > the IRQF_TIMER flag and I need to make it do so before going further in this
> > direction and changing the PCI PM framework to take advantage of the $subject
> > changes, for example.  So, I need to know how to modify x86 timer code so that
> > the IRQF_TIMER flag is set by it.
> 
> How does this sync with the ACPI requirement that the it's late suspend MUST
> happen with irqs disabled?

If I understand properly what the intention here is, the sysdev suspend
and later still happens with hard irqs off.

This is purely the layer between suspend and suspend_late at the driver
level that uses the above instead of hard IRQs off in order to be able
to properly order the ACPI calls vs. the driver calls.

Ben.
