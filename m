From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Skip all governor-related actions for
 cpufreq_suspended set
Date: Fri, 8 Apr 2016 11:15:13 +0530
Message-ID: <20160408054513.GF9674@vireshk-i7>
References: <2044559.GVlD7a2JcO@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:36820 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750758AbcDHFpj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 8 Apr 2016 01:45:39 -0400
Received: by mail-pf0-f180.google.com with SMTP id e128so69800728pfe.3
        for <linux-pm@vger.kernel.org>; Thu, 07 Apr 2016 22:45:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <2044559.GVlD7a2JcO@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

On 07-04-16, 03:29, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Since governor operations are generally skipped if cpufreq_suspended
> is set, do nothing at all in cpufreq_start_governor() and
> cpufreq_exit_governor() in that case.
> 
> In particular, this prevents fast frequency switching from being
> disabled after a suspend-to-RAM cycle on all CPUs except for the
> boot one.
> 
> Fixes: b7898fda5bc7 (cpufreq: Support for fast frequency switching)
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq.c |    6 ++++++
>  1 file changed, 6 insertions(+)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
