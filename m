From: Chen Yu <yu.c.chen@intel.com>
Subject: Re: [PATCH][RFC v4] ACPI throttling: Disable the MSR T-state if
 enabled after resumed
Date: Wed, 15 Mar 2017 23:11:42 +0800
Message-ID: <20170315151142.GB467@yu-desktop-1.sh.intel.com>
References: <1487320050-22894-1-git-send-email-yu.c.chen@intel.com>
 <20170218090207.GB8937@amd>
 <20170219043718.GA4953@yu-desktop-1.sh.intel.com>
 <20170314173803.GA17126@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170314173803.GA17126@amd>
Sender: linux-acpi-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Ingo Molnar <mingo@kernel.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,
On Tue, Mar 14, 2017 at 06:38:03PM +0100, Pavel Machek wrote:
> Hi!
> 
> > > > However there are still three problems left:
> > > > 1. More and more reports show that other platforms also
> > > >    encountered the same issue, so the quirk list might
> > > >    be endless.
> > > > 2. Each CPUs should take the save/restore operation into
> > > >    consideration, rather than the boot CPU alone.
> > > > 3. Normally ACPI T-state re-evaluation is done on resume,
> > > >    however there is no _TSS on the bogus platform, thus
> > > >    above re-evaluation code does not run on that machine.
> > > > 
> > > > Solution:
> > > > This patch is based on the fact that, we generally should not
> > > > expect the system to come back from resume with throttling
> > > > enabled, but leverage the OS components to deal with it,
> > > > such as thermal event. So we simply clear the MSR T-state
> > > > and print the warning if it is found to be enabled after
> > > > resumed back. Besides, we can remove the quirk in previous patch
> > > > later.
> > > 
> > > What if the machine _is_ hot? 
> > > 
> > Later the linux has a chance to adjust the tstate if the system is too hot,
> > with the help of thermal framework.
> 
> Will it adjust the tstate? Normally, we do such stuff when tresholds
> are exceeded. If we are already above the threshold, we'll see no
> reason to 
> 
According to current implementation of thermal_pm_notify, after resumed
back, the initial temperature will be reset to -274, thus the trend of
temperature will always be 'increasing', then the trip point(threshold)
will be compared with currently temperature, if it is bigger than the
trip point, the CPUs will be throttled. So I think the tstate has a chance
to be adjusted.
> > But if the cpu is not inside any thermal zone, then there is no way for the
> > OS to adjust the tstate after resume, however in this case I think it is up
> > to the user space to adjust the tstate msr, for example, by using thermald
> > daemon to bind the cpu to the thermal zone.
> 
> Umm. Userland should not access MSRs. And we certainly should not
> depend on userland adjusting the MSRs!
> 
I agree, so I think thermald is the only applicable solution for this case,
because the thermald is just trying to bind the CPUs to some thermal
zones via sysfs, and the user does not need to modify the MSRs because
the tstate MSRs will be taken care of by the thermal zones in kernelland.
> > > Should we introduce generic framework to "fix" all the cpus? Actually,
> > > should this be done right on cpu hotplug?
> > Do you mean, fix other MSR-inconsistent issues, not only the tstate MSR?
> > Currently the tstate re-adjusting is invoked in cpuhotplug notifier
> > after each nonboot cpus are brought up:
> > acpi_soft_cpu_online -> acpi_processor_reevaluate_tstate -> adjust_tstate_msr
> 
> Ok.
> 									Pavel
> --
Thanks,
Yu
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html


