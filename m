From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC PATCH 11/19] cpufreq: assert policy->rwsem is held in
 __cpufreq_governor
Date: Wed, 3 Feb 2016 10:32:56 +0530
Message-ID: <20160203050256.GQ31828@vireshk>
References: <20160112102025.GC1084@ubuntu>
 <56AC04E3.8090900@codeaurora.org>
 <1703921.2AHaiQoggk@vostro.rjw.lan>
 <20160201060943.GH13476@vireshk>
 <CAJZ5v0gzKkoKsbv_KG0qL-7=j4a3DU-nOTCG71fZcoumQ0UZUw@mail.gmail.com>
 <56AFBEE5.70501@codeaurora.org>
 <20160202063449.GF31828@vireshk>
 <56B12191.8020407@codeaurora.org>
 <20160203021359.GL31828@vireshk>
 <56B17C56.1030504@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:34056 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750821AbcBCFDA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Feb 2016 00:03:00 -0500
Received: by mail-pf0-f174.google.com with SMTP id o185so7029975pfb.1
        for <linux-pm@vger.kernel.org>; Tue, 02 Feb 2016 21:03:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <56B17C56.1030504@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Saravana Kannan <skannan@codeaurora.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Juri Lelli <juri.lelli@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Michael Turquette <mturquette@baylibre.com>, Steve Muckle <steve.muckle@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, dietmar.eggemann@arm.com

On 02-02-16, 20:04, Saravana Kannan wrote:
> What's the s_active lock in CPU1 coming from?

That's taken by sysfs core while removing the files.

> The only reason it's there
> today is because of the sysfs dir remove. If you move it before the
> policy->rwsem, you won't have it after the policy->rwsem too. So, I think it
> will fix the issue.

Its complex and we will end up making ugly..

For example, EXIT can be called while switching governors. The
policy->rwsem is taken at the beginning cpufreq_set_policy(). To
decide if we should remove the governor sysfs directory so early (i.e.
before taking rwsem) in the call, is going to be difficult.

Over that the same directory might be shared across multiple policies,
and all that information is present only with the governor-core.

-- 
viresh
