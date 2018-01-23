From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: scpi: fix static checker warning cdev isn't an
 ERR_PTR
Date: Tue, 23 Jan 2018 08:11:42 +0530
Message-ID: <20180123024142.GA13020@vireshk-i7>
References: <20180122104823.GA25283@mwanda>
 <1516632067-9584-1-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:46950 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751096AbeAWClr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jan 2018 21:41:47 -0500
Received: by mail-pf0-f194.google.com with SMTP id y5so8615379pff.13
        for <linux-pm@vger.kernel.org>; Mon, 22 Jan 2018 18:41:47 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1516632067-9584-1-git-send-email-sudeep.holla@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>

On 22-01-18, 14:41, Sudeep Holla wrote:
> Commit 343a8d17fa8d ("cpufreq: scpi: remove arm_big_little dependency")
> leads to the following static checker warning:
> 
> 	drivers/cpufreq/scpi-cpufreq.c:203 scpi_cpufreq_ready()
> 	warn: 'cdev' isn't an ERR_PTR
> 
> of_cpufreq_cooling_register() returns NULL on error. This patch removes
> the incorrect IS_ERR check on the returned pointer.
> 
> Fixes: 343a8d17fa8d ("cpufreq: scpi: remove arm_big_little dependency")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/cpufreq/scpi-cpufreq.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
