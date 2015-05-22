From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V5 08/14] cpufreq: Track cpu managing sysfs kobjects separately
Date: Sat, 23 May 2015 01:29:13 +0200
Message-ID: <5187818.xT1sySEEAn@vostro.rjw.lan>
References: <cover.1431924457.git.viresh.kumar@linaro.org> <84aa63d8a244c2c7095ff41a2bd0013d8b95f290.1431924457.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:58324 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756929AbbEVXDt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 May 2015 19:03:49 -0400
In-Reply-To: <84aa63d8a244c2c7095ff41a2bd0013d8b95f290.1431924457.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, prarit@redhat.com, skannan@codeaurora.org, Srivatsa Bhat <srivatsa@mit.edu>

On Monday, May 18, 2015 10:43:31 AM Viresh Kumar wrote:
> From: Saravana Kannan <skannan@codeaurora.org>
> 
> In order to prepare for the next few commits, that will stop migrating
> sysfs files on cpu hotplug, this patch starts managing sysfs-cpu
> separately.
> 
> The behavior is still the same as we are still migrating sysfs files on
> hotplug, later commits would change that.
> 
> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied, thanks!


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
