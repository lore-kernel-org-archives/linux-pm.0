From: Dirk Brandewie <dirk.brandewie@gmail.com>
Subject: Re: [PATCH] cpufreq: Make sure CPU is running on a freq from freq-table
Date: Thu, 21 Nov 2013 09:56:32 -0800
Message-ID: <528E4950.9030507@gmail.com>
References: <de5c3ff26e9d06a6e0b06f8ba3da6d8c3ff82304.1385017369.git.viresh.kumar@linaro.org>	<3577662.BKCLJdcf18@vostro.rjw.lan> <CAKohpo=fZ8Fr=CMDzCy3daBU+mZBJ+9fOks6L7WLOZzE7WaAaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yh0-f42.google.com ([209.85.213.42]:61234 "EHLO
	mail-yh0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752640Ab3KUR66 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Nov 2013 12:58:58 -0500
In-Reply-To: <CAKohpo=fZ8Fr=CMDzCy3daBU+mZBJ+9fOks6L7WLOZzE7WaAaQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Nishanth Menon <nm@ti.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Sripa Bagadia <ceh@ti.com>

On 11/21/2013 07:57 AM, Viresh Kumar wrote:
> On 21 November 2013 18:41, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> On Thursday, November 21, 2013 12:39:02 PM Viresh Kumar wrote:
>
>>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>>> @@ -1038,6 +1038,32 @@ static int __cpufreq_add_dev(struct device *dev, struct subsys_interface *sif,
>
>>> +     if (has_target()) {
>>> +             ret = __cpufreq_driver_target(policy, policy->cur,
>>> +                             CPUFREQ_RELATION_L);
>>> +             if (ret)
>>> +                     pr_err("%s: Unable to set frequency from table: %d\n",
>>> +                                     __func__, ret);
>>
>> Should we continue in that case?
>
> I wasn't sure. I thought maybe there are platforms which might not be
> ready for transitions so early and so an error message would be fine,
> as we will fail soon anyway in case there is a bug.
>

The scaling driver for the CPU has already loaded and its .init procedure has 
been called so .target better be callable.

Since the scaling driver is responsible maintaining the set of valid frequencies
and setting policy->cur I think it is reasonable to have the scaling driver
ensure that policy->cur returned from its .init and the operating frequency are
in sync and match one of the values in its frequency table.

--Dirk
> --
> viresh
> --
> To unsubscribe from this list: send the line "unsubscribe cpufreq" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

