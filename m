From: Thomas Abraham <ta.omasab@gmail.com>
Subject: Re: [PATCH] cpufreq: arm_big_little: set lowest frequcency for
 cluster when no cpus in it
Date: Fri, 27 Jun 2014 14:14:38 +0530
Message-ID: <CAJuA9agaMZJQ-qhBZ9oNxdyQh+4EC6VhYOSz5w9rR=5-C72B3Q@mail.gmail.com>
References: <1403795313-6903-1-git-send-email-thomas.ab@samsung.com>
	<CAKohpomv=0y30q09fuuRDOGQ_XtuKnerC830vFExNok9mAcyfw@mail.gmail.com>
	<53AC42CE.2050304@arm.com>
	<CAJuA9agJb4xx--ujc3=efeFNFLiw4o87nOig8u-X+kY0wj99dA@mail.gmail.com>
	<53AC6D31.7010709@arm.com>
	<CAJuA9ajOAhZAzwJEsP9bU83n=n30pgawy-otGU4t=d3ADVKOwg@mail.gmail.com>
	<CAKohponCoTuoYaLFWzOhZm2XVYjkS2VUsePuso8othxAVsgsyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:57689 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752606AbaF0Iok (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 27 Jun 2014 04:44:40 -0400
Received: by mail-lb0-f177.google.com with SMTP id u10so3688951lbd.8
        for <linux-pm@vger.kernel.org>; Fri, 27 Jun 2014 01:44:38 -0700 (PDT)
In-Reply-To: <CAKohponCoTuoYaLFWzOhZm2XVYjkS2VUsePuso8othxAVsgsyw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>

On Fri, Jun 27, 2014 at 12:18 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 27 June 2014 11:41, Thomas Abraham <ta.omasab@gmail.com> wrote:
>> On Fri, Jun 27, 2014 at 12:27 AM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
>>> Alternatively in a multi-cluster platform if I hotplug out all the cpus in
>>> one
>>> cluster, do you mean we still have to explicitly set the frequency to lowest
>>> before the last cpu goes down.
>>
>> Yes, but it would "after" the last cpu goes down. As mentioned in my
>
> How will you change freq *after* last cpu goes down? This code
> always initiate freq-switch from last-cpu.

meaning, after the 'bL_switch_request' call for the last cpu in the cluster.

>
> Also, we must keep in mind that switching to lowest freq would make
> it take more time to execute the cluster shutdown code..

The inbound CPU is probably on this way to execute useful code while
the outbound CPU does the cluster down and it is the frequency of the
outbound cluster that is being changed here.

>
>> previous reply, there is an opportunity to save power by doing this.
>>
>>> This needs to be handled implicitly IMO, but
>>> they may be some restrictions on some platforms which I am not aware of.
>>
>> This change is useful on Exynos based platforms and not intrusive
>> either. So if we can get this on linux-next and gets test coverage on
>> other platforms until maybe -rc7, we can be reasonably sure that other
>> platforms are not affected by this. I see no reason in holding this
>> back just based on assumptions about other platforms.
>
> I don't think getting this to linux-next would make a difference. There
> aren't many big LITTLE platforms, even lesser would be using linux-next
> and very very few would be using IKS :)
>
> So, we have to decide whatever we want here only.

Ok.

>
> @Nicolas: Please comment here, we need your suggestions :)
>
> As I told you before, I wrote something similar long back and had the
> same mindset as you have now. Yes, it *might* be useful but we
> wanna be sure about it. That's why all these discussions. So, just
> hold on :)

The reason for sending this patch was because of the power saving
observed on Chromebook platform. So this patch is not based on an
assumption.

>
> I am not asking you to reveal internals of Exynos octa, but what exactly
> is using this clock when the cluster goes down? L2 caches might stay on
> for a while if they have something useful, don't know exactly how the
> CPU clock would be affecting that..

There are few blocks running of the CPU clock (internal buses,
Coresight, JTAG, AXI interface clock). Also, it has been observed that
a lower ARM clock reduces the power consumed on the voltage rail for
the peripherals block.

>
> This is what my understanding is and it holds true for the cpuidle case
> sudeep mentioned:
> - If cluster is going to shutdown soon, there is no point changing clk rate.
> - If cluster isn't going down for a complete shutdown, yes we can save
> some power by playing with clk rate. And the L2 cache example above
> fits here.
>
> @Daniel: Are there some idle states for clusters where we aren't switching
> it off completely, but all CPUs are idle? And will switching to lowest freq
> sensible there ?

Maybe I misunderstand here, but why is this patch being linked with CPU idle?

Thanks,
Thomas.

>
> --
> viresh
