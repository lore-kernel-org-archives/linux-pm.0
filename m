From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v6 1/5] cpufreq: powernv: Hot-plug safe the kworker thread
Date: Mon, 25 Jan 2016 11:19:20 +0530
Message-ID: <20160125054920.GA3183@vireshk>
References: <1453447145-17722-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1453447145-17722-2-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:32801 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751087AbcAYFtX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 25 Jan 2016 00:49:23 -0500
Received: by mail-pf0-f176.google.com with SMTP id e65so76699912pfe.0
        for <linux-pm@vger.kernel.org>; Sun, 24 Jan 2016 21:49:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1453447145-17722-2-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, pc@us.ibm.com, anton@samba.org, ego@linux.vnet.ibm.com, shreyas@linux.vnet.ibm.com

On 22-01-16, 12:49, Shilpasri G Bhat wrote:
> In the kworker_thread powernv_cpufreq_work_fn(), we can end up
> sending an IPI to a cpu going offline. This is a rare corner case
> which is fixed using {get/put}_online_cpus(). Along with this fix,
> this patch adds changes to do oneshot cpumask_{clear/and} operation.
> 
> Suggested-by: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>
> Suggested-by: Gautham R Shenoy <ego@linux.vnet.ibm.com>
> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> ---
> Changes form v5:
> - Fix the kbuild-error:
> drivers/cpufreq/powernv-cpufreq.c:428:2: error: implicit declaration of
> function 'get_online_cpus' [-Werror=implicit-function-declaration
> 
>  drivers/cpufreq/powernv-cpufreq.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
