From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH 4/5] cpufreq: create cpu/cpufreq/policyX directories
Date: Tue, 13 Oct 2015 12:25:17 -0700
Message-ID: <561D5A9D.1070003@codeaurora.org>
References: <cover.1444583718.git.viresh.kumar@linaro.org> <dd7e6cab3e879e94305c0fca1ea6033e79d166ca.1444583718.git.viresh.kumar@linaro.org> <561C0A8B.5010509@codeaurora.org> <20151013061534.GU5386@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:38709 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752446AbbJMTZT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 13 Oct 2015 15:25:19 -0400
In-Reply-To: <20151013061534.GU5386@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>

On 10/12/2015 11:15 PM, Viresh Kumar wrote:
> On 12-10-15, 12:31, Saravana Kannan wrote:
>> Can we use the first CPU in the related CPUs mask? Instead of the
>> first CPU that the policy got created on? The policyX numbering
>> would be a bit more consistent that way.
>
> Okay, checked this again. The problem is that ->init() isn't called
> yet and we are very early in the initialization sequence. So, we can't
> really know related_cpus yet. So I will keep it unchanged for now.
>

Can we move the sysfs add to the end so that by the time we add sysfs, 
we'll have all the details?

-Saravana

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
