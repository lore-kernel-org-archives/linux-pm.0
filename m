From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: PROBLEM: Kernel OOPS and possible system freeze after concurrent
 writing to cpufreq/scaling_governor (Resend)
Date: Thu, 24 Jul 2014 15:12:54 +0530
Message-ID: <CAKohpomo_Qoc-ioC-L-n6z19SLMgCfzebec7pqkq9y86gt61HA@mail.gmail.com>
References: <1405522398.2348.42.camel@x200t>
	<1406185912.2406.3.camel@x200t>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f42.google.com ([209.85.219.42]:44279 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756727AbaGXJmz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 24 Jul 2014 05:42:55 -0400
Received: by mail-oa0-f42.google.com with SMTP id n16so3317662oag.1
        for <linux-pm@vger.kernel.org>; Thu, 24 Jul 2014 02:42:54 -0700 (PDT)
In-Reply-To: <1406185912.2406.3.camel@x200t>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?Q?Robert_Sch=C3=B6ne?= <robert.schoene@tu-dresden.de>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 24 July 2014 12:41, Robert Sch=C3=B6ne <robert.schoene@tu-dresden.de=
> wrote:
> (Resend, because there hasn't been a reply within the last week)

How did I miss it? Yes its in my inbox. Sorry buddy..

> crash_governor.sh:
> #!/bin/sh
> # this is called concurrently via runme.sh
> for I in `seq 1000`
> do
>         echo ondemand | sudo tee /sys/devices/system/cpu/cpu*/cpufreq=
/scaling_governor
>         echo userspace | sudo tee /sys/devices/system/cpu/cpu*/cpufre=
q/scaling_governor
> done
>
> runme.sh:
> #!/bin/sh
> # run 8 concurrent instances
> for I in `seq 8`
> do
>         ./crash_governor.sh &
> done
>
> Just run runme.sh and crash your system :)

Oh, yes. Quite easily I could see that happening :)

I have pushed a fix earlier for similar issues:
19c7630 cpufreq: serialize calls to __cpufreq_governor()

but was later reverted by Srivatsa:
56d07db cpufreq: Remove temporary fix for race between CPU hotplug and
sysfs-writes

because we didn't thought about this usecase.

I propose we get that back. I have tested a revert of 56d07db on
my setup and didn't see any crash..

Please see if that works for you as well..

--
viresh
