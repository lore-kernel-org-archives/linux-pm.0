From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V3 00/13] cpufreq: governors: Fix ABBA lockups
Date: Mon, 8 Feb 2016 22:25:13 +0530
Message-ID: <20160208165512.GS8294@vireshk>
References: <cover.1454931188.git.viresh.kumar@linaro.org>
 <56B88F4D.2030307@linux.vnet.ibm.com>
 <20160208125459.GG8294@vireshk>
 <20160208163904.GN11415@e106622-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:33475 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751185AbcBHQzR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 8 Feb 2016 11:55:17 -0500
Received: by mail-pf0-f179.google.com with SMTP id q63so8552870pfb.0
        for <linux-pm@vger.kernel.org>; Mon, 08 Feb 2016 08:55:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160208163904.GN11415@e106622-lin>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, skannan@codeaurora.org, peterz@infradead.org, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org

On 08-02-16, 16:39, Juri Lelli wrote:
> Hi,
> 
> On 08/02/16 18:24, Viresh Kumar wrote:
> > On 08-02-16, 18:21, Shilpasri G Bhat wrote:
> > > Hi,
> > > 
> > > On 02/08/2016 05:09 PM, Viresh Kumar wrote:
> > > > Hi Rafael,
> > > > 
> > > > Things look much much better now. I have rebased this series over
> > > > pm/bleeding-edge, that has all your patches.
> > > > 
> > > > I have moved ahead and done few more changes in this series, that should
> > > > get rid of all the lockdeps we were getting earlier, that includes
> > > > fixing lockdep issue in update_sampling_rate() that we were chasing.
> > > > 
> > > > These are pushed here again:
> > > > git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git cpufreq/governor-kobject
> > > > 
> > > > @Juri/Shilpa: Can you please confirm if all the issues got resolved now
> > > > ?
> > > 
> > > I have tested this patchset on Power8 box and did not find any lockdep warnings.
> > 
> 
> Everything looks good on TC2/Juno as well :).

Yeah, we finally solved the puzzle :)

-- 
viresh
