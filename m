From: Dirk Brandewie <dirk.brandewie@gmail.com>
Subject: Re: [PATCH v2 2/2] intel_pstate: Set core to min P state during core
 offline
Date: Tue, 18 Mar 2014 12:44:28 -0700
Message-ID: <5328A21C.3010909@intel.com>
References: <16035918.jZXKnQ3yiq@vostro.rjw.lan> <1394831037-15553-1-git-send-email-dirk.j.brandewie@intel.com> <1394831037-15553-3-git-send-email-dirk.j.brandewie@intel.com> <CAOh2x=kFC5cwdYVgFCwNgqZAwWaE-CFQoyYizBuv1W6MOnQ9DA@mail.gmail.com> <53285FDB.40102@gmail.com> <532895DF.2090100@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:45843 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751590AbaCRToc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 18 Mar 2014 15:44:32 -0400
In-Reply-To: <532895DF.2090100@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Dirk Brandewie <dirk.brandewie@gmail.com>
Cc: dirk.j.brandewie@intel.com, Viresh Kumar <viresh.kumar@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Patrick Marlier <patrick.marlier@gmail.com>

On 03/18/2014 11:52 AM, Srivatsa S. Bhat wrote:
> On 03/18/2014 08:31 PM, Dirk Brandewie wrote:
>> On 03/17/2014 10:44 PM, Viresh Kumar wrote:
>>> On Sat, Mar 15, 2014 at 2:33 AM,  <dirk.brandewie@gmail.com> wrote:
>>>> +
>>>>    static int intel_pstate_cpu_init(struct cpufreq_policy *policy)
>>>>    {
>>>>           struct cpudata *cpu;
>>>> @@ -818,7 +824,7 @@ static struct cpufreq_driver intel_pstate_driver = {
>>>>           .setpolicy      = intel_pstate_set_policy,
>>>>           .get            = intel_pstate_get,
>>>>           .init           = intel_pstate_cpu_init,
>>>> -       .exit           = intel_pstate_cpu_exit,
>>>> +       .stop           = intel_pstate_cpu_stop,
>>>
>>> Probably, keep exit as is and only change P-state in stop(). So that
>>> allocation of resources happen in init() and they are freed in exit()?
>>>
>> I looked at doing just that but it junked up the code.  if stop() is called
>> during PREPARE then init() will be called via __cpufreq_add_dev() in the
>> ONLINE
>> and DOWN_FAILED case. So once stop() is called the driver will be ready for
>> init() to be called exactly like when exit() is called.
>>
>
> I'm sorry, but that didn't make much sense to me. Can you be a little
> more specific as to what problems you hit while trying to have a
> ->stop() which sets min P state and a separate ->exit() which frees
> the resources? I think we can achieve this with almost no trouble.
>

There was no problem per se.  In stop() all I really needed to do is stop the
timer and set the P state to MIN.

At init time I need to allocate memory and start timer.  If stopping the timer
and deallocating memory are separated then I need code in init() to detect
this case.

Moving all the clean up to stop() make my code simpler, covers the
failure case and maintains the behaviour expected by the core.

> If you ignore the failure case (such as DOWN_FAILED) for now, do you
> still see any serious roadblocks?

Why would I ignore a valid failure case?

>
> Regards,
> Srivatsa S. Bhat
>

