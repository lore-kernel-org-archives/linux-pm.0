From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] cpufreq: ppc-corenet: remove duplicate update of cpu_data
Date: Wed, 10 Sep 2014 11:09:25 +0530
Message-ID: <CAKohpo=nLFxv3gpxZLseVYSqGRdyktRzj8GGv5oC20Lq6=s0wA@mail.gmail.com>
References: <09092df3d8b03df99ee475357c5f5c9cc439c61c.1409629117.git.viresh.kumar@linaro.org>
	<CAKohpo=bz7H1CUUNGq_u33oKLnzzgPcqxyMOvC-S_dT8UE0S9A@mail.gmail.com>
	<0f6e492c7d1f4ccfbb98def3aba8ce48@BY2PR03MB570.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:62523 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750791AbaIJFj0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 10 Sep 2014 01:39:26 -0400
Received: by mail-ob0-f172.google.com with SMTP id wp18so1774970obc.17
        for <linux-pm@vger.kernel.org>; Tue, 09 Sep 2014 22:39:25 -0700 (PDT)
In-Reply-To: <0f6e492c7d1f4ccfbb98def3aba8ce48@BY2PR03MB570.namprd03.prod.outlook.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Yuantian Tang <Yuantian.Tang@freescale.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Hongbo Zhang <hongbo.zhang@freescale.com>, "LeoLi@freescale.com" <LeoLi@freescale.com>

On 10 September 2014 11:00, Yuantian Tang <Yuantian.Tang@freescale.com> wrote:
>> On 2 September 2014 09:11, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> > 'cpu_data' is updated for policy->cpu first and then for all CPUs in
>> > policy->cpus. policy->cpus is guaranteed to contain policy->cpu as
>> > policy->well and so
>> > the first write to 'cpu_data' for policy->cpu is redundant. Remove it.

> Yeah, your patch should be ok, but is it the best solution?
> I was thinking about a final solution just like ARM did.

I was talking about an Ack for just 1/2 where we are doing some cleanup,
which shouldn't break anything.

Regarding the second patch, yes you should come up with something that
can give a list of online+offline CPUs like ARM and even some ppc drivers.
We can handle that separately and this patch can be commited by Rafael..

Either you can give a replacement patch for 2/2 or you can let me know what
to do and will help there.
