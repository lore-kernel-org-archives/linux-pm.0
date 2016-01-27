From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Fix NULL reference crash while accessing
 policy->governor_data
Date: Wed, 27 Jan 2016 08:42:00 +0530
Message-ID: <20160127031200.GI3322@vireshk>
References: <1297c8fc8135f8b5359f9c49d220a939c0ee640e.1453741314.git.viresh.kumar@linaro.org>
 <20160126095751.GJ10898@e106622-lin>
 <20160126180119.GK10898@e106622-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:32775 "EHLO
	mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751333AbcA0DME (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 26 Jan 2016 22:12:04 -0500
Received: by mail-pf0-f172.google.com with SMTP id x125so4357420pfb.0
        for <linux-pm@vger.kernel.org>; Tue, 26 Jan 2016 19:12:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160126180119.GK10898@e106622-lin>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, "# v4 . 2+" <stable@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

On 26-01-16, 18:01, Juri Lelli wrote:
> So, this goes away with your patch (that I forward ported) and a small
> additional fix on top of that. I pushed all that here (so that it is
> also tested by 0-day):

I am surprised :)

>  git://linux-arm.org/linux-jl.git fixes/cpufreq/policy_exit_race 
> 
> However, I can still see what below :/.

That's bad :(

-- 
viresh
