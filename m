From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [PATCH] [v4] x86, suspend: Save/restore extra MSR registers for suspend
Date: Thu, 26 Nov 2015 19:28:38 -0800
Message-ID: <001801d128c3$b72f7710$258e6530$@net>
References: <1440645507-17768-1-git-send-email-yu.c.chen@intel.com> <20150917053004.GB6665@amd> <36DF59CE26D8EE47B0655C516E9CE6402865A403@shsmsx102.ccr.corp.intel.com> <001701d102c4$1ac2bab0$50483010$@net> <36DF59CE26D8EE47B0655C516E9CE6402865AA02@shsmsx102.ccr.corp.intel.com> <002c01d1043c$133ba580$39b2f080$@net> <36DF59CE26D8EE47B0655C516E9CE64028662059@shsmsx102.ccr.corp.intel.com> <000901d118a8$8fda8450$af8f8cf0$@net> <36DF59CE26D8EE47B0655C516E9CE6402867326B@shsmsx102.ccr.corp.intel.com> <001901d1247c$043f3190$0cbd94b0$@net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta9.telus.net ([209.171.16.82]:54964 "EHLO cmta9.telus.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753767AbbK0D2p (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 26 Nov 2015 22:28:45 -0500
In-Reply-To: <001901d1247c$043f3190$0cbd94b0$@net>
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "'Chen, Yu C'" <yu.c.chen@intel.com>
Cc: "'Wysocki, Rafael J'" <rafael.j.wysocki@intel.com>, tglx@linutronix.de, hpa@zytor.com, bp@alien8.de, "'Zhang, Rui'" <rui.zhang@intel.com>, linux-pm@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, "'Brown, Len'" <len.brown@intel.com>, 'Ingo Molnar' <mingo@kernel.org>, 'Pavel Machek' <pavel@ucw.cz>, "'Pandruvada, Srinivas'" <srinivas.pandruvada@intel.com>, 'Doug Smythies' <dsmythies@telus.net>

On 2015.11.21 08:45 Doug Smythies wrote:
>On 2015.11.12 01:42 Chen, Yu C wrote:
>> On 2015.11.06 11:34 Doug Smythies wrote: 

[cut]

>> rdmsr_safe  might be better,

> I'll look into it, thanks.

>> you can refer to acpi_throttling_rdmsr

> I don't understand.

>> and I'm OK with this code, are you planning to send a formal patch? 

> The delay here is because I have always thought that some actual load
> content needs to be brought back to the intel_pstate driver, which would
> (or at least should) eliminate the need for this patch.

> Anyway, and at least for the interim, I'll try to make and submit a formal version.

I made a mistake in my initial testing. I put a 100% load on CPU 7 and then
cycled through all the clock modulation values to show that my test version of
a possible patch compensated / normalized the Clock Modulation. Indeed, if the
system is already asking for the maximum pstate, it will stay there. However,
whenever the load drops, the target pstate will drop to minimum and it will
never kick back up again, regardless of load.

I am returning to my initial assertion copied below:

>>>>>>> The current version of the intel_pstate driver is incompatible
>>>>>>> with any use of Clock Modulation, always resulting in driving the
>>>>>>> target pstate to the minimum, regardless of load. The result is
>>>>>>> the apparent CPU frequency stuck at minimum * modulation percent.
>>>>>>
>>>>>>> The acpi-cpufreq driver works fine with Clock Modulation,
>>>>>>> resulting in desired frequency * modulation percent.

Chen,

Thanks though for the suggestion to try normalizing.

... Doug


