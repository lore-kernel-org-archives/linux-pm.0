From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC PATCH] cpufreq/hotplug: Fix cpu-hotplug cpufreq race
 conditions
Date: Tue, 2 Jun 2015 11:09:56 +0530
Message-ID: <20150602053956.GD10443@linux>
References: <20150601064031.2972.59208.stgit@perfhull-ltc.austin.ibm.com>
 <20150601071934.GC4242@linux>
 <556D3FAA.3080703@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35879 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755150AbbFBFkB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 2 Jun 2015 01:40:01 -0400
Received: by pabqy3 with SMTP id qy3so4824959pab.3
        for <linux-pm@vger.kernel.org>; Mon, 01 Jun 2015 22:40:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <556D3FAA.3080703@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Cc: rjw@rjwysocki.net, ego@linux.vnet.ibm.com, paulus@samba.org, linux-kernel@vger.kernel.org, shilpa.bhat@linux.vnet.ibm.com, linux-pm@vger.kernel.org

On 02-06-15, 11:01, Preeti U Murthy wrote:
> How will a policy lock help here at all, when cpus from multiple
> policies are calling into __cpufreq_governor() ? How will a policy lock
> serialize their entry into cpufreq_governor_dbs() ?

So different policies don't really depend on each other. The only
thing common to them are the governor's sysfs files (only if
governor-per-policy isn't set, i.e. in your case). Those sysfs files
and their kernel counterpart variables aren't touched unless all the
policies have EXITED. All these START/STOP calls touch only the data
relevant to those policies only.

In case of per-policy  governors, even those sysfs files are separate
for each policy.

And so a policy lock should be sufficient, rest should be handled
within the governors with locks or whatever.

> > These band-aid wouldn't take us anywhere.
> 
> Why do you say that the approach mentioned in this patch is a bandaid ?
> The patch ensures that there are no interruptions in a logical sequence
> of calls into cpufreq_governor_dbs(), as it should be.

Because this happened as we are forced to drop the policy-locks.
That's the real problem. This whole thing should be performed under
locks, instead of setting variables to mark governor busy under locks.

-- 
viresh
