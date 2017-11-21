From: Lukasz Luba <llu.ker.dev@gmail.com>
Subject: Re: [PATCH 4/4] cpu_cooling: Drop static-power related stuff
Date: Wed, 22 Nov 2017 00:32:27 +0100
Message-ID: <5A14B78B.8070407@gmail.com>
References: <2810372.fJ2vMN0cWO@aspire.rjw.lan> <20171116234422.GA6141@localhost.localdomain> <878tf5tbfj.fsf@e105922-lin.cambridge.arm.com> <35d3751d-f28d-38c2-02b2-c9980f11c52e@arm.com> <cab738f4-dbbf-e5d8-af51-14bc3219b53e@linaro.org> <5A144CB3.50806@gmail.com> <CAKfTPtBBSxV+weYf-9yTf9azc78--8a8x8wNad3OGCYfvEJ4qw@mail.gmail.com> <20171121165703.GA2499@localhost.localdomain> <20171121180006.GA26638@localhost> <6cd409ee-c839-09ad-3fa2-5309b0d007f5@linaro.org> <20171121181351.GB4075@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34980 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751290AbdKUXcb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Nov 2017 18:32:31 -0500
In-Reply-To: <20171121181351.GB4075@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Javi Merino <javi.merino@kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Ionela Voinescu <ionela.voinescu@arm.com>, Punit Agrawal <punit.agrawal@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>, Linux PM <linux-pm@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 21/11/17 19:13, Eduardo Valentin wrote:
> On Tue, Nov 21, 2017 at 07:05:46PM +0100, Daniel Lezcano wrote:
>> On 21/11/2017 19:00, Javi Merino wrote:
>>> Hi,
>>>
>>> On Tue, Nov 21, 2017 at 08:57:06AM -0800, Eduardo Valentin wrote:
>>>
>>> [snip]
>>>
>>>> As I said before, the minimal you guys (ARM and Linaro) can do is to at
>>>> least upstream the Juno code! as a reference. Come on guys?  what is
>>>> preventing you to upstream Juno model?
>>>
>>> As Ionela pointed out earlier in the thread, the cpufreq driver for Juno
>>> was not acceptable for mainline because it used platform specific code.
>>> When it was converted to cpufreq-dt, the static power was left behind
>>> because it can't be represented in device tree.  This is because there
>>> isn't a function that works for every SoC, different process nodes
>>> (among other things) will need different functions.  So it can't be just
>>> a bunch of coefficients in DT, we need a function.  Hence the callback.
>>
>> The DT could contain the coef and a compatible string for a specific
>> polynomial computation callback. I imagine we should not have a lot of
>> different equations, no ?
>>
>
> Yeah, that would be another way of doing it. If there is no equation
> that correlates all processes, then we need a vendor specific entry, or
> a compatible string, as Daniel said.
>
So we have ~8 weeks (before it will vanish from mainline) to come up 
with ideas
or to show that it is needed and used by some platform.
Let's see...

Regards,
Lukasz
