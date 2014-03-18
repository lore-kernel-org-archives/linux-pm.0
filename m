From: Dirk Brandewie <dirk.brandewie@gmail.com>
Subject: Re: [PATCH v2 2/2] intel_pstate: Set core to min P state during core
 offline
Date: Tue, 18 Mar 2014 08:01:47 -0700
Message-ID: <53285FDB.40102@gmail.com>
References: <16035918.jZXKnQ3yiq@vostro.rjw.lan>	<1394831037-15553-1-git-send-email-dirk.j.brandewie@intel.com>	<1394831037-15553-3-git-send-email-dirk.j.brandewie@intel.com> <CAOh2x=kFC5cwdYVgFCwNgqZAwWaE-CFQoyYizBuv1W6MOnQ9DA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:43811 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932218AbaCRPBu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 18 Mar 2014 11:01:50 -0400
In-Reply-To: <CAOh2x=kFC5cwdYVgFCwNgqZAwWaE-CFQoyYizBuv1W6MOnQ9DA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: dirk.brandewie@gmail.com, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Patrick Marlier <patrick.marlier@gmail.com>, Dirk Brandewie <dirk.j.brandewie@intel.com>

On 03/17/2014 10:44 PM, Viresh Kumar wrote:
> On Sat, Mar 15, 2014 at 2:33 AM,  <dirk.brandewie@gmail.com> wrote:
>> +
>>   static int intel_pstate_cpu_init(struct cpufreq_policy *policy)
>>   {
>>          struct cpudata *cpu;
>> @@ -818,7 +824,7 @@ static struct cpufreq_driver intel_pstate_driver = {
>>          .setpolicy      = intel_pstate_set_policy,
>>          .get            = intel_pstate_get,
>>          .init           = intel_pstate_cpu_init,
>> -       .exit           = intel_pstate_cpu_exit,
>> +       .stop           = intel_pstate_cpu_stop,
>
> Probably, keep exit as is and only change P-state in stop(). So that
> allocation of resources happen in init() and they are freed in exit()?
>
I looked at doing just that but it junked up the code.  if stop() is called
during PREPARE then init() will be called via __cpufreq_add_dev() in the ONLINE
and DOWN_FAILED case. So once stop() is called the driver will be ready for
init() to be called exactly like when exit() is called.


