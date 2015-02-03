From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH 04/18] cpufreq: Manage fallback policies in a list
Date: Tue, 03 Feb 2015 14:28:11 -0800
Message-ID: <54D14B7B.8040307@codeaurora.org>
References: <cover.1422346933.git.viresh.kumar@linaro.org> <43d728016b775d1b0fc02c981eb0520ac08297f5.1422346933.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.11.231]:42851 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752601AbbBCW2M (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 3 Feb 2015 17:28:12 -0500
In-Reply-To: <43d728016b775d1b0fc02c981eb0520ac08297f5.1422346933.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, prarit@redhat.com

On 01/27/2015 12:36 AM, Viresh Kumar wrote:
> Policies manage a group of CPUs and tracking them on per-cpu basis isn't the
> best approach for sure.
>
> The obvious loss is the amount of memory consumed for keeping a per-cpu copy of
> the same pointer. But the bigger problem is managing such a data structure as we
> need to update it for all policy->cpus.
>
> To make it simple, lets manage fallback CPUs in a list rather than a per-cpu
> variable.

Can you explain why we need a fallback list in the first place? Now that 
we are not destroying and creating policy objects, I don't see any point 
in the fallback list.

-Saravana

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
