From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH V2 1/5] sched: idle: cpuidle: Check the latency req before
 idle
Date: Tue, 28 Oct 2014 19:59:19 +0100
Message-ID: <544FE787.8090108@linaro.org>
References: <1414054881-17713-1-git-send-email-daniel.lezcano@linaro.org> <CAM4v1pOg1GFW82WD8b6Vas5xhYQrQtdP1STGxyzYtrBNSa+-Pw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:47386 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751386AbaJ1S7U (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 28 Oct 2014 14:59:20 -0400
Received: by mail-wi0-f174.google.com with SMTP id q5so10290464wiv.7
        for <linux-pm@vger.kernel.org>; Tue, 28 Oct 2014 11:59:19 -0700 (PDT)
In-Reply-To: <CAM4v1pOg1GFW82WD8b6Vas5xhYQrQtdP1STGxyzYtrBNSa+-Pw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Preeti Murthy <preeti.lkml@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Nicolas Pitre <nicolas.pitre@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, patches@linaro.org, Preeti U Murthy <preeti@linux.vnet.ibm.com>

On 10/28/2014 04:51 AM, Preeti Murthy wrote:
> Hi Daniel,
>
> On Thu, Oct 23, 2014 at 2:31 PM, Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>> When the pmqos latency requirement is set to zero that means "poll i=
n all the
>> cases".
>>
>> That is correctly implemented on x86 but not on the other archs.
>>
>> As how is written the code, if the latency request is zero, the gove=
rnor will
>> return zero, so corresponding, for x86, to the poll function, but fo=
r the
>> others arch the default idle function. For example, on ARM this is w=
ait-for-
>> interrupt with a latency of '1', so violating the constraint.
>
> This is not true actually. On PowerPC the idle state 0 has an exit_la=
tency of 0.
>
>>
>> In order to fix that, do the latency requirement check *before* call=
ing the
>> cpuidle framework in order to jump to the poll function without ente=
ring
>> cpuidle. That has several benefits:
>
> Doing so actually hurts on PowerPC. Because the idle loop defined for
> idle state 0 is different from what cpu_relax() does in cpu_idle_loop=
().
> The spinning is more power efficient in the former case. Moreover we =
also set
> certain register values which indicate an idle cpu. The ppc_runlatch =
bits
> do precisely this. These register values are being read by some user =
space
> tools.  So we will end up breaking them with this patch
>
> My suggestion is very well keep the latency requirement check in
> kernel/sched/idle.c
> like your doing in this patch. But before jumping to cpu_idle_loop ve=
rify if the
> idle state 0 has an exit_latency > 0 in addition to your check on the
> latency_req =3D=3D 0.
> If not, you can fall through to the regular path of calling into the
> cpuidle driver.
> The scheduler can query the cpuidle_driver structure anyway.
>
> What do you think?

Thanks for reviewing the patch and spotting this.

Wouldn't make sense to create:

void __weak_cpu_idle_poll(void) ?

and override it with your specific poll function ?

--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

