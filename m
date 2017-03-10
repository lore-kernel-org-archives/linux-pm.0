From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [BUG] v4.11-rc1: CPUFREQ Circular locking dependency
Date: Fri, 10 Mar 2017 23:43:25 +0000
Message-ID: <20170310234325.GB21222@n2100.armlinux.org.uk>
References: <20170310150218.GW21222@n2100.armlinux.org.uk>
 <CAJZ5v0jGRH_hwvvm9OLsaYgbghqWKOke9PyGNnkvP_ZiMqAxSw@mail.gmail.com>
 <BY2PR21MB00362E60448FD2E00C120FFCCB200@BY2PR21MB0036.namprd21.prod.outlook.com>
 <BY2PR21MB00361C512E03B09DBCE715D3CB200@BY2PR21MB0036.namprd21.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:45104 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755330AbdCJXnr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Mar 2017 18:43:47 -0500
Content-Disposition: inline
In-Reply-To: <BY2PR21MB00361C512E03B09DBCE715D3CB200@BY2PR21MB0036.namprd21.prod.outlook.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Matthew Wilcox <mawilcox@microsoft.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Mar 10, 2017 at 06:33:28PM +0000, Matthew Wilcox wrote:
> From cd5401d81633d5e48e39d67d4e65156e6759537e Mon Sep 17 00:00:00 2001
> From: Matthew Wilcox <mawilcox@microsoft.com>
> Date: Fri, 10 Mar 2017 13:22:53 -0500
> Subject: [PATCH] thermal: Fix potential deadlock in cpu_cooling
> 
> I expanded the scope of cooling_list_lock a little too far; it was
> not just covering cpufreq_dev_count, it was also covering the calls
> to cpufreq_register_notifier() and cpufreq_unregister_notifier().
> Since cooling_list_lock is also used within cpufreq_thermal_notifier(),
> lockdep reports a potential deadlock.  I don't think that's actually
> possible, but it's easy enough to make it impossible by testing the
> condition under cooling_list_lock and dropping the lock before calling
> cpufreq_register_notifier().
> 
> As a bonus, I noticed that cpufreq_dev_count is only used for the purpose
> of knowing whether this is the first or last cooling device registered,
> and we know that anyway because we know whether the list transitioned
> between empty and not-empty.  So we can delete that variable too.
> 
> Fixes: ae606089621ef0349402cfcbeca33a82abbd0fd0
> Reported-by: Russell King <linux@armlinux.org.uk>
> Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>

Thanks Matthew, appears to solve the problem.

Tested-by: Russell King <rmk+kernel@armlinux.org.uk>

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
