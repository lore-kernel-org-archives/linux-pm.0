From: Thomas Abraham <ta.omasab@gmail.com>
Subject: Re: [PATCH] cpufreq: arm_big_little: set lowest frequcency for
 cluster when no cpus in it
Date: Fri, 27 Jun 2014 15:37:03 +0530
Message-ID: <CAJuA9aiG6=BsqQR7sYS09GYfWLBwzk7zAsjqr29-DET144uLKg@mail.gmail.com>
References: <1403795313-6903-1-git-send-email-thomas.ab@samsung.com>
	<CAKohpomv=0y30q09fuuRDOGQ_XtuKnerC830vFExNok9mAcyfw@mail.gmail.com>
	<53AC42CE.2050304@arm.com>
	<CAJuA9agJb4xx--ujc3=efeFNFLiw4o87nOig8u-X+kY0wj99dA@mail.gmail.com>
	<53AC6D31.7010709@arm.com>
	<CAJuA9ajOAhZAzwJEsP9bU83n=n30pgawy-otGU4t=d3ADVKOwg@mail.gmail.com>
	<CAKohponCoTuoYaLFWzOhZm2XVYjkS2VUsePuso8othxAVsgsyw@mail.gmail.com>
	<CAJuA9agaMZJQ-qhBZ9oNxdyQh+4EC6VhYOSz5w9rR=5-C72B3Q@mail.gmail.com>
	<CAKohpokL-ADipdxYa9Z3KWosDQtvGmQjugCzso+N+QEsGZVOmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f50.google.com ([209.85.215.50]:36300 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753130AbaF0KHE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 27 Jun 2014 06:07:04 -0400
Received: by mail-la0-f50.google.com with SMTP id pv20so2827025lab.9
        for <linux-pm@vger.kernel.org>; Fri, 27 Jun 2014 03:07:03 -0700 (PDT)
In-Reply-To: <CAKohpokL-ADipdxYa9Z3KWosDQtvGmQjugCzso+N+QEsGZVOmQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>

On Fri, Jun 27, 2014 at 2:27 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 27 June 2014 14:14, Thomas Abraham <ta.omasab@gmail.com> wrote:
>> On Fri, Jun 27, 2014 at 12:18 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
>>> Also, we must keep in mind that switching to lowest freq would make
>>> it take more time to execute the cluster shutdown code..
>>
>> The inbound CPU is probably on this way to execute useful code while
>> the outbound CPU does the cluster down and it is the frequency of the
>> outbound cluster that is being changed here.
>
> I didn't get you here. For the cluster going down, therclock e is no Inbound
> CPU. And the last outbound CPU of dying cluster will shut it down and
> I was talking about the code it has to execute to get it down.. It will
> take more time to get it down now..

I was trying to emphasis on the point that we are reducing the
frequency of the outbound cluster. The inbound CPU (pair of the last
man CPU in the outbound cluster) would be executing useful code while
the outbound last man CPU is executing the cluster down sequence. Does
it hurt if the cluster down sequence is executed a bit slower (and if
yes, then why not set the max speed of the cluster for cluster down).

I haven't checked in detail but won't the cluster down be completed
most of the times before return from bL_switch_request()?

>
>> The reason for sending this patch was because of the power saving
>> observed on Chromebook platform. So this patch is not based on an
>> assumption.
>
> Always ALWAYS mention such details in logs. It helps people understand
> you really need it. Giving values would be the best though.. Or atleast
> mention % improvement with a commit.
>
> So, how much you saved here?

Depending on the frequency of the outbound cluster, the savings was
about 5~10mA. It is close to 25mA in case the PLL driving the CPU is
also turned off.

>
>> There are few blocks running of the CPU clock (internal buses,
>> Coresight, JTAG, AXI interface clock).
>
> Don't they go down with the cluster? Or we aren't performing a full
> cluster down?

We are doing a full cluster down. I am not sure which of these
continue to consume power in case of full cluster down.

>
>> Also, it has been observed that
>> a lower ARM clock reduces the power consumed on the voltage rail for
>> the peripherals block.
>
> Peripherals internal to cluster? Like arch-timer?

No, the voltage rail on which the SoC peripherals such as
connectivity, media, storage IP's are connected.

>
>> Maybe I misunderstand here, but why is this patch being linked with CPU idle?
>
> If this patch saves us some energy for IKS, then we can use something
> similar for MP as well by reducing frequency on cluster cpu-idle ..

Ok. The reason I asked was because this is being done in
bL_cpufreq_set_rate() function.

Thanks,
Thomas.
