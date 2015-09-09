From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2 3/9] cpufreq: ondemand: only queue canceled works from update_sampling_rate()
Date: Wed, 09 Sep 2015 03:06:39 +0200
Message-ID: <32794142.WpJFa6Ni1D@vostro.rjw.lan>
References: <cover.1437999691.git.viresh.kumar@linaro.org> <1806697.T1XSqGqSN5@vostro.rjw.lan> <20150908015831.GY26760@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:50283 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752627AbbIIAit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 8 Sep 2015 20:38:49 -0400
In-Reply-To: <20150908015831.GY26760@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, preeti.lkml@gmail.com, open list <linux-kernel@vger.kernel.org>

On Tuesday, September 08, 2015 07:28:31 AM Viresh Kumar wrote:
> On 08-09-15, 03:11, Rafael J. Wysocki wrote:
> > There really are two cases, either you pass a CPU or gov_queue_work() has to
> > walk policy->cpus.
> 
> Right (At least for now, we are doing just that.)
> 
> > Doing it the way you did hides that IMO.
> 
> Maybe. But I see it otherwise. Adding special meaning to a variable
> (like int cpu == -1 being the special case to specify policy->cpus)
> hides things morei, as we need to look at how it is decoded finally in
> the routine gov_queue_work().

Oh well.

I've just realized that if you combined this patch with the [6/9],
you wouldn't need to make any changes to gov_queue_work() at all,
because that patch removes the case in point entirely.

Thanks,
Rafael

