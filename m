From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 3/3] cpufreq: schedutil: remove redundant code from
 sugov_next_freq_shared()
Date: Wed, 8 Mar 2017 09:48:23 +0530
Message-ID: <20170308041823.GB4526@vireshk-i7>
References: <cover.1488437503.git.viresh.kumar@linaro.org>
 <639aad743bac7f3292146738f44dbd1480169c8e.1488437503.git.viresh.kumar@linaro.org>
 <1772276.4tCnP8C0XV@aspire.rjw.lan>
 <1668614.4zDQWLsnmH@aspire.rjw.lan>
 <20170306044553.GE8206@vireshk-i7>
 <CAJZ5v0hov8Lz_MK9dxP9MyqSmPNRfWV9Wia4DtAZtOPmoTOqAw@mail.gmail.com>
 <20170307103108.GA4526@vireshk-i7>
 <CAJZ5v0itZo-tybgz2p49VxkGzFL9EZBB-4aZg6R5sthVrBiAYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f53.google.com ([74.125.83.53]:32798 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756650AbdCHETt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Mar 2017 23:19:49 -0500
Received: by mail-pg0-f53.google.com with SMTP id 25so8432758pgy.0
        for <linux-pm@vger.kernel.org>; Tue, 07 Mar 2017 20:18:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAJZ5v0itZo-tybgz2p49VxkGzFL9EZBB-4aZg6R5sthVrBiAYQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>

On 07-03-17, 14:19, Rafael J. Wysocki wrote:
> On Tue, Mar 7, 2017 at 11:31 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > Why do you think so? I thought all CPU in the policy can have the RT/DL flag set
> > and the probability of all of them is just the same.
> 
> Well, yes, but if the current CPU has that flag set already, we surely
> don't need to check the other ones in the policy?

That's true for every other CPU in policy too..

> >> So to the point, the code was written this way on purpose and not just
> >> by accident as your changelog suggests and
> >
> > I didn't wanted to convey that really and I knew that it was written on purpose.
> >
> >> if you want to change it, you need numbers.
> >
> > What kind of numbers can we get for such a change ? I tried to take the running
> > average of the time it takes to execute this routine over 10000 samples, but it
> > varies a lot even with the same build. Any tests like hackbench, etc wouldn't be
> > of any help as well.
> 
> So why do you think it needs to be changed, but really?
> 
> Is that because it is particularly hard to follow or similar?

Just that I didn't like keeping the same code at two places (outside
and inside the loop) and the benefit it has.

Anyway, its not straight forward to get any numbers supporting my
argument. I can claim improvement only theoretically by comparing the
number of comparisons that we may end up doing for quad or octa core
policies. Lets abandon this patch as I failed to convince you :)

Thanks for applying the other two patches though.

Cheers.

-- 
viresh
