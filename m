From: Alex Shi <alex.shi@intel.com>
Subject: Re: bltk-game regressions on snb laptop
Date: Thu, 18 Apr 2013 14:16:41 +0800
Message-ID: <516F8FC9.8010005@intel.com>
References: <516CFA57.3060709@intel.com> <CAKohponOVZgAxdX5yv9qmn_56mgTdXEBPr-7o7_pA5GRF09J0w@mail.gmail.com> <516F42EE.6080802@intel.com> <CAKohpokju79Fx7TXTD1hKoG0JUmCsRm8Us381bhHeUrBvyOv6w@mail.gmail.com> <516F81BD.3030306@intel.com> <CAKohponG+F6ikVb2iY_Qg5E6NoCkPVj5VC12JqwXfamzsKLrXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:44461 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754508Ab3DRGRV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 18 Apr 2013 02:17:21 -0400
In-Reply-To: <CAKohponG+F6ikVb2iY_Qg5E6NoCkPVj5VC12JqwXfamzsKLrXA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Arjan van de Ven <arjan@linux.intel.com>, LKP ML <lkp@linux.intel.com>

On 04/18/2013 01:37 PM, Viresh Kumar wrote:
>>> >> About your system: Can you give output of cpufreq-info for v3.8 and
>>> >> v3.9-latestrc?
>>> >> Your cpus share a clock line or not?
>> >
>> > Yes our cpu shares a clock line. So the cpufreq-info is same. SNB CPU
>> > p-state is per cpu package, and hardware will coordinate the software
>> > asking, then decide which cpufreq should be.
> Can you paste cpufreq-info output, that will give us a better picture of your
> system.

will give you turbostat info later.
> 
>> > That's sth I am also confused. Yes, that cpu share a clock line. But
>> > Arjan and Len both said affected_cpus should only include the cpu self,
>> > because cpu will do hardware coordination for them.
> Why? we need a reason for that.... Do they mean Linux shouldn't be aware
> of any requirement of freq sync? But why?

Nope.
acpi_processor_preregister_performance() will read ACPI table and get the 
p-state coordinate type. I think that is the agreement between kernel and hardware.

Maybe the ondemand governor doesn't fit well with the laptop's p-state internal logical.
So, there is intel p-state driver for SNB, and it use different internal governor.

acpi_processor_preregister_performance():
715                 if (pdomain->coord_type == DOMAIN_COORD_TYPE_SW_ALL)
716                         pr->performance->shared_type = CPUFREQ_SHARED_TYPE_ALL;
717                 else if (pdomain->coord_type == DOMAIN_COORD_TYPE_HW_ALL)
718                         pr->performance->shared_type = CPUFREQ_SHARED_TYPE_HW;
719                 else if (pdomain->coord_type == DOMAIN_COORD_TYPE_SW_ANY)
720                         pr->performance->shared_type = CPUFREQ_SHARED_TYPE_ANY;
721 



-- 
Thanks Alex
