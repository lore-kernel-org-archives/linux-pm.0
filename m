From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: intermittent suspend problem again
Date: Thu, 19 Nov 2009 20:42:17 +0100
Message-ID: <200911192042.18073.rjw__20138.1540079185$1258660812$gmane$org@sisk.pl>
References: <87fx93pwv2.fsf@tac.ki.iif.hu> <877htmragv.fsf@tac.ki.iif.hu>
	<87zl6ipt0p.fsf@tac.ki.iif.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <87zl6ipt0p.fsf@tac.ki.iif.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ferenc Wagner <wferi@niif.hu>
Cc: LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, yakui.zhao@intel.com, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thursday 19 November 2009, Ferenc Wagner wrote:
> Ferenc Wagner <wferi@niif.hu> writes:
> 
> > Ferenc Wagner <wferi@niif.hu> writes:
> >
> >> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> >>
> >>> On Wednesday 18 November 2009, Ferenc Wagner wrote:
> >>>
> >>>> Ferenc Wagner <wferi@niif.hu> writes:
> >>>> 
> >>>> Side question: If I run s2disk from the init=/bin/bash prompt, the
> >>>> instrumentation in acpi_enter_sleep_state_prep in drivers/acpi/acpica/hwsleep.c
> >>>> fires before the "Snapshotting system" phase, but it does not fire if I
> >>>> hibernate from the full running desktop.  (That instrumentation was put
> >>>> there to investigate the KMS-triggered STR freeze.)  What could explain
> >>>> this?
> >>>
> >>> It looks like it uses the "shutdown" method when run with init=/bin/bash, but
> >>> I don't know why exactly.
> >>
> >> Thanks for the tip, I'll check this too.
> >
> > While looking into this, I found a reproducible kernel panic:
> >
> > 1. boot with init=/bin/bash
> > 2. mount /usr; swapon -a
> > 3. plug in a USB pendrive
> > 4. s2disk (machine goes to sleep)
> > 5. power on, proceed with resuming, press Enter to cancel resume pause
> > 6. ACPI: Hardware changed while hibernated, cannot resume!
> >    Kernel panic - not syncing: ACPI S4 hardware signature mismatch
> >
> > Does it make sense?
> 
> Yes it does: it's the BIOS USB support playing its childish games.
> I can disable it most of the time, except when booting from USB...
> 
> I wonder if this problem sould be handled more gracefully, now that USB
> persistence is enabled by default.  It works just fine for STR, but
> potentially panics after hibernation.

Add acpi_sleep=s4_nohwsig to the kernel command line.

Thanks,
Rafael
