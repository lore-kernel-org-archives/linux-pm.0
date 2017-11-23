From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/4] cpufreq: Clean up cpufreq_parse_governor()
Date: Thu, 23 Nov 2017 09:25:35 +0530
Message-ID: <20171123035535.GC4084@vireshk-i7>
References: <1655574.Es7zYAeW1r@aspire.rjw.lan>
 <1657366.eeJssZH0Uk@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:44158 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752017AbdKWDzk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Nov 2017 22:55:40 -0500
Received: by mail-pg0-f67.google.com with SMTP id c123so13469657pga.11
        for <linux-pm@vger.kernel.org>; Wed, 22 Nov 2017 19:55:39 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1657366.eeJssZH0Uk@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

On 23-11-17, 01:23, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Drop an unnecessary local variable from cpufreq_parse_governor()
> and rearrange the code in there to make it easier to follow.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq.c |   32 +++++++++++++++++---------------
>  1 file changed, 17 insertions(+), 15 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
