From: "Chen, Yu C" <yu.c.chen@intel.com>
Subject: RE: [PATCH][v6] x86, suspend: Save/restore extra MSR registers for
 suspend
Date: Tue, 24 Nov 2015 12:29:33 +0000
Message-ID: <36DF59CE26D8EE47B0655C516E9CE640286775A3@shsmsx102.ccr.corp.intel.com>
References: <6c37c06b6496431d6d82e6d59215eb04edfd9333.1447730578.git.yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:7352 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753032AbbKXM3l convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 24 Nov 2015 07:29:41 -0500
In-Reply-To: <6c37c06b6496431d6d82e6d59215eb04edfd9333.1447730578.git.yu.c.chen@intel.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "mingo@redhat.com" <mingo@redhat.com>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "pavel@ucw.cz" <pavel@ucw.cz>, "bp@suse.de" <bp@suse.de>, "luto@kernel.org" <luto@kernel.org>, "linux@horizon.com" <linux@horizon.com>, "Zhang, Rui" <rui.zhang@intel.com>, "Brown, Len" <len.brown@intel.com>, "x86@kernel.org" <x86@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "Kaszewski, Marcin" <marcin.kaszewski@intel.com>, "dsmythies@telus.net" <dsmythies@telus.net>

Hi, Ingo, thanks for your comments,
(Sorry for my late response because I missed the email you sent to me.)

> -----Original Message-----
> From: Chen, Yu C
> Sent: Tuesday, November 17, 2015 11:06 PM
> To: tglx@linutronix.de; mingo@redhat.com; hpa@zytor.com
> Cc: rjw@rjwysocki.net; pavel@ucw.cz; bp@suse.de; luto@kernel.org;
> linux@horizon.com; Zhang, Rui; Brown, Len; x86@kernel.org; linux-
> pm@vger.kernel.org; linux-kernel@vger.kernel.org; Chen, Yu C
> Subject: [PATCH][v6] x86, suspend: Save/restore extra MSR registers for
> suspend
> 
> A bug is reported that, after resumed from S3, CPU is running at a low speed.
> After investigation, BIOS has modified the value of THERM_CONTROL
> register during S3, and changes it from 0 to 0x10, thus enable the clock
> modulation(bit4), but with undefined CPU Duty Cycle(bit1:3), which causes
> the problem.
> 
> and the quirk mechanism ensures that, once resumed from suspended, the
> MSRs indicated by these IDs will be restored to their original values before
> suspended.
> 
> Since both 64/32-bit kernels are affected, this patch covers 64/32-bit
> common code path. And because the MSRs specified by the user might not
> be available or readable in any situation, we use rdmsrl_safe to safely save
> these MSRs.
> 
> Tested-by: Marcin Kaszewski <marcin.kaszewski@intel.com>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>

> [Ingo] 
> Btw., you say a bug was reported - but there's no Reported-by line. Do you know 
> who reported it, can the reporter be credited?
[Yu] OK, I will modify it to Reported-and-tested-by:  Marcin Kaszewski <marcin.kaszewski@intel.com>

> [Ingo]
> s/msr_save_data/saved_msr 
> Please don't use short in the kernel, the compiler will align it anyway. 
> use unsigned int instead.
> s/msr_context/saved_msrs
> s/msr_to_save/saved_msrs
> No need to initialize to NULL AFAICS.
> Using 'msr' consistently
> s/"x86/pm: Quirk already applied, ...
> Please put an empty line before the return.
> s/BIOSen
[Yu] OK, all are modified.

> [Ingo]
>> +	u32 bdw_msr_id[] = {MSR_IA32_THERM_CONTROL};
> I'm quite sure checkpatch warns about the whitespaces in this initialization 
sequence.
[Yu] hum, checkpatch does not warn about the whitespaces, 
I changed it to { MSR_IA32_THERM_CONTROL };

> [Ingo]
>> +	 .matches = {
>> +		DMI_MATCH(DMI_PRODUCT_NAME, "GRANTLEY"),
>> +		DMI_MATCH(DMI_PRODUCT_VERSION, "E63448-400"),
> are you sure it's only this specific product version that is affected? 
[Yu] We found  this problem only on this platform, not sure if other platforms also have this problem.
> [Ingo]
> Shouldn't  we filter for all 'GRANTLEY' products? We can do no harm by saving/restoring on 
> platforms that don't need it, right?
[Yu] I'm not sure if it is safe for other platforms to save/restore, since this MSR is a little special.
According to Doug Smythies, on some platforms,  the BIOSen change this MSR intentionally, 
 for example, once woken up from S3(before return to Linux), if the battery is  too low, 
the BIOS might enable  this MSR that, limits the CPU to run at a low speed for less energy consuming. 
Currently, the Linux can only control this MSR via thermal processor throttling,  and if BIOS changes
this MSR during S3, the Linux might hardly get a chance to adjust this value (if the temperature  remains stable), 
and it might bring problems. In above situation, we might need some codes to monitor the usage of battery,
 then adjust the speed of CPU?
For E63448-400 platform, we confirmed that we don't want the BIOS to set the MSR for us, so we worked around
It.
 > [Ingo]
> Please double check that the suspend/resume test facility 
> (CONFIG_PM_TEST_SUSPEND)  is run _after_ this callback is
> called. Is there any reason why this is a late  initcall?

[Yu] I use late_initcall because I found the dmi_init used 
subsys_initcall, so I tried to put it as late as possible.. It seems to break
CONFIG_PM_TEST_SUSPEND,  I changed it to __initcall, which is 
a little earlier than late_initcall.


thanks,
Yu 
