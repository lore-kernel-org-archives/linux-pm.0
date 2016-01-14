From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC PATCH 18/19] cpufreq: remove transition_lock
Date: Thu, 14 Jan 2016 16:02:21 +0530
Message-ID: <20160114103221.GB6078@vireshk>
References: <1452533760-13787-1-git-send-email-juri.lelli@arm.com>
 <1452533760-13787-19-git-send-email-juri.lelli@arm.com>
 <20160112112409.GJ1084@ubuntu>
 <20160113005452.10884.77606@quark.deferred.io>
 <20160113063148.GJ6050@ubuntu>
 <20160113182131.1168.45753@quark.deferred.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:33075 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753632AbcANKcY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 14 Jan 2016 05:32:24 -0500
Received: by mail-pa0-f45.google.com with SMTP id cy9so374983705pac.0
        for <linux-pm@vger.kernel.org>; Thu, 14 Jan 2016 02:32:24 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160113182131.1168.45753@quark.deferred.io>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>
Cc: Juri Lelli <juri.lelli@arm.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, peterz@infradead.org, rjw@rjwysocki.net, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com

On 13-01-16, 10:21, Michael Turquette wrote:
> Quoting Viresh Kumar (2016-01-12 22:31:48)
> > On 12-01-16, 16:54, Michael Turquette wrote:
> > > __cpufreq_driver_target should be using a per-policy lock.
> > 
> > It doesn't :)
> 
> It should.

I thought we wanted the routine doing DVFS to not sleep as it will be
called from scheduler ?

Looks fine otherwise. But yeah, the series is still incomplete in the
sense that there is no lock today around __cpufreq_driver_target().

-- 
viresh
