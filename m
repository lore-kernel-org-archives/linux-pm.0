From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3 8/10] cpufreq: governor: Rename cpu_common_dbs_info to
 policy_dbs_info
Date: Sun, 7 Feb 2016 15:01:52 +0530
Message-ID: <20160207093152.GC19059@vireshk>
References: <3705929.bslqXH980s@vostro.rjw.lan>
 <9008098.QDD8C89zDx@vostro.rjw.lan>
 <2973464.jyrWv0qA55@vostro.rjw.lan>
 <20213140.Qi3up6pdV4@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35650 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753675AbcBGJb5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 7 Feb 2016 04:31:57 -0500
Received: by mail-pa0-f49.google.com with SMTP id ho8so57995161pac.2
        for <linux-pm@vger.kernel.org>; Sun, 07 Feb 2016 01:31:56 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20213140.Qi3up6pdV4@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, Saravana Kannan <skannan@codeaurora.org>

On 06-02-16, 13:48, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: [PATCH] cpufreq: governor: Rename cpu_common_dbs_info to policy_dbs_info
> 
> The struct cpu_common_dbs_info structure represents the per-policy
> part of the governor data (for the ondemand and conservative
> governors), but its name doesn't reflect its purpose.
> 
> Rename it to struct policy_dbs_info and rename variables related to
> it accordingly.
> 
> No functional changes.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
