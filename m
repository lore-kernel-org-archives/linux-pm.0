From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 0/2 v3] cpufreq, intel_pstate, Fix rounding errors
Date: Sat, 21 Nov 2015 08:01:11 +0530
Message-ID: <20151121023111.GG3957@ubuntu>
References: <1448063277-12446-1-git-send-email-prarit@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34575 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760114AbbKUCbS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 20 Nov 2015 21:31:18 -0500
Received: by padhx2 with SMTP id hx2so133605344pad.1
        for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2015 18:31:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1448063277-12446-1-git-send-email-prarit@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@intel.com>, Len Brown <len.brown@intel.com>, Alexandra Yates <alexandra.yates@intel.com>, Kristen Carlson Accardi <kristen@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org

On 20-11-15, 18:47, Prarit Bhargava wrote:
> [v2]: Separate into two patches, and rebase onto git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
> [v3]: calculate limits->max_policy_pct once

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
