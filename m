From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3 10/10] cpufreq: governor: Drop cpu argument from
 dbs_check_cpu()
Date: Sun, 7 Feb 2016 15:02:38 +0530
Message-ID: <20160207093238.GD19059@vireshk>
References: <3705929.bslqXH980s@vostro.rjw.lan>
 <9008098.QDD8C89zDx@vostro.rjw.lan>
 <2367498.ClbHvSsNAg@vostro.rjw.lan>
 <3908268.r5qEEZP0qG@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178]:34668 "EHLO
	mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753453AbcBGJcm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 7 Feb 2016 04:32:42 -0500
Received: by mail-pf0-f178.google.com with SMTP id o185so93492114pfb.1
        for <linux-pm@vger.kernel.org>; Sun, 07 Feb 2016 01:32:42 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <3908268.r5qEEZP0qG@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, Saravana Kannan <skannan@codeaurora.org>

On 06-02-16, 13:50, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Since policy->cpu is always passed as the second argument to
> dbs_check_cpu(), it is not really necessary to pass it, because
> the function can obtain that value via its first argument just fine.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> Changes from v2:
> - Rebase on top of https://patchwork.kernel.org/patch/8241231/
>   and on the v3 of [8/10] without [9/10].

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
