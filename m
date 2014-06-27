From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: arm_big_little: set lowest frequcency for
 cluster when no cpus in it
Date: Fri, 27 Jun 2014 14:27:01 +0530
Message-ID: <CAKohpokL-ADipdxYa9Z3KWosDQtvGmQjugCzso+N+QEsGZVOmQ@mail.gmail.com>
References: <1403795313-6903-1-git-send-email-thomas.ab@samsung.com>
	<CAKohpomv=0y30q09fuuRDOGQ_XtuKnerC830vFExNok9mAcyfw@mail.gmail.com>
	<53AC42CE.2050304@arm.com>
	<CAJuA9agJb4xx--ujc3=efeFNFLiw4o87nOig8u-X+kY0wj99dA@mail.gmail.com>
	<53AC6D31.7010709@arm.com>
	<CAJuA9ajOAhZAzwJEsP9bU83n=n30pgawy-otGU4t=d3ADVKOwg@mail.gmail.com>
	<CAKohponCoTuoYaLFWzOhZm2XVYjkS2VUsePuso8othxAVsgsyw@mail.gmail.com>
	<CAJuA9agaMZJQ-qhBZ9oNxdyQh+4EC6VhYOSz5w9rR=5-C72B3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f49.google.com ([209.85.219.49]:47680 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752740AbaF0I5D (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 27 Jun 2014 04:57:03 -0400
Received: by mail-oa0-f49.google.com with SMTP id i7so5170415oag.8
        for <linux-pm@vger.kernel.org>; Fri, 27 Jun 2014 01:57:02 -0700 (PDT)
In-Reply-To: <CAJuA9agaMZJQ-qhBZ9oNxdyQh+4EC6VhYOSz5w9rR=5-C72B3Q@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Abraham <ta.omasab@gmail.com>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>

On 27 June 2014 14:14, Thomas Abraham <ta.omasab@gmail.com> wrote:
> On Fri, Jun 27, 2014 at 12:18 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:

>> Also, we must keep in mind that switching to lowest freq would make
>> it take more time to execute the cluster shutdown code..
>
> The inbound CPU is probably on this way to execute useful code while
> the outbound CPU does the cluster down and it is the frequency of the
> outbound cluster that is being changed here.

I didn't get you here. For the cluster going down, there is no Inbound
CPU. And the last outbound CPU of dying cluster will shut it down and
I was talking about the code it has to execute to get it down.. It will
take more time to get it down now..

> The reason for sending this patch was because of the power saving
> observed on Chromebook platform. So this patch is not based on an
> assumption.

Always ALWAYS mention such details in logs. It helps people understand
you really need it. Giving values would be the best though.. Or atleast
mention % improvement with a commit.

So, how much you saved here?

> There are few blocks running of the CPU clock (internal buses,
> Coresight, JTAG, AXI interface clock).

Don't they go down with the cluster? Or we aren't performing a full
cluster down?

> Also, it has been observed that
> a lower ARM clock reduces the power consumed on the voltage rail for
> the peripherals block.

Peripherals internal to cluster? Like arch-timer?

> Maybe I misunderstand here, but why is this patch being linked with CPU idle?

If this patch saves us some energy for IKS, then we can use something
similar for MP as well by reducing frequency on cluster cpu-idle ..
