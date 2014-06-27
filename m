From: Thomas Abraham <ta.omasab@gmail.com>
Subject: Re: [PATCH] cpufreq: arm_big_little: set lowest frequcency for
 cluster when no cpus in it
Date: Fri, 27 Jun 2014 16:23:41 +0530
Message-ID: <CAJuA9agOAjHTsbnDM87=OFZNODr-DCW8zqmUcU98dbWL=j3bfA@mail.gmail.com>
References: <1403795313-6903-1-git-send-email-thomas.ab@samsung.com>
	<CAKohpomv=0y30q09fuuRDOGQ_XtuKnerC830vFExNok9mAcyfw@mail.gmail.com>
	<53AC42CE.2050304@arm.com>
	<CAJuA9agJb4xx--ujc3=efeFNFLiw4o87nOig8u-X+kY0wj99dA@mail.gmail.com>
	<53AC6D31.7010709@arm.com>
	<CAJuA9ajOAhZAzwJEsP9bU83n=n30pgawy-otGU4t=d3ADVKOwg@mail.gmail.com>
	<CAKohponCoTuoYaLFWzOhZm2XVYjkS2VUsePuso8othxAVsgsyw@mail.gmail.com>
	<CAJuA9agaMZJQ-qhBZ9oNxdyQh+4EC6VhYOSz5w9rR=5-C72B3Q@mail.gmail.com>
	<CAKohpokL-ADipdxYa9Z3KWosDQtvGmQjugCzso+N+QEsGZVOmQ@mail.gmail.com>
	<CAJuA9aiG6=BsqQR7sYS09GYfWLBwzk7zAsjqr29-DET144uLKg@mail.gmail.com>
	<CAKohpokznx0AWPUBKXPZ65qJsMCQLxc1v3cAmC+r-t1=3mQAdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:38517 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752872AbaF0Kxm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 27 Jun 2014 06:53:42 -0400
Received: by mail-la0-f44.google.com with SMTP id ty20so2821457lab.17
        for <linux-pm@vger.kernel.org>; Fri, 27 Jun 2014 03:53:41 -0700 (PDT)
In-Reply-To: <CAKohpokznx0AWPUBKXPZ65qJsMCQLxc1v3cAmC+r-t1=3mQAdQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>

On Fri, Jun 27, 2014 at 3:46 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 27 June 2014 15:37, Thomas Abraham <ta.omasab@gmail.com> wrote:
>> I was trying to emphasis on the point that we are reducing the
>> frequency of the outbound cluster. The inbound CPU (pair of the last
>> man CPU in the outbound cluster) would be executing useful code while
>> the outbound last man CPU is executing the cluster down sequence. Does
>> it hurt if the cluster down sequence is executed a bit slower (and if
>> yes, then why not set the max speed of the cluster for cluster down).
>
> Okay, I wasn't worried about performance but power here.
>
> What I meant was that, because it *might* take more time to
> shutdown the cluster it will be on for longer. And so might end up
> consuming more power with this.

Ok. It is a comparison with the amount of power saved during the
duration in which cluster remains inactive and clocked at a lower
speed.

>
>> I haven't checked in detail but won't the cluster down be completed
>> most of the times before return from bL_switch_request()?
>
> No idea :)
>
>> Depending on the frequency of the outbound cluster, the savings was
>> about 5~10mA. It is close to 25mA in case the PLL driving the CPU is
>> also turned off.
>
> Shouldn't we talk about Energy here instead of current?

Sorry, it is mW units.

>
>>>> There are few blocks running of the CPU clock (internal buses,
>>>> Coresight, JTAG, AXI interface clock).
>>>
>>> Don't they go down with the cluster? Or we aren't performing a full
>>> cluster down?
>>
>> We are doing a full cluster down. I am not sure which of these
>> continue to consume power in case of full cluster down.
>
> None should.
>
>>>> Also, it has been observed that
>>>> a lower ARM clock reduces the power consumed on the voltage rail for
>>>> the peripherals block.
>>>
>>> Peripherals internal to cluster? Like arch-timer?
>>
>> No, the voltage rail on which the SoC peripherals such as
>> connectivity, media, storage IP's are connected.
>
> What do they have to do with cluster frequency ?

I am not sure but maybe maintaining sync between two buses with a
large clock frequency difference between them. Just a guess, but there
does seem to be a relation with the cluster frequency.

Thanks,
Thomas.
