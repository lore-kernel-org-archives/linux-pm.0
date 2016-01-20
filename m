From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC PATCH 15/19] cpufreq: remove useless usage of
 cpufreq_governor_mutex in __cpufreq_governor
Date: Wed, 20 Jan 2016 15:48:36 +0530
Message-ID: <20160120101836.GB18097@vireshk>
References: <1452533760-13787-1-git-send-email-juri.lelli@arm.com>
 <1452533760-13787-16-git-send-email-juri.lelli@arm.com>
 <20160112110658.GG1084@ubuntu>
 <20160115163031.GU18603@e106622-lin>
 <20160118055034.GC30762@vireshk>
 <20160119164941.GI8573@e106622-lin>
 <20160120072933.GF22443@vireshk>
 <20160120101724.GM8573@e106622-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:36451 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933423AbcATKSk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 Jan 2016 05:18:40 -0500
Received: by mail-pf0-f179.google.com with SMTP id n128so2542413pfn.3
        for <linux-pm@vger.kernel.org>; Wed, 20 Jan 2016 02:18:39 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160120101724.GM8573@e106622-lin>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, peterz@infradead.org, rjw@rjwysocki.net, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com

On 20-01-16, 10:17, Juri Lelli wrote:
> On 20/01/16 12:59, Viresh Kumar wrote:
> > On 19-01-16, 16:49, Juri Lelli wrote:
> > > I'm actually hitting this running sp2, on linux-pm/linux-next :/.
> > 
> > That's really bad .. Are you hitting this on Juno or x86 ?
> > 
> 
> That's on TC2. I'll try to run the same on Juno and x86.

Juno will be the same as that also set the per-policy-governor thing
:)

-- 
viresh
