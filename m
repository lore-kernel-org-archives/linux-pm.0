From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 0/3] cpufreq: intel_pstate: trivial improvements
Date: Mon, 27 Jun 2016 15:13:00 +0530
Message-ID: <20160627094300.GB15437@vireshk-i7>
References: <1467019575-664-1-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:36265 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751609AbcF0JnE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jun 2016 05:43:04 -0400
Received: by mail-pf0-f176.google.com with SMTP id t190so60437650pfb.3
        for <linux-pm@vger.kernel.org>; Mon, 27 Jun 2016 02:43:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1467019575-664-1-git-send-email-jszhang@marvell.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jisheng Zhang <jszhang@marvell.com>
Cc: srinivas.pandruvada@linux.intel.com, lenb@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 27-06-16, 17:26, Jisheng Zhang wrote:
> The first patch fixes incorrect placement of __initdata
> 
> The second patch is to add __init/__initdata marker to some functions
> or varaiables so that we can discard them.
> 
> The third patch declares pid_params/pstate_funcs/hwp_active as
> __read_mostly, under the fact that they are mostly read and not
> written to.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
