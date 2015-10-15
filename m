From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH 4/5] cpufreq: create cpu/cpufreq/policyX directories
Date: Thu, 15 Oct 2015 12:28:10 -0700
Message-ID: <561FFE4A.5070103@codeaurora.org>
References: <cover.1444583718.git.viresh.kumar@linaro.org> <dd7e6cab3e879e94305c0fca1ea6033e79d166ca.1444583718.git.viresh.kumar@linaro.org> <561C0A8B.5010509@codeaurora.org> <20151013033912.GN5386@linux> <561D5B85.4010103@codeaurora.org> <20151015065503.GB19018@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:49793 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751329AbbJOT2L (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 15 Oct 2015 15:28:11 -0400
In-Reply-To: <20151015065503.GB19018@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>

On 10/14/2015 11:55 PM, Viresh Kumar wrote:
> On 13-10-15, 12:29, Saravana Kannan wrote:
>> But we don't need to track track of "present-cpus" separately
>> though. We could do the for_each_cpu_and() when we create the
>> symlinks for the first time. And after that, we can just use the
>> subsystem interface callbacks (cpufreq_add_dev() and
>> cpufreq_remove_dev()) to keep the symlinks updated.
>>
>> I don't see any place where keeping track of this separately is more
>> efficient. This would save some memory savings when the number of
>> CPUs is large and also simplify the code because we won't have to
>> keep another field up to date.
>
> It is still required to track when can we free the policy.
>

Ok, I'm not very familiar with this new field's uses. I'll take a closer 
look later and respond if I have other thoughts.

Thanks,
Saravana

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
