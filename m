From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 3/3] cpufreq: Simplify core code related to boost support
Date: Mon, 28 Dec 2015 08:59:49 +0530
Message-ID: <20151228032949.GG3598@ubuntu>
References: <2196419.fjWAQbI2Nm@vostro.rjw.lan>
 <2445772.lclmJ5R52X@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:35183 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751166AbbL1D3w (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 27 Dec 2015 22:29:52 -0500
Received: by mail-pa0-f44.google.com with SMTP id ho8so789118pac.2
        for <linux-pm@vger.kernel.org>; Sun, 27 Dec 2015 19:29:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <2445772.lclmJ5R52X@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

On 27-12-15, 00:27, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Notice that the boost_supported field in struct cpufreq_driver is
> redundant, because the driver's ->set_boost callback may be left
> unset if "boost" is not supported.  Moreover, the only driver
> populating the ->set_boost callback is acpi_cpufreq, so make it
> avoid populating that callback if "boost" is not supported, rework
> the core to check ->set_boost instead of boost_supported to
> verify "boost" support and drop boost_supported which isn't
> used any more.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/acpi-cpufreq.c |    5 ++---
>  drivers/cpufreq/cpufreq.c      |   22 +++++++---------------
>  include/linux/cpufreq.h        |    1 -
>  3 files changed, 9 insertions(+), 19 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
