From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC PATCH 11/19] cpufreq: assert policy->rwsem is held in
 __cpufreq_governor
Date: Wed, 3 Feb 2016 07:43:59 +0530
Message-ID: <20160203021359.GL31828@vireshk>
References: <1452533760-13787-1-git-send-email-juri.lelli@arm.com>
 <20160112102025.GC1084@ubuntu>
 <56AC04E3.8090900@codeaurora.org>
 <1703921.2AHaiQoggk@vostro.rjw.lan>
 <20160201060943.GH13476@vireshk>
 <CAJZ5v0gzKkoKsbv_KG0qL-7=j4a3DU-nOTCG71fZcoumQ0UZUw@mail.gmail.com>
 <56AFBEE5.70501@codeaurora.org>
 <20160202063449.GF31828@vireshk>
 <56B12191.8020407@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56B12191.8020407@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Saravana Kannan <skannan@codeaurora.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Juri Lelli <juri.lelli@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Michael Turquette <mturquette@baylibre.com>, Steve Muckle <steve.muckle@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, dietmar.eggemann@arm.com
List-Id: linux-pm@vger.kernel.org

On 02-02-16, 13:37, Saravana Kannan wrote:
> On 02/01/2016 10:34 PM, Viresh Kumar wrote:
> >What will that solve? It will stay exactly same then as well, as we
> >would be adding/removing these attributes from within the same
> >policy->rwsem ..
> 
> The problem isn't that you are holding the policy rwsem. The problem is that
> we are trying to grab the same locks in different order. This is trying to
> fix that.

That's exactly what I was trying to say, sorry for not being very
clear.

Even if you would move the sysfs file creation thing into the cpufreq
core, instead of governor, we will have locks this way:

CPU0                            CPU1
(sysfs read)                    (sysfs dir remove)
s_active lock                   policy->rwsem
policy->rwsem
                                s_active lock (hang)


And so I said, nothing will change.

-- 
viresh
