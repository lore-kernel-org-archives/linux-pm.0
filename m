From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH 00/18] cpufreq: don't loose cpufreq history on CPU hotplug
Date: Wed, 28 Jan 2015 11:35:09 -0800
Message-ID: <54C939ED.8090000@codeaurora.org>
References: <cover.1422346933.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.11.231]:42761 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753666AbbA1UMv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 28 Jan 2015 15:12:51 -0500
In-Reply-To: <cover.1422346933.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, prarit@redhat.com

On 01/27/2015 12:36 AM, Viresh Kumar wrote:

> @Saravana: Few patches might look very similar to what you have done, please add
> your SOB for those :)

@Viresh, thanks for taking up the patches and working on it. I wish I 
could have spent more time to get this in myself.

For the patches that are very similar to the ones I sent out, could you 
please leave the author as me? I spent quite some time figuring out the 
different corner cases and coding it up and don't want to completely 
lose authorship for the work I did. Would appreciate it if you could 
accommodate that.

I'll definitely review this. One thing that's not done in this patchset 
which I think should eventually be done (so, we should make sure we 
don't have any code that makes that harder to do in the future) is to 
allow setting the cpufreq parameters even when all the CPUs in the 
policy are offline. It's actually trivial for most of the parameters 
except a few governor specific tunables.

Thanks,
Saravana



-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
