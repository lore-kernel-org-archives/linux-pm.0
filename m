From: Ferenc Wagner <wferi@niif.hu>
Subject: Re: intermittent suspend problem again
Date: Wed, 18 Nov 2009 15:05:47 +0100
Message-ID: <87r5rwrkqs.fsf__10006.8546635613$1258553214$gmane$org@tac.ki.iif.hu>
References: <87fx93pwv2.fsf@tac.ki.iif.hu> <200911132059.46377.rjw@sisk.pl>
	<874ooxho2b.fsf@tac.ki.iif.hu> <200911141952.50030.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: Ferenc Wagner's message of "Wed\, 18 Nov 2009 02\:12\:32 +0100"
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
Cc: LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, yakui.zhao@intel.com, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Ferenc Wagner <wferi@niif.hu> writes:

> Since I've instrumented s2disk and the hibernation path, no freeze
> happened during hibernating the machine.

Not until I removed the delays from hibernation_platform_enter(), which
were put there previously to get step-by-step feedback.  Removing them
again resulted in a freeze in short course, maybe just two hibernations
later.  The instrumentation shows it stuck in dpm_suspend_start(PMSG_HIBERNATE).
Does it mean that some device driver is at fault?  I'll check if it
always fails at the same point (although tracing into dpm_suspend_start
isn't pure fun because of the multitude of devices it loops over).  Is
there any way to get printk output from that phase?

Side question: If I run s2disk from the init=/bin/bash prompt, the
instrumentation in acpi_enter_sleep_state_prep in drivers/acpi/acpica/hwsleep.c
fires before the "Snapshotting system" phase, but it does not fire if I
hibernate from the full running desktop.  (That instrumentation was put
there to investigate the KMS-triggered STR freeze.)  What could explain
this?
-- 
Thanks,
Feri.
