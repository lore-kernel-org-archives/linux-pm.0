From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/2 v4] cpufreq: qoriq: Make the driver usable on all QorIQ platforms
Date: Fri, 13 Mar 2015 00:18:29 +0100
Message-ID: <2439490.9WNany9TAP@vostro.rjw.lan>
References: <1425353932-713-1-git-send-email-Yuantian.Tang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:49657 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752074AbbCLWyn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 12 Mar 2015 18:54:43 -0400
In-Reply-To: <1425353932-713-1-git-send-email-Yuantian.Tang@freescale.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Yuantian.Tang@freescale.com
Cc: viresh.kumar@linaro.org, linux-pm@vger.kernel.org, linuxppc-dev@ozlabs.org

On Tuesday, March 03, 2015 11:38:51 AM Yuantian.Tang@freescale.com wrote:
> From: Tang Yuantian <Yuantian.Tang@freescale.com>
> 
> Freescale introduced new ARM core-based SoCs which support dynamic
> frequency switch feature. DFS on new SoCs are compatible with current
> PowerPC CoreNet platforms. In order to support those new platforms,
> this driver needs to be updated. The main changes include:
> 
> 1. Changed the names of functions in driver.
> 2. Added two new functions get_cpu_physical_id() and get_bus_freq().
> 3. Used a new way to get the CPU mask which share clock wire.
> 
> Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

That doesn't apply for me on top of 4.0-rc3.  Can you please rebase and
resubmit?


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
