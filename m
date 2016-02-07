From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/3] cpufreq: governor: Simplify cpufreq_governor_limits()
Date: Sun, 7 Feb 2016 21:10:24 +0530
Message-ID: <20160207154024.GF3808@vireshk>
References: <3705929.bslqXH980s@vostro.rjw.lan>
 <9008098.QDD8C89zDx@vostro.rjw.lan>
 <2998470.K7oslgfuja@vostro.rjw.lan>
 <1465939.LaiBibfCQO@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33774 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753902AbcBGPk2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 7 Feb 2016 10:40:28 -0500
Received: by mail-pa0-f53.google.com with SMTP id cy9so60628516pac.0
        for <linux-pm@vger.kernel.org>; Sun, 07 Feb 2016 07:40:28 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1465939.LaiBibfCQO@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, Saravana Kannan <skannan@codeaurora.org>

On 07-02-16, 16:23, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Use the observation that cpufreq_governor_limits() doesn't have to
> get to the policy object it wants to manipulate by walking the
> reference chain cdbs->policy_dbs->policy, as the final pointer is
> actually equal to its argument, and make it access the policy
> object directy via its argument.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq_governor.c |   17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)

Why the hell did we write it that way earlier ? :)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
