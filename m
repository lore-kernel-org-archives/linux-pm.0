From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [PATCH 2/5] intel_pstate: Use C0 time for busy calculations (again).
Date: Wed, 6 May 2015 23:17:22 -0700
Message-ID: <000a01d0888d$7bf56370$73e02a50$@net>
References: <1428811830-15006-1-git-send-email-dsmythies@telus.net>	<1428811830-15006-3-git-send-email-dsmythies@telus.net> <20150506122027.568b0522@kcaccard-desk.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta18.telus.net ([209.171.16.91]:55815 "EHLO cmta18.telus.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750876AbbEGGR2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 7 May 2015 02:17:28 -0400
In-Reply-To: <20150506122027.568b0522@kcaccard-desk.amr.corp.intel.com>
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Kristen Carlson Accardi' <kristen@linux.intel.com>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org, Doug Smythies <dsmythies@telus.net>

On 2015.05.06 Kristen Carlson Accardi wrote:
> On Sat, 11 Apr 2015 21:10:27 -0700 Doug Smythies <doug.smythies@gmail.com> wrote:

>> This patch brings back the inclusion of C0 time
>> for the calculation of core_busy.

...

>> +	core_pct = int_tofp(sample->mperf) * int_tofp(1000);
>> +	core_pct = div64_u64(core_pct, int_tofp(sample->tsc));

> FYI - It's not actually valid to use the contents of mperf without aperf
> according the the intel SDM:

> "Only the IA32_APERF/IA32_MPERF ratio is architecturally defined;
> software should not attach meaning to the content of the individual of IA32_APERF or IA32_MPERF MSRs."
> There is no guarantee mperf and tsc are using the same clock.

I was just bringing back code that used to be there.
Reference: fcb6a15c2e7e76d493e6f91ea889ab40e1c643a4 2014.02.03 Dirk Brandewie

I do not know of another way to calculate load, but I will try to look at
how the acpi-cpufreq driver does it.

On my computer, available clock sources are: tsc hpet acpi_pm
and it seems plenty close enough using any one of the 3.
 

