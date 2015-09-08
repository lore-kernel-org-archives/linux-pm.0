From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 6/9] cpufreq: ondemand: queue work for policy->cpus
 together
Date: Tue, 8 Sep 2015 07:43:09 +0530
Message-ID: <20150908021309.GC26760@linux>
References: <cover.1437999691.git.viresh.kumar@linaro.org>
 <d2760eca0b3fd5e427d004120bdb82c1aed215ca.1437999691.git.viresh.kumar@linaro.org>
 <2662457.Ri7bTTTVA1@vostro.rjw.lan>
 <20150908021101.GA26760@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:36763 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751952AbbIHCNO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 7 Sep 2015 22:13:14 -0400
Received: by padhk3 with SMTP id hk3so24659566pad.3
        for <linux-pm@vger.kernel.org>; Mon, 07 Sep 2015 19:13:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150908021101.GA26760@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, preeti.lkml@gmail.com, open list <linux-kernel@vger.kernel.org>

On 08-09-15, 07:41, Viresh Kumar wrote:
> > >  		next_sampling = jiffies + usecs_to_jiffies(new_rate);
> > >  		appointed_at = dbs_info->cdbs.dwork.timer.expires;
> > 
> > For that to work we always need to do stuff for policy->cpus in sync.
> > Do we?
> 
> Hmm, we are not in 100% sync for sure. Will check that again.

On the other hand, if we decide to apply 7/9 as well, then this is
anyway going to get removed :)

-- 
viresh
