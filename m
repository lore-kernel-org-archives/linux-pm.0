From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: bltk-game regressions on snb laptop
Date: Fri, 19 Apr 2013 17:53:09 +0530
Message-ID: <CAKohpongtqt0Sdc95TTrJ+s5A3Xt7df+SmtBZNyHzQKtARLxKA@mail.gmail.com>
References: <516CFA57.3060709@intel.com>
	<CAKohponOVZgAxdX5yv9qmn_56mgTdXEBPr-7o7_pA5GRF09J0w@mail.gmail.com>
	<516F42EE.6080802@intel.com>
	<CAKohpokju79Fx7TXTD1hKoG0JUmCsRm8Us381bhHeUrBvyOv6w@mail.gmail.com>
	<516F81BD.3030306@intel.com>
	<CAKohponG+F6ikVb2iY_Qg5E6NoCkPVj5VC12JqwXfamzsKLrXA@mail.gmail.com>
	<516FB4AF.6060009@intel.com>
	<CAKohpo=NGYadRubvBDLsE=oO1wuDSxnutYfZLm9vu4B6tcUw-g@mail.gmail.com>
	<517115D4.5020505@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f43.google.com ([209.85.219.43]:43993 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968238Ab3DSMXK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 19 Apr 2013 08:23:10 -0400
Received: by mail-oa0-f43.google.com with SMTP id k7so328453oag.30
        for <linux-pm@vger.kernel.org>; Fri, 19 Apr 2013 05:23:09 -0700 (PDT)
In-Reply-To: <517115D4.5020505@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alex Shi <alex.shi@intel.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Arjan van de Ven <arjan@linux.intel.com>, LKP ML <lkp@linux.intel.com>

On 19 April 2013 15:30, Alex Shi <alex.shi@intel.com> wrote:
> the following is cpufreq-info output at 3.9-rc4:
> During bltk-game testing, most of time the cpu freq is 2.2G
> ============
> [root@lkp-sb01 cpufreq]#cpupower frequency-info
> analyzing CPU 0:
>   driver: acpi-cpufreq
>   CPUs which run at the same hardware frequency: 0 1 2 3 4 5 6 7
>   CPUs which need to have their frequency coordinated by software: 0 1 2
> 3 4 5 6 7
>   maximum transition latency: 10.0 us.
>   hardware limits: 800 MHz - 2.20 GHz
>   available frequency steps: 2.20 GHz, 2.20 GHz, 2.00 GHz, 1.90 GHz,
> 1.80 GHz, 1.70 GHz, 1.60 GHz, 1.50 GHz, 1.40 GHz, 1.30 GHz, 1.20 GHz,
> 1.10 GHz, 1000 MHz, 900 MHz, 800 MHz
>   available cpufreq governors: ondemand, userspace, performance
>   current policy: frequency should be within 800 MHz and 2.20 GHz.
>                   The governor "ondemand" may decide which speed to use
>                   within this range.
>   current CPU frequency is 2.20 GHz (asserted by call to hardware).
>   boost state support:
>     Supported: no
>     Active: no
>
> And this is the 3.9-rc5 kernel, with your patch:
> During testing, most of time cpufreq is 0.8Ghz
> ============
> [root@lkp-sb01 ~]#cpupower frequency-info
> analyzing CPU 0:
>   driver: acpi-cpufreq
>   CPUs which run at the same hardware frequency: 0
>   CPUs which need to have their frequency coordinated by software: 0
>   maximum transition latency: 10.0 us.
>   hardware limits: 800 MHz - 2.20 GHz
>   available frequency steps: 2.20 GHz, 2.20 GHz, 2.00 GHz, 1.90 GHz,
> 1.80 GHz, 1.70 GHz, 1.60 GHz, 1.50 GHz, 1.40 GHz, 1.30 GHz, 1.20 GHz,
> 1.10 GHz, 1000 MHz, 900 MHz, 800 MHz
>   available cpufreq governors: ondemand, userspace, performance
>   current policy: frequency should be within 800 MHz and 2.20 GHz.
>                   The governor "ondemand" may decide which speed to use
>                   within this range.
>   current CPU frequency is 800 MHz (asserted by call to hardware).
>   boost state support:
>     Supported: no
>     Active: no

So you get better performance without my patch because we don't allocate
any struct cpufreq_policy for any of the cpus leaving first one. And so only
manage freq change for it and all other cpus stay at max power..

So, we clearly need to know why don't we want to have all cpus set in
policy->cpus, when they actually share clock line?
