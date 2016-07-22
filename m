From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2] cpufreq: Disallow ->resolve_freq() for drivers
 providing ->target_index()
Date: Fri, 22 Jul 2016 14:09:19 -0700
Message-ID: <20160722210919.GC3122@ubuntu>
References: <065301260510fbca81f5481b27b0de956073068a.1469137133.git.viresh.kumar@linaro.org>
 <20160722003405.GZ27987@graphite.smuckle.net>
 <20160722151327.GP3122@ubuntu>
 <1635689.iZWBWcBJ5f@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f170.google.com ([209.85.192.170]:36710 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751251AbcGVVJV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 Jul 2016 17:09:21 -0400
Received: by mail-pf0-f170.google.com with SMTP id h186so44633656pfg.3
        for <linux-pm@vger.kernel.org>; Fri, 22 Jul 2016 14:09:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1635689.iZWBWcBJ5f@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Steve Muckle <steve.muckle@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>

On 22-07-16, 23:11, Rafael J. Wysocki wrote:
> No, they aren't deprecated, not even sort of.
> 
> Of course, stuff that can use frequency tables should implement ->target_index,
> because there's no valid reason for it not to do that.
> 
> However, there are cases (and not legacy) where frequency tables are simply
> impractical and those drivers have no choice but to implement ->target.
> 
> And if you want to try to force them into the frequency tables model
> regardless, then think twice, because I'm not going to let you do that.

No I am not :)

Perhaps this was just mis-worded in the Documentation then.

-- 
viresh
