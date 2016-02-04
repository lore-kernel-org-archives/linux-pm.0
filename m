From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 5/7] cpufreq: Merge cpufreq_offline_prepare/finish
 routines
Date: Thu, 4 Feb 2016 07:19:27 +0530
Message-ID: <20160204014927.GL3469@vireshk>
References: <cover.1454507872.git.viresh.kumar@linaro.org>
 <5e84719b5475f79602e95af524e66e8927a85bc9.1454507872.git.viresh.kumar@linaro.org>
 <56B26154.9010000@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:35294 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755002AbcBDBtb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Feb 2016 20:49:31 -0500
Received: by mail-pf0-f182.google.com with SMTP id 65so26187646pfd.2
        for <linux-pm@vger.kernel.org>; Wed, 03 Feb 2016 17:49:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <56B26154.9010000@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Saravana Kannan <skannan@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, juri.lelli@arm.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, peterz@infradead.org, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org

On 03-02-16, 12:21, Saravana Kannan wrote:
> On 02/03/2016 06:02 AM, Viresh Kumar wrote:
> >The offline routine was separated into two halves earlier by
> >'commit 1aee40ac9c86 ("cpufreq: Invoke __cpufreq_remove_dev_finish()
> >after releasing cpu_hotplug.lock");.
> >
> >And the reasons cited were, race issues between accessing policy's sysfs
> >files and policy kobject's cleanup.
> >
> >That race isn't valid anymore, as we don't remove the policy & its
> >kobject completely on hotplugs, but do that from ->remove() callback of
> >subsys framework.
> >
> >These two routines can be merged back now.
> >
> >This is a preparatory step for the next patch, that will enforce
> >policy->rwsem lock around __cpufreq_governor() routines STOP/EXIT
> >sequence.
> 
> Is this stale text? Seems like this is now done in the *previous* patch?

No, the previous patch has fixed a single location only. The next
patch tried to fix others as well.

-- 
viresh
