From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 4/4] PERF: fix power:cpu_idle double end
	events
Date: Wed, 27 Oct 2010 17:42:04 +0200
Message-ID: <201010271742.04545.trenn__16637.8717557111$1288194186$gmane$org@suse.de>
References: <1288136605-10526-1-git-send-email-trenn@suse.de>
	<1288136605-10526-5-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1288136605-10526-5-git-send-email-trenn@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: arjan@linux.intel.com
Cc: jean.pihet@newoldbits.com, Robert Schoene <robert.schoene@tu-dresden.de>, linux-trace-users@vger.kernel.org, mingo@elte.hu, linux-omap@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wednesday 27 October 2010 01:43:25 Thomas Renninger wrote:
> cpu_idle events (transition into sleep state and exiting) are
> both fired in pm_idle().
> 
> Entering sleep state and exiting should always get fired inside
> pm_idle() already.
> 
> This is a revert of commit c882e0feb937af4e5b991cbd1c
Robert: I expect you tested this on a machine with no cpuidle
driver registered?

I should have had a deeper look at this at once, done so now:

Current cpu_idle, power_start/end (same before my changes) behavior
on X86 is rather weird (without this patch):

if pm_idle is:
   poll_idle -> should throw double end events

   default_idle -> only throws power_start, your patch
                   fixed that, but in the generic cpu_idle
                   thread function which always gets executed
                   also if pm_idle != default_idle
                   So Robert fixed this case, but at the wrong place.

   cpuidle_idle_call -> depends whether intel_idle or acpi_idle
                        driver registered:

        intel_idle -> throws a cpu idle state event, still double end
                      events (one from cpuidle, one from
                      process_{32,64}.c, due to Robert's patch

        acpi_idle  -> whether a power_start event is thrown at all
                      depends on (cmp with acpi_idle_do_entry()):
                      cx->entry_method == ACPI_CSTATE_FFH
                      will end up in a power_start event via:
                      acpi_processor_ffh_cstate_enter(cx)
                           mwait_idle_with_hints()
                      but it will not in case of:
                      cx->entry_method == ACPI_CSTATE_HALT
                      or IO based switching (the else path there):
                      /* IO port based C-state */
                      

Again without this(my) patch you get:
   poll_idle                  -> double end events
   default_idle               -> all is fine (with your patch)
   cpuidle_idle_call
        intel_idle registered -> double end events
        acpi_idle registered  -> double end events
                                 start events may not be thrown
                                 at all.

perf timechart can handle double end events, this may be
the reason this was overseen.

Argh, I tried to come up with patches, but run out of
time. I will send something soon.
I also found a bug in my userspace stuff: I forgot to convert
u64 to u32..., sorry about that.
I try to resend everything tomorrow.

     Thomas
