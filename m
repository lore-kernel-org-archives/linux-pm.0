From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V3 5/5] cpufreq: postfix policy directory with the first
 CPU in related_cpus
Date: Sat, 17 Oct 2015 09:59:07 +0530
Message-ID: <20151017042907.GA19018@linux>
References: <20151016070842.GY19018@linux>
 <44a5b86d1df41812461630e5a7c5366d276e2855.1444979341.git.viresh.kumar@linaro.org>
 <56215512.1080401@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:36227 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750950AbbJQE3N (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 17 Oct 2015 00:29:13 -0400
Received: by pacfv9 with SMTP id fv9so40129778pac.3
        for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2015 21:29:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <56215512.1080401@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Saravana Kannan <skannan@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>

On 16-10-15, 12:50, Saravana Kannan wrote:
> In the lines that follow this code we set the
> per_cpu(cpufreq_cpu_data) to point to the new policy. But if the
> subsequent cpu->get() fails, we goto out_exit_policy. But that label
> doesn't clean up the per_cpu(cpufreq_cpu_data). So, I think we need
> another label to jump to if ->get() fails

We call cpufreq_policy_free() in that case and that does the cleanup
you are talking about.

-- 
viresh
