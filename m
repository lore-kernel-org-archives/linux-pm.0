From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH 10/18] cpufreq: Don't allow updating inactive-policies
 from sysfs
Date: Wed, 11 Feb 2015 19:24:29 -0800
Message-ID: <54DC1CED.2060906@codeaurora.org>
References: <cover.1422346933.git.viresh.kumar@linaro.org> <935ec6b1fe24e17a95c71cfb01ea1bf27d03a5d5.1422346933.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:60553 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754689AbbBLDYf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 11 Feb 2015 22:24:35 -0500
In-Reply-To: <935ec6b1fe24e17a95c71cfb01ea1bf27d03a5d5.1422346933.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, prarit@redhat.com

On 01/27/2015 12:36 AM, Viresh Kumar wrote:
> Later commits would change the way policies are managed today. Policies wouldn't
> be freed on cpu hotplug (currently they aren't freed on suspend), and while the
> CPU is offline, the sysfs cpufreq files would still be present.
>
> User may accidentally try to update the sysfs files in following directory:
> '/sys/devices/system/cpu/cpuX/cpufreq/'. And that would result in undefined
> behavior as policy wouldn't be active then.
>
> To disallow such accesses, sense if a policy is active or not while doing such
> operations. This can be done easily by getting the policy again with
> cpufreq_cpu_get_raw(), as that would traverse the list of active policies.
>
> Apart from updating the store() routine, we also update __cpufreq_get() which
> can call cpufreq_out_of_sync(). The later routine tries to update policy->cur
> and start notifying kernel about it.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

I'm okay with the idea of this patch for now. I'll argue against this 
after this series goes in as it'll need more non-trivial changes before 
this idea of this patch can be removed.

But not acking it because I expect the code to change after combining 
active/inactive list.

-Saravana

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
