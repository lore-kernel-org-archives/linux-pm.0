From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] cpufreq: Skip all governor-related actions for
 cpufreq_suspended set
Date: Sun, 10 Apr 2016 05:46:16 +0200
Message-ID: <CAJZ5v0iDTTL5U5Btw7ioetgmiqoTB3m7F9C_BanEBxazLshBZA@mail.gmail.com>
References: <2044559.GVlD7a2JcO@vostro.rjw.lan>
	<20160408054513.GF9674@vireshk-i7>
	<1865551.sGARmvFdEr@vostro.rjw.lan>
	<20160410031646.GI9674@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34505 "EHLO
	mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751700AbcDJDqS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 9 Apr 2016 23:46:18 -0400
In-Reply-To: <20160410031646.GI9674@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

On Sun, Apr 10, 2016 at 5:16 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 08-04-16, 23:54, Rafael J. Wysocki wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> Subject: [PATCH] cpufreq: Skip all governor-related actions for cpufreq_suspended set
>>
>> Since governor operations are generally skipped if cpufreq_suspended
>> is set, do nothing at all in cpufreq_start_governor() in that case.
>>
>> That function is called in the cpufreq_online() path, and may also
>> be called from cpufreq_offline() in some cases, which are invoked
>> by the nonboot CPUs disabing/enabling code during system suspend
>> to RAM and resume.  That happens when all devices have been
>> suspended, so if the cpufreq driver relies on things like I2C to
>> get the current frequency, it may not be ready to do that then.
>>
>> The change here prevents problems from happening for this reason.
>>
>> Fixes: 3bbf8fe3ae08 (cpufreq: Always update current frequency before startig governor)
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>> ---
>>  drivers/cpufreq/cpufreq.c |    6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> Index: linux-pm/drivers/cpufreq/cpufreq.c
>> ===================================================================
>> --- linux-pm.orig/drivers/cpufreq/cpufreq.c
>> +++ linux-pm/drivers/cpufreq/cpufreq.c
>> @@ -2053,6 +2053,9 @@ static int cpufreq_start_governor(struct
>>  {
>>       int ret;
>>
>> +     if (cpufreq_suspended)
>> +             return 0;
>> +
>>       if (cpufreq_driver->get && !cpufreq_driver->setpolicy)
>>               cpufreq_update_current_freq(policy);
>
> Since we no longer have the same check in cpufreq_exit_governor(),
> what about moving it to cpufreq_update_current_freq() instead? That's
> all we are trying to protect here anyway, as cpufreq_governor() is
> already protected.

That can be done too.
