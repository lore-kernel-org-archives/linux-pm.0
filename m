From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 0/7] cpufreq: governors: Fix ABBA lockups
Date: Fri, 5 Feb 2016 08:19:26 +0530
Message-ID: <20160205024926.GD3068@vireshk>
References: <cover.1454507872.git.viresh.kumar@linaro.org>
 <20160203155428.GY3947@e106622-lin>
 <20160203161059.GH3469@vireshk>
 <20160204062439.GZ3469@vireshk>
 <20160204121727.GH3469@vireshk>
 <56B3B9B0.4010401@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34106 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751621AbcBECta (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Feb 2016 21:49:30 -0500
Received: by mail-pa0-f46.google.com with SMTP id uo6so26405066pac.1
        for <linux-pm@vger.kernel.org>; Thu, 04 Feb 2016 18:49:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <56B3B9B0.4010401@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: Juri Lelli <juri.lelli@arm.com>, Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, skannan@codeaurora.org, peterz@infradead.org, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org

On 05-02-16, 02:20, Shilpasri G Bhat wrote:
> I could see the previous lockdep warnings on pm/next and on top of patch[4].
> On Patch[5-7] I see the below lockdep trace on running './runme' on a Power8 box.

> [  710.336130] Chain exists of:
>   s_active#91 --> &dbs_data->mutex --> od_dbs_cdata.mutex
> 
> [  710.336376]  Possible unsafe locking scenario:
> 
> [  710.336488]        CPU0                    CPU1
> [  710.336577]        ----                    ----
> [  710.336666]   lock(od_dbs_cdata.mutex);
> [  710.336778]                                lock(&dbs_data->mutex);
> [  710.336911]                                lock(od_dbs_cdata.mutex);
> [  710.337064]   lock(s_active#91);
> [  710.337176]

This is the same lockdep, just that we have added another mutex
(dbs_data->mutex) to it.

Have you tried if all the lockdeps go away with the 8th patch that I
provided yesterday ?

-- 
viresh
