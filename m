From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: use last policy after online
Date: Wed, 2 Dec 2015 08:24:32 +0530
Message-ID: <20151202025432.GI4459@ubuntu>
References: <1449017534-6127-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <3188790.ma3TNFyjuZ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36540 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752494AbbLBCyg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 1 Dec 2015 21:54:36 -0500
Received: by pacdm15 with SMTP id dm15so25184202pac.3
        for <linux-pm@vger.kernel.org>; Tue, 01 Dec 2015 18:54:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <3188790.ma3TNFyjuZ@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, rafael.j.wysocki@intel.com, linux-pm@vger.kernel.org

On 02-12-15, 03:05, Rafael J. Wysocki wrote:
> On Tuesday, December 01, 2015 04:52:14 PM Srinivas Pandruvada wrote:
> > For cpufreq drivers which use setpolicy interface, after offline->online
> > the policy is set to default. This can be reproduced by setting the
> > default policy of intel_pstate or longrun to ondemand and then change to
> > "performance". After offline and online, the setpolicy will be called with
> > the policy=ondemand.
> > For drivers using governors this condition is handled by storing
> > last_governor, during offline and restoring during online. The same should
> > be done for drivers using setpolicy interface. Storing last_policy during
> > offline and restoring during online.
> > 
> > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> 
> I guess this is urgent, right?
> 
> Is it a regression fix or has it just never worked?

I tried to look at history and I am not sure if it worked earlier or
not.

-- 
viresh
