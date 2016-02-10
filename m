From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V4 6/6] cpufreq: governor: Create and traverse list of
 policy_dbs to fix lockdep
Date: Wed, 10 Feb 2016 10:46:05 +0530
Message-ID: <20160210051605.GO22111@vireshk>
References: <cover.1454988295.git.viresh.kumar@linaro.org>
 <4ad189a1cd04b05fbfd659ec81b4793a1c7b0189.1454988295.git.viresh.kumar@linaro.org>
 <1643885.vh1AZTynbP@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:35373 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751739AbcBJFQI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 10 Feb 2016 00:16:08 -0500
Received: by mail-pa0-f45.google.com with SMTP id ho8so5896158pac.2
        for <linux-pm@vger.kernel.org>; Tue, 09 Feb 2016 21:16:08 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1643885.vh1AZTynbP@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: juri.lelli@arm.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, skannan@codeaurora.org, peterz@infradead.org, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, shilpa.bhat@linux.vnet.ibm.com, linux-kernel@vger.kernel.org

On 09-02-16, 21:23, Rafael J. Wysocki wrote:
> > +	count = dbs_data->usage_count--;
> 
> This appears to be planting a bug.
> 
> The way you wrote it the decrementation will take place after the assignment, so
> count will contain the old value.

Oh crap, what was I smoking :)

-- 
viresh
