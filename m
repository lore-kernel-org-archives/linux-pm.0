From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 0/4] Rework disabling of interrupts during
	suspend-resume
Date: Sun, 1 Mar 2009 23:21:38 +0100
Message-ID: <200903012321.40328.rjw__23067.2965328724$1235946818$gmane$org@sisk.pl>
References: <200902221837.49396.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200902221837.49396.rjw@sisk.pl>
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
To: LKML <linux-kernel@vger.kernel.org>
Cc: Arve@smtp1.linux-foundation.org, Jeremy Fitzhardinge <jeremy@goop.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Johannes Berg <johannes@sipsolutions.net>, Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi,

The following patches modifiy the way in which we handle disabling interrupts
during suspend and enabling them during resume.  They also change the ordering
of the core suspend and hibernation code.

Namely, interrupts are currently disabled on the boot CPU as soon as the
nonboot CPUs have been disabled, which doesn't allow device drivers' "late"
suspend and "early" resume callbacks to sleep.  Among other things this means
they cannot execute ACPI AML routines, which leads to problems with
suspend-resume of PCI devices, as recently discussed.

1/4 modifies the [suspend|hibernation] and resume code, as well as the other
code using the device PM framework, so that device drivers will not receive
interrupts during the "late" suspend phase, although interrupts will only be
disabled on the CPU right before calling sysdev_suspend() (and analogously
during resume).  [Ingo, I didn't add your ACK to the patch, because it's
changed since you saw it last time.]

2/4 - 4/4 modify the suspend, hibernation and kexec jump code, respectively,
so that the "late" phase of suspending devices will happen before the platform
"prepare" callback and the disabling of nonboot CPUs (and analogously during
resume).

Comments welcome.

Thanks,
Rafael
