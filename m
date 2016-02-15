From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: Crashes in arm qemu emulations due to 'cpufreq: governor: Replace
 timers with utilization ...'
Date: Mon, 15 Feb 2016 21:38:25 +0100
Message-ID: <CAJZ5v0hqVCXE0kDfr_4zLz_-c-4KJo8bJg8xVVc1Qd66eA+iHQ@mail.gmail.com>
References: <20160215170527.GA24453@roeck-us.net>
	<CAJZ5v0gLankSuziQq25qTCyNqeOX43yD9jnJu_XXwbdyajfmKg@mail.gmail.com>
	<20160215190116.GX19432@atomide.com>
	<56C229A5.8020901@roeck-us.net>
	<20160215195839.GA19432@atomide.com>
	<56C23088.8050400@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176]:33463 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751864AbcBOUi1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Feb 2016 15:38:27 -0500
In-Reply-To: <56C23088.8050400@roeck-us.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Tony Lindgren <tony@atomide.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-next@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Mon, Feb 15, 2016 at 9:09 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> On 02/15/2016 11:58 AM, Tony Lindgren wrote:
>>
>> * Guenter Roeck <linux@roeck-us.net> [160215 11:41]:
>>>
>>> On 02/15/2016 11:01 AM, Tony Lindgren wrote:
>>>>
>>>>
>>>> https://kernelci.org/boot/all/job/next/kernel/next-20160215/
>>>>
>>>> The SMP ones seem to fail with some regulator issues?
>>>>
>>>
>>> There is another problem, introduced with 6a0712f6f199e ("PM / OPP: Add
>>> dev_pm_opp_set_rate()"). The kernelci boot log for
>>> next-20160212:omap3-overo-tobi
>>> and others experience that problem.
>>>
>>> Essentially, the code now assumes that a CPU clock always has a voltage
>>> regulator attached to it, which is not correct. I sent out a patch to fix
>>> that problem a minute ago.
>>
>>
>> Yes that fixed it thanks.
>>
>
> Confirmed. With this patch plus mine, all arm qemu tests are again passing
> for me.

OK, I'll add it to the governor changes branch.

Thanks,
Rafael
