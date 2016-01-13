From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC PATCH 06/19] cpufreq: always access cpufreq_policy_list
 while holding cpufreq_driver_lock
Date: Wed, 13 Jan 2016 11:31:59 +0530
Message-ID: <20160113060159.GH6050@ubuntu>
References: <1452533760-13787-1-git-send-email-juri.lelli@arm.com>
 <1452533760-13787-7-git-send-email-juri.lelli@arm.com>
 <20160112095740.GX1084@ubuntu>
 <20160112120803.GC7015@e106622-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f171.google.com ([209.85.192.171]:36298 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752490AbcAMGCD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 13 Jan 2016 01:02:03 -0500
Received: by mail-pf0-f171.google.com with SMTP id n128so75493099pfn.3
        for <linux-pm@vger.kernel.org>; Tue, 12 Jan 2016 22:02:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160112120803.GC7015@e106622-lin>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, peterz@infradead.org, rjw@rjwysocki.net, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com

On 12-01-16, 12:08, Juri Lelli wrote:
> I currently don't have any branch fetched by Fengguang's bot; I'll see
> how to start doing that. In the meantime I'll try to setup an x86 box
> and run some more tests.

Perhaps, just create a new tree (that you always want to be tested by
the Bot) and push your branch there. And then ask Fengguang ((In)formal
email to: fengguang.wu@intel.com) to add your tree. He is very fast :)

> I was thinking hotplug can get in the way, but we are inside a
> {get,put}_online_cpus block. I'll remove that.

Exactly.

-- 
viresh
