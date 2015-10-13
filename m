From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH 4/5] cpufreq: create cpu/cpufreq/policyX directories
Date: Tue, 13 Oct 2015 12:29:09 -0700
Message-ID: <561D5B85.4010103@codeaurora.org>
References: <cover.1444583718.git.viresh.kumar@linaro.org> <dd7e6cab3e879e94305c0fca1ea6033e79d166ca.1444583718.git.viresh.kumar@linaro.org> <561C0A8B.5010509@codeaurora.org> <20151013033912.GN5386@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:39082 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752156AbbJMT3L (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 13 Oct 2015 15:29:11 -0400
In-Reply-To: <20151013033912.GN5386@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>

On 10/12/2015 08:39 PM, Viresh Kumar wrote:
> On 12-10-15, 12:31, Saravana Kannan wrote:
>> Can we use the first CPU in the related CPUs mask? Instead of the
>> first CPU that the policy got created on? The policyX numbering
>> would be a bit more consistent that way.
>
> Okay..
>
>> Suggested-by: ?
>
> Will add. Though me/Rafael thought about it long back, but then
> dropped the idea :)
>
>> Didn't notice when this got added. Do we really need this anymore if
>> we don't care about moving the directory and creating symlinks? I
>> don't think we need it anymore. And if we really need to know
>> related - offline, we can use for_each_cpu_and(related,
>> online/present mask)
>
> Its about tracking present-cpus, for which the link is present. So, it
> is still required.

But we don't need to track track of "present-cpus" separately though. We 
could do the for_each_cpu_and() when we create the symlinks for the 
first time. And after that, we can just use the subsystem interface 
callbacks (cpufreq_add_dev() and cpufreq_remove_dev()) to keep the 
symlinks updated.

I don't see any place where keeping track of this separately is more 
efficient. This would save some memory savings when the number of CPUs 
is large and also simplify the code because we won't have to keep 
another field up to date.

-Saravana

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
