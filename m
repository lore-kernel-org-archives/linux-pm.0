From: "Chen, Yu C" <yu.c.chen@intel.com>
Subject: RE: [PATCH] [v4] x86, suspend: Save/restore extra MSR registers for
 suspend
Date: Sun, 11 Oct 2015 02:26:54 +0000
Message-ID: <36DF59CE26D8EE47B0655C516E9CE6402865AA02@shsmsx102.ccr.corp.intel.com>
References: <1440645507-17768-1-git-send-email-yu.c.chen@intel.com>
 <20150917053004.GB6665@amd>
 <36DF59CE26D8EE47B0655C516E9CE6402865A403@shsmsx102.ccr.corp.intel.com>
 <001701d102c4$1ac2bab0$50483010$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:5760 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751166AbbJKC06 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 10 Oct 2015 22:26:58 -0400
In-Reply-To: <001701d102c4$1ac2bab0$50483010$@net>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "hpa@zytor.com" <hpa@zytor.com>, "bp@alien8.de" <bp@alien8.de>, "Zhang, Rui" <rui.zhang@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, 'Ingo Molnar' <mingo@kernel.org>, 'Pavel Machek' <pavel@ucw.cz>, 'Kristen Carlson Accardi' <kristen@linux.intel.com>

Hi, Doug, thanks for your comment,

> -----Original Message-----
> From: Doug Smythies [mailto:dsmythies@telus.net]
> Sent: Saturday, October 10, 2015 2:56 AM
> To: Chen, Yu C
> Cc: Wysocki, Rafael J; tglx@linutronix.de; hpa@zytor.com; bp@alien8.de;
> Zhang, Rui; linux-pm@vger.kernel.org; x86@kernel.org; linux-
> kernel@vger.kernel.org; Brown, Len; 'Ingo Molnar'; 'Pavel Machek'; 'Kristen
> Carlson Accardi'
> Subject: RE: [PATCH] [v4] x86, suspend: Save/restore extra MSR registers for
> suspend
> 
> Note: This reply is more for general information than anything else.
> 
> Since Yu's original e-mail I have searched all forums and bug reports that I
> would find in an attempt to gain knowledge as to the extent of Clock
> Modulation becoming enabled issues.
> 
> It is common, but particularly with some types of Dell LapTops upon resume
> from suspend on battery power.
> 
> For the most part, users simply disable the intel_pstate driver, and move on
> with their lives using the acpi-cpufreq driver. And once they move on we
> never hear from 90% of them again, even though they agree to do more
> tests and report back.
> 
> Recall my original reply to this thread, a portion copied below:
> 
> > The current version of the intel_pstate driver is incompatible with
> > any use of Clock Modulation, always resulting in driving the target
> > pstate to the minimum, regardless of load. The result is the apparent
> > CPU frequency stuck at minimum * modulation percent.
> 
> > The acpi-cpufreq driver works fine with Clock Modulation, resulting in
> > desired frequency * modulation percent.
> 

[Yu] Why intel_pstate driver is incompatible with Clock Modulation? 
I search the intel_pstate driver code, but can not find any operation that
controls the value of MSR_IA32_THERM_CONTROL(0x19a),
but other components such as acpi processor throttling may be involved in.
Is there any bugzilla thread tracking this problem?

> For the most part users don't even notice the reduced performance (which is
> typically 75 or 87.5 percent of normal) when using the acpi-cpufreq driver.
> 
> Yu's specific example is special, because the Clock Modulation percent is
> undefined (reserved), and thus clearly unintentional, or just plain wrong if it
> is intentional.
> 
> Other comments in-line below:
> 
> > On 2015.10.07 02:39 Chen, Yu C wrote:
> > On 2105.09.17 13:30 Pavel Machek wrote:
> >> On Thu 2015-08-27 11:18:27, Chen Yu wrote:
> >>> A bug is
> >>> reported(https://bugzilla.redhat.com/show_bug.cgi?id=1227208)
> >>> that, after resumed from S3, CPU is running at a low speed.
> >>> After investigation, it is found that, BIOS has modified the value
> >>> of THERM_CONTROL register during S3, and changes it from 0 to 0x10,
> >>> since value of 0x10 means CPU can only get 25% of the Duty Cycle,
> >>> this triggers the problem.
> 
> Note: THERM_CONTROL register = IA32_CLOCK_MODULATION
> 
> I suspect the outcome for an undefined Clock Modulation value of 0 is
> processor dependent. For example on my i7-2600K I get 50% duty cycle if I
> manually write 0x10 to the register.
> 
BTW, how do you get the number of 50%?

> >>>
> >>> Here is a simple scenario to reproduce the issue:
> >>> 1.Boot up the system
> >>> 2.Get MSR with address 0x19a, it should be 0
> 
> It doesn't have to be, and in some cases I found it isn't, but Clock Modulation
> isn't enabled.
> Only bit 4 matters.
> 
You are right, I should add some descriptions that, this situation only makes sense 
for  the case reported at that bugzilla thread. 

> >>> 3.Put the system into
> >>> sleep, then wake it up 4.Get MSR with address 0x19a, it should be
> >>> 0(actually it shows 0x10)
> 
> Again, it doesn't have to be 0, only bit 4 matters.
> 
> In the problem cases I found, typically the value is 0x1c or 0x1e, for Clock
> Modulation percentages of 75% or 87.5%
> 
> However, thanks very much for the "how to" I used it a lot.
> 
> >>>
> >>> Although this is a BIOS issue,
> 
> In your specific case, and since the register value is undefined yes.
> In the resume from suspend on battery power case, it might be intentional.
> (there has been no response from Dell on the Dell forum where I asked.)
> 
Do you mean, BIOS would modify this value intentionally(before wakeup)  if BIOS found 
the battey power is too low?

> >>> it would be more robust for linux to deal with this situation. This
> >>> patch fixes this issue by introducing a framework to save/restore
> >>> specified MSR registers(THERM_CONTROL in this case) for
> >>> suspend/resume.
> >>>
> >>> When user encounters a problematic platform and needs to protect the
> >>> MSRs during suspending, he can simply add a quirk entry in
> >>> msr_save_dmi_table, and customizes MSR registers inside the quirk
> >>> callback, for example:
> 
> This might be hard to maintain and cause significant delays for actual end
> user availability for these battery resume type cases.
> 
> Is there a point to be made here?:
Well, I think this is why quirk is introduced here, if MSR_IA32_THERM_CONTROL is
modified by BIOS for battery resume cases, this platform should not add his quirk
in this framework.
And can you please provide bugzilla thread related to this battery resume case ?

> 
> Yes, I think the intel_pstate driver should be improved. Currently it is overly
> sensitive to non-standard system perturbations, sometimes resulting in
> driving down the CPU frequency, as in this case, and sometimes driving up
> the CPU frequency unnecessarily. I am saying the driver doesn't pass
> sensitivity analysis well.
> 
I guess the intel_pstate driver is another problem, or do I miss anything?

Thanks!

Yu

