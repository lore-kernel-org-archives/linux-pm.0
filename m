From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 3/3] cpufreq: governor: Symmetrize cpu_dbs_info
 initialization and cleanup
Date: Sun, 7 Feb 2016 21:22:00 +0530
Message-ID: <20160207155200.GH3808@vireshk>
References: <3705929.bslqXH980s@vostro.rjw.lan>
 <9008098.QDD8C89zDx@vostro.rjw.lan>
 <2998470.K7oslgfuja@vostro.rjw.lan>
 <3371031.KKUQAzJ7qu@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:34602 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753354AbcBGPwF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 7 Feb 2016 10:52:05 -0500
Received: by mail-pf0-f179.google.com with SMTP id o185so96174429pfb.1
        for <linux-pm@vger.kernel.org>; Sun, 07 Feb 2016 07:52:04 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <3371031.KKUQAzJ7qu@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, Saravana Kannan <skannan@codeaurora.org>

On 07-02-16, 16:25, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Make the initialization of struct cpu_dbs_info objects in
> alloc_policy_dbs_info() and the code that cleans them up in
> free_policy_dbs_info() more symmetrical.  In particular,
> set/clear the update_util.func field in those functions along
> with the policy_dbs field.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq_governor.c |   21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
