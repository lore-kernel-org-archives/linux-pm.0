From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [RESEND patch 2.6.25] ACPI uses device_may_wakeup()
	policy	inputs
Date: Tue, 22 Apr 2008 10:42:12 +0800
Message-ID: <1208832132.3550.35.camel__41569.1146896735$1208832378$gmane$org@rzhang-1.sh.intel.com>
References: <200803201408.33466.david-b@pacbell.net>
	<200803201422.55014.david-b@pacbell.net>
	<200804182118.05228.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200804182118.05228.david-b@pacbell.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org


On Fri, 2008-04-18 at 21:18 -0700, David Brownell wrote:
> This imports the driver model device.power.may_wakeup flags to ACPI,
> using it to *REPLACE* the /proc/acpi/wakeup flags for some devices.
> It depends on the previous patch making device.power.can_wakeup
> behave.
> It does that by:
> 
>  - Implementing platform_enable_wakeup(), which is currently invoked
> only
>    by pci_enable_wake().  When that's called -- probably in the driver
>    suspend() call -- it updates acpi_device.wakeup.state.enabled flag
> in
>    the same way writing to /proc/acpi/wakeup updates it.
>    
>  - Updating the usage of the corresponding ACPI flags when turning on
>    wakeup power domains and GPEs.
> 
> THIS PATCH NEEDS MORE ATTENTION because of the way the ACPI method
> invocations have been changing, e.g. the 1.0 vs 2.0 sequencing.
> 
> Right now it's not clear to me whether the GPEs are always enabled at
> the right time, and for that matter whether the rules haven't changed
> so that drivers can no longer effectively control those settings from
> suspend() unless acpi_new_pts_ordering is in effect.
Sorry. It's such a long sentence which is hard for me to understand. :(

> it's not clear to me whether the GPEs are always enabled at
> the right time
this patch doesn't change the time when GPEs are enabled.
when do you think should be the right time to enable the GPEs?

> 
> ACPI systems see behavioral changes as follows:
> 
>    * Wakeup-aware PCI drivers no longer need to have someone override
> the
>      initial system config by writing to /proc/acpi/wakeup; existing
> calls
>      to pci_enable_wake() suffice.  For wakeup-unaware drivers, it's
> still
>      not clearly safe to enable wakeup in /proc/acpi/wakeup.
> 
>    * Non-PCI frameworks (as for PS2 serial ports) could call the
> platform
>      hook like PCI does, supporting wakeup-aware drivers.
> 
>    * The /sys/devices/.../power/wakeup flags are a different kind of
> manual
>      override.  They _disable_ wakeup for broken hardware or drivers,
> rather
>      than _enabling_ it in the hope that unmodified drivers won't
> break when
>      their hardware triggers wakeup events.
> 
> NOT YET SIGNED-OFF ... primarily because of the confusion about
> the order in which ACPI methods get called during entry to suspend
> states.
I think it's safe to apply this patch.
But I don't know what's the relationship between this patch and the
"acpi_new_pts_ordering" stuff you stated earlier, do I miss something?

thanks,
rui

> Presumably one of the "new style" PM methods calls will
> now always work for drivers wanting to enable wakeup methods...
