From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] cpufreq: imx: fix regulator_get error handling
Date: Sun, 18 Oct 2015 22:16:03 +0530
Message-ID: <20151018164603.GF19018@linux>
References: <56237C1C.80109@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:36663 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932084AbbJRQqJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 18 Oct 2015 12:46:09 -0400
Received: by pacfv9 with SMTP id fv9so69562237pac.3
        for <linux-pm@vger.kernel.org>; Sun, 18 Oct 2015 09:46:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <56237C1C.80109@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org

On 18-10-15, 13:01, Heiner Kallweit wrote:
> With CONFIG_DELAY_DEVICE_PROBES being set I get the following error:
> 
> cpu cpu0: failed to get regulators
> imx6q-cpufreq: probe of imx6q-cpufreq.0 failed with error -2
> 
> Fix the error handling of regulator_get to properly deal
> with -EPROBE_DEFER.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/cpufreq/imx6q-cpufreq.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)

For both patches.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
-- 
viresh
