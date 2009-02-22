From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [RFC][PATCH 0/2] Rework disabling of interrupts
	during suspend-resume
Date: Sun, 22 Feb 2009 14:37:20 -0800
Message-ID: <m1skm6cd3z.fsf__980.874969582324$1235342454$gmane$org@fess.ebiederm.org>
References: <200902221837.49396.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200902221837.49396.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Sun\, 22 Feb 2009 18\:37\:48 +0100")
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

> Moreover, the real purpose of these changes is to be able to execute the
> "late" suspend and "early" resume device callbacks with timer interrupts
> enabled, so that they can use mutexes etc.  However, x86 currently doesn't set
> the IRQF_TIMER flag and I need to make it do so before going further in this
> direction and changing the PCI PM framework to take advantage of the $subject
> changes, for example.  So, I need to know how to modify x86 timer code so that
> the IRQF_TIMER flag is set by it.

How does this sync with the ACPI requirement that the it's late suspend MUST
happen with irqs disabled?

Eric
