From: "Chen, Yu C" <yu.c.chen@intel.com>
Subject: RE: [PATCH] [v4] x86, suspend: Save/restore extra MSR registers for
 suspend
Date: Sun, 1 Nov 2015 16:49:40 +0000
Message-ID: <36DF59CE26D8EE47B0655C516E9CE64028662059@shsmsx102.ccr.corp.intel.com>
References: <1440645507-17768-1-git-send-email-yu.c.chen@intel.com>
 <20150917053004.GB6665@amd>
 <36DF59CE26D8EE47B0655C516E9CE6402865A403@shsmsx102.ccr.corp.intel.com>
 <001701d102c4$1ac2bab0$50483010$@net>
 <36DF59CE26D8EE47B0655C516E9CE6402865AA02@shsmsx102.ccr.corp.intel.com>
 <002c01d1043c$133ba580$39b2f080$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:39982 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751123AbbKAQtp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 1 Nov 2015 11:49:45 -0500
In-Reply-To: <002c01d1043c$133ba580$39b2f080$@net>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "hpa@zytor.com" <hpa@zytor.com>, "bp@alien8.de" <bp@alien8.de>, "Zhang, Rui" <rui.zhang@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, 'Ingo Molnar' <mingo@kernel.org>, 'Pavel Machek' <pavel@ucw.cz>, 'Kristen Carlson Accardi' <kristen@linux.intel.com>, "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>

Hi, Doug,
Sorry for my late response, and thanks for your information:

> -----Original Message-----
> From: Doug Smythies [mailto:dsmythies@telus.net]
> Sent: Sunday, October 11, 2015 11:47 PM
> To: Chen, Yu C
> Cc: Wysocki, Rafael J; tglx@linutronix.de; hpa@zytor.com; bp@alien8.de;
> Zhang, Rui; linux-pm@vger.kernel.org; x86@kernel.org; linux-
> kernel@vger.kernel.org; Brown, Len; 'Ingo Molnar'; 'Pavel Machek'; 'Kristen
> Carlson Accardi'; Doug Smythies
> Subject: RE: [PATCH] [v4] x86, suspend: Save/restore extra MSR registers for
> suspend
> 
> Hi Yu, thanks for your reply.
> 
> On 2015.10.10 19:27 Chen, Yu C wrote:
> > On 2105.10.10 02:56 Doug Smythies wrote:
> >
> >>> The current version of the intel_pstate driver is incompatible with
> >>> any use of Clock Modulation, always resulting in driving the target
> >>> pstate to the minimum, regardless of load. The result is the
> >>> apparent CPU frequency stuck at minimum * modulation percent.
> >>
> >>> The acpi-cpufreq driver works fine with Clock Modulation, resulting
> >>> in desired frequency * modulation percent.
> >>
> 
> > [Yu] Why intel_pstate driver is incompatible with Clock Modulation?
> 
> It is simply how the current control algorithm responds to the scenario.
> 
> The problem is in intel_pstate_get_scaled_busy, here:
> 
>         /*
>          * core_busy is the ratio of actual performance to max
>          * max_pstate is the max non turbo pstate available
>          * current_pstate was the pstate that was requested during
>          *      the last sample period.
>          *
>          * We normalize core_busy, which was our actual percent
>          * performance to what we requested during the last sample
>          * period. The result will be a percentage of busy at a
>          * specified pstate.
>          */
>         core_busy = cpu->sample.core_pct_busy;
>         max_pstate = int_tofp(cpu->pstate.max_pstate);
>         current_pstate = int_tofp(cpu->pstate.current_pstate);
>         core_busy = mul_fp(core_busy, div_fp(max_pstate, current_pstate));
> 
> With Clock Modulation enabled, the actual performance percent will always
> be less than what was asked for, basically meaning current_pstate is much
> less than what was asked for. Thus the algorithm will drive down the target
> pstate regardless of load.
> 
[Yu] Do you mean, there is some problem with the normalization,and we should use 
the actual pstate rather than the theoretical current_pstate, for example, 
the pseudocode might looked like:

-  current_pstate = int_tofp(cpu->pstate.current_pstate);
+ current_pstate = int_tofp(cpu->pstate.current_pstat)*0.85;

Best Regards,
Yu
