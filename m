From: Alex Shi <alex.shi@intel.com>
Subject: Re: bltk-game regressions on snb laptop
Date: Thu, 18 Apr 2013 08:23:45 +0800
Message-ID: <516F3D11.1020404@intel.com>
References: <516CFA57.3060709@intel.com> <4800526.1vKQhy36XA@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:58282 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934878Ab3DRAY0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 17 Apr 2013 20:24:26 -0400
In-Reply-To: <4800526.1vKQhy36XA@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM list <linux-pm@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Arjan van de Ven <arjan@linux.intel.com>, LKP ML <lkp@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>

On 04/18/2013 12:34 AM, Rafael J. Wysocki wrote:
> On Tuesday, April 16, 2013 03:14:31 PM Alex Shi wrote:
>> LKP found a performance and performance/watt regression on commit
>> aa77a52764a92216b61, acpi-cpufreq: Don't set policy->related_cpus from
>> .init.
>>
>> The commit removed the related_cpus setting, plus Our laptop has no
>> coordinate type setting in BIOS. So the related_cpus is only include the
>> cpu self, then the policy->cpus are impacted and only has self too.
>>
>> With ondemand governor, the bad commit cause bltk-game benchmark drop to
>> 18fps from 50fps, the performance/watt value also dropped a lot.
>> bltk-game runs 9 thread on the 4core*HT laptop.
>>
>> As Arjan and Len mentioned, the commit is correct in logical,
>> policy->cpus should only include the cpu self.
>> So I don't know where is the problem, maybe ondemand or some place
>> others. Anyway, I just report the issue to you.
> 
> Have you verified that reverting the commit in question causes the problem to
> go away?

yes, after revert, the fps is back to about 50fps from 18fps.
> 
> Rafael
> 
> 


-- 
Thanks Alex
