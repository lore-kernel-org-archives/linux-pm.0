From: Alex Shi <alex.shi@intel.com>
Subject: Re: bltk-game regressions on snb laptop
Date: Thu, 18 Apr 2013 16:54:07 +0800
Message-ID: <516FB4AF.6060009@intel.com>
References: <516CFA57.3060709@intel.com> <CAKohponOVZgAxdX5yv9qmn_56mgTdXEBPr-7o7_pA5GRF09J0w@mail.gmail.com> <516F42EE.6080802@intel.com> <CAKohpokju79Fx7TXTD1hKoG0JUmCsRm8Us381bhHeUrBvyOv6w@mail.gmail.com> <516F81BD.3030306@intel.com> <CAKohponG+F6ikVb2iY_Qg5E6NoCkPVj5VC12JqwXfamzsKLrXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:35350 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966803Ab3DRIyo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 18 Apr 2013 04:54:44 -0400
In-Reply-To: <CAKohponG+F6ikVb2iY_Qg5E6NoCkPVj5VC12JqwXfamzsKLrXA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Arjan van de Ven <arjan@linux.intel.com>, LKP ML <lkp@linux.intel.com>

On 04/18/2013 01:37 PM, Viresh Kumar wrote:
>>> About your system: Can you give output of cpufreq-info for v3.8 and
>>> >> v3.9-latestrc?
>>> >> Your cpus share a clock line or not?
>> >
>> > Yes our cpu shares a clock line. So the cpufreq-info is same. SNB CPU
>> > p-state is per cpu package, and hardware will coordinate the software
>> > asking, then decide which cpufreq should be.
> Can you paste cpufreq-info output, that will give us a better picture of your
> system.
> 

at the most of time with your patch cpufreq-info is 0.8GHz, without the
patch, the cpufreq is varied from 1.0 to 2.8 Ghz.


-- 
Thanks Alex
