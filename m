From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 0/2] Rework disabling of interrupts during
	suspend-resume
Date: Sun, 22 Feb 2009 18:37:48 +0100
Message-ID: <200902221837.49396.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi,

The following two patches modify the way in which we handle disabling
interrupts during suspend and enabling them during resume.  Namely, currently
interrupts are disabled on the boot CPU as soon as the nonboot CPUs have been
disabled, which doesn't allow device drivers' "late" suspend and "early" resume
callbacks to sleep.  Among other things this means they cannot execute ACPI
AML routines, which leads to problems with suspend-resume of PCI devices,
as recently discussed on this list.

1/2 is based on an earlier patch from Linus and it only splits up
sysdev_[suspend|resume] from the ["late suspend|"early" resume'] of devices.

2/2 actually modifies the [suspend|hibernation] and resume code, as well as the
other code using the device PM framework.

The patches have been initially tested and they don't appear to break suspend
on my boxes, but this is the first approximation only.  In particular, I'm not sure
if I did the XEN, kexec and APM parts right, so people with experience in these
areas are gently requested to have a look and tell me if there's anything to
fix in there.

Moreover, the real purpose of these changes is to be able to execute the
"late" suspend and "early" resume device callbacks with timer interrupts
enabled, so that they can use mutexes etc.  However, x86 currently doesn't set
the IRQF_TIMER flag and I need to make it do so before going further in this
direction and changing the PCI PM framework to take advantage of the $subject
changes, for example.  So, I need to know how to modify x86 timer code so that
the IRQF_TIMER flag is set by it.

Comments welcome.

Thanks,
Rafael
