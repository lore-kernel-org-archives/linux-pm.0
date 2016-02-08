From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V3 00/13] cpufreq: governors: Fix ABBA lockups
Date: Mon, 8 Feb 2016 18:24:59 +0530
Message-ID: <20160208125459.GG8294@vireshk>
References: <cover.1454931188.git.viresh.kumar@linaro.org>
 <56B88F4D.2030307@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:36751 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750866AbcBHMzD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 8 Feb 2016 07:55:03 -0500
Received: by mail-pa0-f42.google.com with SMTP id yy13so73372245pab.3
        for <linux-pm@vger.kernel.org>; Mon, 08 Feb 2016 04:55:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <56B88F4D.2030307@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, juri.lelli@arm.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, skannan@codeaurora.org, peterz@infradead.org, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org

On 08-02-16, 18:21, Shilpasri G Bhat wrote:
> Hi,
> 
> On 02/08/2016 05:09 PM, Viresh Kumar wrote:
> > Hi Rafael,
> > 
> > Things look much much better now. I have rebased this series over
> > pm/bleeding-edge, that has all your patches.
> > 
> > I have moved ahead and done few more changes in this series, that should
> > get rid of all the lockdeps we were getting earlier, that includes
> > fixing lockdep issue in update_sampling_rate() that we were chasing.
> > 
> > These are pushed here again:
> > git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git cpufreq/governor-kobject
> > 
> > @Juri/Shilpa: Can you please confirm if all the issues got resolved now
> > ?
> 
> I have tested this patchset on Power8 box and did not find any lockdep warnings.

Awesome news Shilpa. Thanks a lot for helping us out :)

-- 
viresh
