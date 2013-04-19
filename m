From: Alex Shi <alex.shi@intel.com>
Subject: Re: bltk-game regressions on snb laptop
Date: Fri, 19 Apr 2013 22:43:32 +0800
Message-ID: <51715814.4080209@intel.com>
References: <516CFA57.3060709@intel.com> <CAKohponOVZgAxdX5yv9qmn_56mgTdXEBPr-7o7_pA5GRF09J0w@mail.gmail.com> <516F42EE.6080802@intel.com> <CAKohpokju79Fx7TXTD1hKoG0JUmCsRm8Us381bhHeUrBvyOv6w@mail.gmail.com> <516F81BD.3030306@intel.com> <CAKohponG+F6ikVb2iY_Qg5E6NoCkPVj5VC12JqwXfamzsKLrXA@mail.gmail.com> <516FB4AF.6060009@intel.com> <CAKohpo=NGYadRubvBDLsE=oO1wuDSxnutYfZLm9vu4B6tcUw-g@mail.gmail.com> <517115D4.5020505@intel.com> <CAKohpongtqt0Sdc95TTrJ+s5A3Xt7df+SmtBZNyHzQKtARLxKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:20714 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030720Ab3DSOnu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 19 Apr 2013 10:43:50 -0400
In-Reply-To: <CAKohpongtqt0Sdc95TTrJ+s5A3Xt7df+SmtBZNyHzQKtARLxKA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Arjan van de Ven <arjan@linux.intel.com>, LKP ML <lkp@linux.intel.com>

On 04/19/2013 08:23 PM, Viresh Kumar wrote:
> So you get better performance without my patch because we don't allocate
> any struct cpufreq_policy for any of the cpus leaving first one. And so only
> manage freq change for it and all other cpus stay at max power..
> 
> So, we clearly need to know why don't we want to have all cpus set in
> policy->cpus, when they actually share clock line?

AFAIK, That because our p-state is HW coordinated. For further info,
Maybe Arjan and Len can explain more.

-- 
Thanks
    Alex
