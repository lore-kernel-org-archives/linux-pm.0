From: Alex Shi <alex.shi@intel.com>
Subject: Re: bltk-game regressions on snb laptop
Date: Fri, 19 Apr 2013 18:00:52 +0800
Message-ID: <517115D4.5020505@intel.com>
References: <516CFA57.3060709@intel.com> <CAKohponOVZgAxdX5yv9qmn_56mgTdXEBPr-7o7_pA5GRF09J0w@mail.gmail.com> <516F42EE.6080802@intel.com> <CAKohpokju79Fx7TXTD1hKoG0JUmCsRm8Us381bhHeUrBvyOv6w@mail.gmail.com> <516F81BD.3030306@intel.com> <CAKohponG+F6ikVb2iY_Qg5E6NoCkPVj5VC12JqwXfamzsKLrXA@mail.gmail.com> <516FB4AF.6060009@intel.com> <CAKohpo=NGYadRubvBDLsE=oO1wuDSxnutYfZLm9vu4B6tcUw-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:34275 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751783Ab3DSKAz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 19 Apr 2013 06:00:55 -0400
In-Reply-To: <CAKohpo=NGYadRubvBDLsE=oO1wuDSxnutYfZLm9vu4B6tcUw-g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Arjan van de Ven <arjan@linux.intel.com>, LKP ML <lkp@linux.intel.com>

On 04/18/2013 06:01 PM, Viresh Kumar wrote:
> On 18 April 2013 14:24, Alex Shi <alex.shi@intel.com> wrote:
>> On 04/18/2013 01:37 PM, Viresh Kumar wrote:
>>>>> About your system: Can you give output of cpufreq-info for v3.8 and
>>>>>>> v3.9-latestrc?
>>>>>>> Your cpus share a clock line or not?
>>>>>
>>>>> Yes our cpu shares a clock line. So the cpufreq-info is same. SNB CPU
>>>>> p-state is per cpu package, and hardware will coordinate the software
>>>>> asking, then decide which cpufreq should be.
>>> Can you paste cpufreq-info output, that will give us a better picture of your
>>> system.
>>>
>>
>> at the most of time with your patch cpufreq-info is 0.8GHz, without the
>> patch, the cpufreq is varied from 1.0 to 2.8 Ghz.
> 
> I need full output of following command:
> 
> $ cpufreq-info

Sorry for replay late.

the following is cpufreq-info output at 3.9-rc4:
During bltk-game testing, most of time the cpu freq is 2.2G
============
[root@lkp-sb01 cpufreq]#cpupower frequency-info
analyzing CPU 0:
  driver: acpi-cpufreq
  CPUs which run at the same hardware frequency: 0 1 2 3 4 5 6 7
  CPUs which need to have their frequency coordinated by software: 0 1 2
3 4 5 6 7
  maximum transition latency: 10.0 us.
  hardware limits: 800 MHz - 2.20 GHz
  available frequency steps: 2.20 GHz, 2.20 GHz, 2.00 GHz, 1.90 GHz,
1.80 GHz, 1.70 GHz, 1.60 GHz, 1.50 GHz, 1.40 GHz, 1.30 GHz, 1.20 GHz,
1.10 GHz, 1000 MHz, 900 MHz, 800 MHz
  available cpufreq governors: ondemand, userspace, performance
  current policy: frequency should be within 800 MHz and 2.20 GHz.
                  The governor "ondemand" may decide which speed to use
                  within this range.
  current CPU frequency is 2.20 GHz (asserted by call to hardware).
  boost state support:
    Supported: no
    Active: no

And this is the 3.9-rc5 kernel, with your patch:
During testing, most of time cpufreq is 0.8Ghz
============
[root@lkp-sb01 ~]#cpupower frequency-info
analyzing CPU 0:
  driver: acpi-cpufreq
  CPUs which run at the same hardware frequency: 0
  CPUs which need to have their frequency coordinated by software: 0
  maximum transition latency: 10.0 us.
  hardware limits: 800 MHz - 2.20 GHz
  available frequency steps: 2.20 GHz, 2.20 GHz, 2.00 GHz, 1.90 GHz,
1.80 GHz, 1.70 GHz, 1.60 GHz, 1.50 GHz, 1.40 GHz, 1.30 GHz, 1.20 GHz,
1.10 GHz, 1000 MHz, 900 MHz, 800 MHz
  available cpufreq governors: ondemand, userspace, performance
  current policy: frequency should be within 800 MHz and 2.20 GHz.
                  The governor "ondemand" may decide which speed to use
                  within this range.
  current CPU frequency is 800 MHz (asserted by call to hardware).
  boost state support:
    Supported: no
    Active: no

> 
> This has got lots of other details too.
> 


-- 
Thanks
    Alex
