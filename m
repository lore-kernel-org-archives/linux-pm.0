From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v8 3/6] cpufreq: powernv: Remove cpu_to_chip_id() from hot-path
Date: Fri, 18 Mar 2016 14:13:59 +0100
Message-ID: <CAJZ5v0jj8+QWseRv0Qw+HqFmpEJdkg0v4iuu3rwM9rOXgMSXZQ@mail.gmail.com>
References: <1454442102-1229-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
	<1454442102-1229-4-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
	<1458273857.6622.75.camel@neuling.org>
	<1458274308.6622.79.camel@neuling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f193.google.com ([209.85.217.193]:35317 "EHLO
	mail-lb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752328AbcCRNOB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 18 Mar 2016 09:14:01 -0400
In-Reply-To: <1458274308.6622.79.camel@neuling.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Neuling <mikey@neuling.org>
Cc: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, pc@us.ibm.com, shreyas@linux.vnet.ibm.com, Anton Blanchard <anton@samba.org>

On Fri, Mar 18, 2016 at 5:11 AM, Michael Neuling <mikey@neuling.org> wrote:
> On Fri, 2016-03-18 at 15:04 +1100, Michael Neuling wrote:
>
>> On Wed, 2016-02-03 at 01:11 +0530, Shilpasri G Bhat wrote:
>>
>
>> > cpu_to_chip_id() does a DT walk through to find out the chip id by
>> > taking a contended device tree lock. This adds an unnecessary
>> > overhead
>> > in a hot path. So instead of calling cpu_to_chip_id() everytime
>> > cache
>> > the chip ids for all cores in the array 'core_to_chip_map' and use
>> > it
>> > in the hotpath.
>> >
>> > Reported-by: Anton Blanchard <anton@samba.org>
>> > Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
>> > Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
>> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>> > ---
>> > No changes from v7.
>>
>> How about this instead?  It removes the linear lookup and seems a lot
>> less complex.

This has gone in already.  Can you please send a patch on top of it?

> BTW we never init nr_chips before using it.  We also need something
> like.
>
> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
> index d63d2cb..c819ed4 100644
> --- a/drivers/cpufreq/powernv-cpufreq.c
> +++ b/drivers/cpufreq/powernv-cpufreq.c
> @@ -556,6 +556,8 @@ static int init_chip_info(void)
>         unsigned int cpu, i;
>         unsigned int prev_chip_id = UINT_MAX;
>
> +       nr_chips = 0;
> +
>         for_each_possible_cpu(cpu) {
>                 unsigned int id = cpu_to_chip_id(cpu);
>
>

Including this part too maybe?

Thanks,
Rafael
