From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/3] cpufreq: Make cpufreq_boost_supported() static
Date: Mon, 28 Dec 2015 08:46:48 +0530
Message-ID: <20151228031648.GE3598@ubuntu>
References: <2196419.fjWAQbI2Nm@vostro.rjw.lan>
 <7055444.k3FMydYOLT@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:34902 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751044AbbL1DQw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 27 Dec 2015 22:16:52 -0500
Received: by mail-pa0-f50.google.com with SMTP id ho8so660177pac.2
        for <linux-pm@vger.kernel.org>; Sun, 27 Dec 2015 19:16:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7055444.k3FMydYOLT@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

On 27-12-15, 00:23, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> cpufreq_boost_supported() is not used outside of cpufreq.c, so make
> it static.
> 
> While at it, refactor it as a one-liner (which it really is).
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq.c |    8 ++------
>  include/linux/cpufreq.h   |    5 -----
>  2 files changed, 2 insertions(+), 11 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
