From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH V2 12/20] cpufreq: Mark policy->governor = NULL for inactive
 policies
Date: Wed, 01 Apr 2015 21:38:58 -0700
Message-ID: <551CC7E2.6070806@codeaurora.org>
References: <cover.1424345053.git.viresh.kumar@linaro.org> <466c5246b6ad83b960eeb63ab34a04379448980d.1424345053.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:58983 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751209AbbDBEjA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 2 Apr 2015 00:39:00 -0400
In-Reply-To: <466c5246b6ad83b960eeb63ab34a04379448980d.1424345053.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, prarit@redhat.com

On 02/19/2015 03:32 AM, Viresh Kumar wrote:
> Later commits would change the way policies are managed today. Policies wouldn't
> be freed on cpu hotplug (currently they aren't freed on suspend), and while the
> CPU is offline, the sysfs cpufreq files would still be present.
>
> Because we don't mark policy->governor as NULL, it still contains pointer of the
> last governor it used. And when we read the 'scaling_governor' file, it shows
> the old value.

What's wrong with this behavior? If you cat scaling_min/max_freq, it's 
going to show the last minimum and maximum freqs too. I don't think this 
needs to be set to NULL until the governor is unloaded. Which you are 
already taking care of in the previous patch.

It's handy to be able to tell what governor will be restored when a 
cluster if offline.

Nacked because I think this patch is not helping.

-Saravana

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
