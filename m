From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 4/4] cpu_cooling: Drop static-power related stuff
Date: Wed, 22 Nov 2017 06:55:32 +0530
Message-ID: <20171122012532.GG6125@vireshk-i7>
References: <20171116152058.GR3257@vireshk-i7>
 <2810372.fJ2vMN0cWO@aspire.rjw.lan>
 <20171116234422.GA6141@localhost.localdomain>
 <878tf5tbfj.fsf@e105922-lin.cambridge.arm.com>
 <35d3751d-f28d-38c2-02b2-c9980f11c52e@arm.com>
 <cab738f4-dbbf-e5d8-af51-14bc3219b53e@linaro.org>
 <5A144CB3.50806@gmail.com>
 <CAKfTPtBBSxV+weYf-9yTf9azc78--8a8x8wNad3OGCYfvEJ4qw@mail.gmail.com>
 <20171121165703.GA2499@localhost.localdomain>
 <20171121180006.GA26638@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:38765 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751353AbdKVBZh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Nov 2017 20:25:37 -0500
Received: by mail-pg0-f65.google.com with SMTP id s11so11649995pgc.5
        for <linux-pm@vger.kernel.org>; Tue, 21 Nov 2017 17:25:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20171121180006.GA26638@localhost>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javi Merino <javi.merino@kernel.org>
Cc: Eduardo Valentin <edubezval@gmail.com>, Vincent Guittot <vincent.guittot@linaro.org>, Lukasz Luba <llu.ker.dev@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Ionela Voinescu <ionela.voinescu@arm.com>, Punit Agrawal <punit.agrawal@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Rafael J. Wysocki" <rafael@kernel.org>, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>, Linux PM <linux-pm@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 21-11-17, 18:00, Javi Merino wrote:
> As Ionela pointed out earlier in the thread, the cpufreq driver for Juno
> was not acceptable for mainline because it used platform specific code.

Can we get a link to that thread? I don't remember what I have commented earlier
but the above doesn't seem to be entirely true.

The basic idea is to use as much common stuff as possible and so to use
cpufreq-dt.c if possible. Its not that we are against platform specific bits,
they are fine if they are really required.

> When it was converted to cpufreq-dt, the static power was left behind
> because it can't be represented in device tree.  This is because there
> isn't a function that works for every SoC, different process nodes
> (among other things) will need different functions.  So it can't be just
> a bunch of coefficients in DT, we need a function.  Hence the callback.

Sure thing. And we can make this happen if we need. We aren't blocking it.

> In a nutshell, mainline does not want platform specific code, but we

Not really. We don't want platform specific code in arch/arm64, but we can have
that in drivers/opp/ for example if required.

Please start a discussion (in a separate thread if you want) and we can get
cpufreq support updated for Juno very easily.

And don't worry about this patch here. We can surely drop the patch if someone
is serious enough to start using it. But there needs to be a commitment, nothing
more.

-- 
viresh
