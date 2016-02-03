From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH V2 5/7] cpufreq: Merge cpufreq_offline_prepare/finish
 routines
Date: Wed, 03 Feb 2016 12:21:40 -0800
Message-ID: <56B26154.9010000@codeaurora.org>
References: <cover.1454507872.git.viresh.kumar@linaro.org> <5e84719b5475f79602e95af524e66e8927a85bc9.1454507872.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:52663 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751859AbcBCUVn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Feb 2016 15:21:43 -0500
In-Reply-To: <5e84719b5475f79602e95af524e66e8927a85bc9.1454507872.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, juri.lelli@arm.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, peterz@infradead.org, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org

On 02/03/2016 06:02 AM, Viresh Kumar wrote:
> The offline routine was separated into two halves earlier by
> 'commit 1aee40ac9c86 ("cpufreq: Invoke __cpufreq_remove_dev_finish()
> after releasing cpu_hotplug.lock");.
>
> And the reasons cited were, race issues between accessing policy's sysfs
> files and policy kobject's cleanup.
>
> That race isn't valid anymore, as we don't remove the policy & its
> kobject completely on hotplugs, but do that from ->remove() callback of
> subsys framework.
>
> These two routines can be merged back now.
>
> This is a preparatory step for the next patch, that will enforce
> policy->rwsem lock around __cpufreq_governor() routines STOP/EXIT
> sequence.

Is this stale text? Seems like this is now done in the *previous* patch?

-Saravana


-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
