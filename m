From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 4/4] cpu_cooling: Drop static-power related stuff
Date: Tue, 21 Nov 2017 19:05:46 +0100
Message-ID: <6cd409ee-c839-09ad-3fa2-5309b0d007f5@linaro.org>
References: <65fef2a1-d23f-3de2-bd91-021296c3e2f7@arm.com>
 <20171116152058.GR3257@vireshk-i7> <2810372.fJ2vMN0cWO@aspire.rjw.lan>
 <20171116234422.GA6141@localhost.localdomain>
 <878tf5tbfj.fsf@e105922-lin.cambridge.arm.com>
 <35d3751d-f28d-38c2-02b2-c9980f11c52e@arm.com>
 <cab738f4-dbbf-e5d8-af51-14bc3219b53e@linaro.org> <5A144CB3.50806@gmail.com>
 <CAKfTPtBBSxV+weYf-9yTf9azc78--8a8x8wNad3OGCYfvEJ4qw@mail.gmail.com>
 <20171121165703.GA2499@localhost.localdomain>
 <20171121180006.GA26638@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:42039 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751318AbdKUSFv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Nov 2017 13:05:51 -0500
Received: by mail-wm0-f65.google.com with SMTP id l188so3481785wma.1
        for <linux-pm@vger.kernel.org>; Tue, 21 Nov 2017 10:05:50 -0800 (PST)
In-Reply-To: <20171121180006.GA26638@localhost>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javi Merino <javi.merino@kernel.org>, Eduardo Valentin <edubezval@gmail.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, Lukasz Luba <llu.ker.dev@gmail.com>, Ionela Voinescu <ionela.voinescu@arm.com>, Punit Agrawal <punit.agrawal@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>, Linux PM <linux-pm@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 21/11/2017 19:00, Javi Merino wrote:
> Hi,
> 
> On Tue, Nov 21, 2017 at 08:57:06AM -0800, Eduardo Valentin wrote:
> 
> [snip]
> 
>> As I said before, the minimal you guys (ARM and Linaro) can do is to at
>> least upstream the Juno code! as a reference. Come on guys?  what is
>> preventing you to upstream Juno model?
> 
> As Ionela pointed out earlier in the thread, the cpufreq driver for Juno
> was not acceptable for mainline because it used platform specific code.
> When it was converted to cpufreq-dt, the static power was left behind
> because it can't be represented in device tree.  This is because there
> isn't a function that works for every SoC, different process nodes
> (among other things) will need different functions.  So it can't be just
> a bunch of coefficients in DT, we need a function.  Hence the callback.

The DT could contain the coef and a compatible string for a specific
polynomial computation callback. I imagine we should not have a lot of
different equations, no ?



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
