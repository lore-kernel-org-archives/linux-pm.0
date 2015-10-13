From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 4/5] cpufreq: create cpu/cpufreq/policyX directories
Date: Tue, 13 Oct 2015 11:45:34 +0530
Message-ID: <20151013061534.GU5386@linux>
References: <cover.1444583718.git.viresh.kumar@linaro.org>
 <dd7e6cab3e879e94305c0fca1ea6033e79d166ca.1444583718.git.viresh.kumar@linaro.org>
 <561C0A8B.5010509@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33525 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751449AbbJMGQI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 13 Oct 2015 02:16:08 -0400
Received: by pabrc13 with SMTP id rc13so11305855pab.0
        for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2015 23:16:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <561C0A8B.5010509@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Saravana Kannan <skannan@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>

On 12-10-15, 12:31, Saravana Kannan wrote:
> Can we use the first CPU in the related CPUs mask? Instead of the
> first CPU that the policy got created on? The policyX numbering
> would be a bit more consistent that way.

Okay, checked this again. The problem is that ->init() isn't called
yet and we are very early in the initialization sequence. So, we can't
really know related_cpus yet. So I will keep it unchanged for now.

-- 
viresh
