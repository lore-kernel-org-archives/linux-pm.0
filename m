From: Chen Yu <yu.c.chen@intel.com>
Subject: Re: [PATCH][RFC v4] ACPI throttling: Disable the MSR T-state if
 enabled after resumed
Date: Sun, 19 Feb 2017 12:37:18 +0800
Message-ID: <20170219043718.GA4953@yu-desktop-1.sh.intel.com>
References: <1487320050-22894-1-git-send-email-yu.c.chen@intel.com>
 <20170218090207.GB8937@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:16315 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751297AbdBSEhw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 18 Feb 2017 23:37:52 -0500
Content-Disposition: inline
In-Reply-To: <20170218090207.GB8937@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Ingo Molnar <mingo@kernel.org>, linux-pm@vger.kernel.org

Hi,
On Sat, Feb 18, 2017 at 10:02:07AM +0100, Pavel Machek wrote:
> On Fri 2017-02-17 16:27:30, Chen Yu wrote:
> > Previously a bug was reported that on certain Broadwell
> > platform, after resumed from S3, the CPU is running at
> > an anomalously low speed, due to the BIOS has enabled the
> > MSR throttling across S3. The solution to this was to introduce
> > a quirk framework to save/restore tstate MSR register around
> > suspend/resume, in Commit 7a9c2dd08ead ("x86/pm:
> > Introduce quirk framework to save/restore extra MSR
> > registers around suspend/resume").
> > 
> > However there are still three problems left:
> > 1. More and more reports show that other platforms also
> >    encountered the same issue, so the quirk list might
> >    be endless.
> > 2. Each CPUs should take the save/restore operation into
> >    consideration, rather than the boot CPU alone.
> > 3. Normally ACPI T-state re-evaluation is done on resume,
> >    however there is no _TSS on the bogus platform, thus
> >    above re-evaluation code does not run on that machine.
> > 
> > Solution:
> > This patch is based on the fact that, we generally should not
> > expect the system to come back from resume with throttling
> > enabled, but leverage the OS components to deal with it,
> > such as thermal event. So we simply clear the MSR T-state
> > and print the warning if it is found to be enabled after
> > resumed back. Besides, we can remove the quirk in previous patch
> > later.
> 
> What if the machine _is_ hot? 
> 
Later the linux has a chance to adjust the tstate if the system is too hot,
with the help of thermal framework.
But if the cpu is not inside any thermal zone, then there is no way for the
OS to adjust the tstate after resume, however in this case I think it is up
to the user space to adjust the tstate msr, for example, by using thermald
daemon to bind the cpu to the thermal zone.

> > +static int acpi_throttling_init_ops(void)
> > +{
> > +	/*
> > +	 * Reevaluate on boot CPU. Since it is not always CPU0,
> > +	 * we can not invoke throttling_msr_reevaluate(0) directly.
> > +	 */
> 
> Boot cpu is not cpu#0? How can that be?
> 
In disable_nonboot_cpus, it first tries to disable cpus other than cpu#0,
but if cpu#0 is found to be offline, it will try to bypass it and use another
cpu as the boot/primary cpu:

if (!cpu_online(primary))
	primary = cpumask_first(cpu_online_mask);

> Should we introduce generic framework to "fix" all the cpus? Actually,
> should this be done right on cpu hotplug?
Do you mean, fix other MSR-inconsistent issues, not only the tstate MSR?
Currently the tstate re-adjusting is invoked in cpuhotplug notifier
after each nonboot cpus are brought up:
acpi_soft_cpu_online -> acpi_processor_reevaluate_tstate -> adjust_tstate_msr

Thanks,
Yu
> 
> 									Pavel
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
