From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC PATCH 11/19] cpufreq: assert policy->rwsem is held in
 __cpufreq_governor
Date: Mon, 1 Feb 2016 11:39:43 +0530
Message-ID: <20160201060943.GH13476@vireshk>
References: <1452533760-13787-1-git-send-email-juri.lelli@arm.com>
 <20160112102025.GC1084@ubuntu>
 <56AC04E3.8090900@codeaurora.org>
 <1703921.2AHaiQoggk@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:33691 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750891AbcBAGJq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 1 Feb 2016 01:09:46 -0500
Received: by mail-pf0-f175.google.com with SMTP id x125so78167913pfb.0
        for <linux-pm@vger.kernel.org>; Sun, 31 Jan 2016 22:09:46 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1703921.2AHaiQoggk@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Saravana Kannan <skannan@codeaurora.org>, Juri Lelli <juri.lelli@arm.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, peterz@infradead.org, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com

On 30-01-16, 12:49, Rafael J. Wysocki wrote:
> On Friday, January 29, 2016 04:33:39 PM Saravana Kannan wrote:
> > AFAIR, the ABBA issue was between the sysfs lock and the policy lock. 

Yeah, to be precise here it is:

CPU0 (sysfs read)               CPU1 (exit governor)

sysfs-read                      set_policy()-> lock policy->rwsem
sysfs-active lock               Remove sysfs files
lock policy->rwsem              sysfs-active lock
Actual read

> > The fix for that issue should not be dropping the lock around 
> > POLICY_EXIT.
> 
> Right.  Dropping the lock is a mistake (which I overlooked, sadly).

I joined the party at around time of 3.10, and we had this problem and
hacky solution then as well. We tried to get rid of it multiple times,
but sadly failed.

> > The proper fix is to have the governor "export" the
> > attributes it wants to add/remove and have the cpufreq framework do
> > the adding/removing of the attributes from sysfs for the governor.

I failed to understand your solution, sorry. Care to explain this a
bit more?

-- 
viresh
