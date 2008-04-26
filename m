From: David Brownell <david-b@pacbell.net>
Subject: Re: [RESEND patch 2.6.25] ACPI uses device_may_wakeup()
	policy inputs
Date: Sat, 26 Apr 2008 12:29:24 -0700
Message-ID: <200804261229.24855.david-b__28476.7797602855$1209239024$gmane$org@pacbell.net>
References: <200803201408.33466.david-b@pacbell.net>
	<200804182118.05228.david-b@pacbell.net>
	<1208832132.3550.35.camel@rzhang-1.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1208832132.3550.35.camel@rzhang-1.sh.intel.com>
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
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Monday 21 April 2008, Zhang Rui wrote:
> 
> On Fri, 2008-04-18 at 21:18 -0700, David Brownell wrote:
> > This imports the driver model device.power.may_wakeup flags to ACPI,
> > using it to *REPLACE* the /proc/acpi/wakeup flags for some devices.
> > It depends on the previous patch making device.power.can_wakeup
> > behave. It does that by:
> > 
> >  - Implementing platform_enable_wakeup(), which is currently invoked
> >    only by pci_enable_wake().  When that's called -- probably in the
> >    driver suspend() call -- it updates acpi_device.wakeup.state.enabled
> >    flag in the same way writing to /proc/acpi/wakeup updates it.
> >    
> >  - Updating the usage of the corresponding ACPI flags when turning on
> >    wakeup power domains and GPEs.
> > 
> > THIS PATCH NEEDS MORE ATTENTION because of the way the ACPI method
> > invocations have been changing, e.g. the 1.0 vs 2.0 sequencing.
> > 
> > Right now it's not clear to me whether the GPEs are always enabled at
> > the right time, and for that matter whether the rules haven't changed
> > so that drivers can no longer effectively control those settings from
> > suspend() unless acpi_new_pts_ordering is in effect.
>
> Sorry. It's such a long sentence which is hard for me to understand. :(

Apologies.

On the bright side ... didn't all the new_pts_ordering stuff
get removed?  If that stays gone, it removes the main concern
I had.  That comment was written when I observed what looked
to be troublesome semantic changes from that "new" ordering.


> > it's not clear to me whether the GPEs are always enabled at
> > the right time
>  
> this patch doesn't change the time when GPEs are enabled.

No it doesn't.  Maybe I'm just more paranoid about it than
someone who knows ACPI (and its version-specific issues) a
lot better than me.


> > NOT YET SIGNED-OFF ... primarily because of the confusion about
> > the order in which ACPI methods get called during entry to suspend
> > states.
>
> I think it's safe to apply this patch.

I did this work before the "new_pts_ordering" stuff happened.  Then
after "new_pts_ordering", it looked a bit problematic ... originally,
I would have agreed with you.  Maybe now I can agree again.

- Dave



> thanks,
> rui
> 
> > Presumably one of the "new style" PM methods calls will
> > now always work for drivers wanting to enable wakeup methods...
> 
