From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 4/5] cpufreq: create cpu/cpufreq/policyX directories
Date: Tue, 13 Oct 2015 09:09:12 +0530
Message-ID: <20151013033912.GN5386@linux>
References: <cover.1444583718.git.viresh.kumar@linaro.org>
 <dd7e6cab3e879e94305c0fca1ea6033e79d166ca.1444583718.git.viresh.kumar@linaro.org>
 <561C0A8B.5010509@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:34780 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932340AbbJMDjk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 12 Oct 2015 23:39:40 -0400
Received: by padhy16 with SMTP id hy16so7181191pad.1
        for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2015 20:39:39 -0700 (PDT)
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

Okay..

> Suggested-by: ?

Will add. Though me/Rafael thought about it long back, but then
dropped the idea :)

> Didn't notice when this got added. Do we really need this anymore if
> we don't care about moving the directory and creating symlinks? I
> don't think we need it anymore. And if we really need to know
> related - offline, we can use for_each_cpu_and(related,
> online/present mask)

Its about tracking present-cpus, for which the link is present. So, it
is still required.

-- 
viresh
