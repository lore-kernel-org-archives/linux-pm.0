From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [RFC][PATCH 2/2] PM: Rework handling of interrupts
	during suspend-resume
Date: Sun, 22 Feb 2009 19:04:08 -0800
Message-ID: <m1ab8ddfbr.fsf__1996.9085384675$1235358478$gmane$org@fess.ebiederm.org>
References: <200902221837.49396.rjw@sisk.pl>
	<alpine.LFD.2.00.0902220946070.3111@localhost.localdomain>
	<200902222342.08285.rjw@sisk.pl> <200902230048.33635.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200902230048.33635.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Mon\, 23 Feb 2009 00\:48\:32 +0100")
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
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

> On Sunday 22 February 2009, Rafael J. Wysocki wrote:
>> On Sunday 22 February 2009, Linus Torvalds wrote:
>> > 
>> > On Sun, 22 Feb 2009, Rafael J. Wysocki wrote:
> [--snip--]
>> 
>> Thanks a lot for your comments, I'll send an updated patch shortly.
>
> The updated patch is appended.
>
> It has been initially tested, but requires more testing, especially with APM,
> XEN, kexec jump etc.
>
> Thanks,
> Rafael
>
> ---
> From: Rafael J. Wysocki <rjw@sisk.pl>
> Subject: PM: Rework handling of interrupts during suspend-resume (rev. 2)
>
> Introduce two helper functions allowing us to disable device
> interrupts (at the IO-APIC level) during suspend or hibernation
> and enable them during the subsequent resume, respectively, so that
> the timer interrupts are enabled while "late" suspend callbacks and
> "early" resume callbacks provided by device drivers are being
> executed.
>
> Use these functions to rework the handling of interrupts during
> suspend (hibernation) and resume.  Namely, interrupts will only be
> disabled on the CPU right before suspending sysdevs, while device
> interrupts will be disabled (at the IO-APIC level), with the help of
> the new helper function, before calling "late" suspend callbacks
> provided by device drivers and analogously during resume.

I don't have an issue with the code, but I do have an issue with
this description of it.

Calling disable especially for ioapics does nothing directly.
It simply arranges for the irq to be marked pending and for the
irq to be masked if the irq happens.

So what you are doing is arranging so that no interrupts will be
delivered to drivers.  Not really disabling interrupts at the IO-APIC
level.

In addition not all interrupts (even on x86) go through an IO-APIC anymore
so describing the patch in terms of an IO-APIC makes it a bit hard to
understand what your intent actually is.


Eric
