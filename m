From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 3/3] cpufreq: schedutil: remove redundant code from
 sugov_next_freq_shared()
Date: Tue, 7 Mar 2017 16:01:08 +0530
Message-ID: <20170307103108.GA4526@vireshk-i7>
References: <cover.1488437503.git.viresh.kumar@linaro.org>
 <639aad743bac7f3292146738f44dbd1480169c8e.1488437503.git.viresh.kumar@linaro.org>
 <1772276.4tCnP8C0XV@aspire.rjw.lan>
 <1668614.4zDQWLsnmH@aspire.rjw.lan>
 <20170306044553.GE8206@vireshk-i7>
 <CAJZ5v0hov8Lz_MK9dxP9MyqSmPNRfWV9Wia4DtAZtOPmoTOqAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f41.google.com ([74.125.83.41]:35502 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750744AbdCGKcJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Mar 2017 05:32:09 -0500
Received: by mail-pg0-f41.google.com with SMTP id b129so77603697pgc.2
        for <linux-pm@vger.kernel.org>; Tue, 07 Mar 2017 02:31:12 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hov8Lz_MK9dxP9MyqSmPNRfWV9Wia4DtAZtOPmoTOqAw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>

On 06-03-17, 13:24, Rafael J. Wysocki wrote:
> On Mon, Mar 6, 2017 at 5:45 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > On 04-03-17, 01:11, Rafael J. Wysocki wrote:
> >> So one idea is that if SCHED_CPUFREQ_RT_DL is set in flags, we don't even
> >> need to start the loop which is quite a cost to simply notice that there's
> >> nothing to do.
> >
> > Hmm. Isn't the probability of this flag being set, same for all CPUs in the
> > policy?
> 
> No, I don't think so.

Why do you think so? I thought all CPU in the policy can have the RT/DL flag set
and the probability of all of them is just the same.

> So to the point, the code was written this way on purpose and not just
> by accident as your changelog suggests and

I didn't wanted to convey that really and I knew that it was written on purpose.

> if you want to change it, you need numbers.

What kind of numbers can we get for such a change ? I tried to take the running
average of the time it takes to execute this routine over 10000 samples, but it
varies a lot even with the same build. Any tests like hackbench, etc wouldn't be
of any help as well.

-- 
viresh
