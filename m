From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 1/7] cpufreq: governor: Treat min_sampling_rate as a
 governor-specific tunable
Date: Fri, 5 Feb 2016 08:17:13 +0530
Message-ID: <20160205024713.GC3068@vireshk>
References: <cover.1454507872.git.viresh.kumar@linaro.org>
 <92be8bede3340aa93549b468528f60244fbc50f2.1454507872.git.viresh.kumar@linaro.org>
 <5894332.OlEanUAMuU@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:34819 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751006AbcBECrQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Feb 2016 21:47:16 -0500
Received: by mail-pf0-f179.google.com with SMTP id 65so60485322pfd.2
        for <linux-pm@vger.kernel.org>; Thu, 04 Feb 2016 18:47:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <5894332.OlEanUAMuU@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: juri.lelli@arm.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, skannan@codeaurora.org, peterz@infradead.org, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org

On 05-02-16, 03:31, Rafael J. Wysocki wrote:
> I'm having some second thoughts about the utility of this patch to be honest.
> 
> I actually would like to move some tunables in the opposite direction.  That is,
> from struct od_dbs_tuners and struct cs_dbs_tuners to struct dbs_data.  The
> tuners field in that will then become something like gov_tunables (in analogy
> with gov_ops in struct common_dbs_data) and it will point to governor-specific
> tunables.
> 
> The reason why I'd like to do that is to make it easier to get rid of the
> super-ugly governor == GOV_CONSERVATIVE etc tests in the common code.
> 
> Also I think that governor-specific tunables should be defined in the .c file
> for that governor rather than in the common header.
> 
> We will need two set of macros for their sysfs attributes then, but that's
> not a big deal IMO.

I agree with that, no issues from my side.

But, this patch was actually required to kill the ugly macros. So, if
we are planning to take this series as is, then maybe we can keep it
for now and fix everything together with your patches :)

-- 
viresh
