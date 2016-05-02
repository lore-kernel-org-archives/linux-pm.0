From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH] PM / OPP: pass cpumask by reference
Date: Mon, 2 May 2016 15:51:00 -0700
Message-ID: <5727D9D4.2040109@codeaurora.org>
References: <1462016049-1976580-1-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:41436 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755242AbcEBWvD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 2 May 2016 18:51:03 -0400
In-Reply-To: <1462016049-1976580-1-git-send-email-arnd@arndb.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Viresh Kumar <vireshk@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Nishanth Menon <nm@ti.com>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 04/30/2016 04:33 AM, Arnd Bergmann wrote:
> The new use of dev_pm_opp_set_sharing_cpus resulted in a harmless compiler
> warning with CONFIG_CPUMASK_OFFSTACK=y:
>
> drivers/cpufreq/mvebu-cpufreq.c: In function 'armada_xp_pmsu_cpufreq_init':
> include/linux/cpumask.h:550:25: error: passing argument 2 of 'dev_pm_opp_set_sharing_cpus' discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
>
> The problem here is that cpumask_var_t gets passed by reference, but
> by declaring a 'const cpumask_var_t' argument, only the pointer is
> constant, not the actual mask. This is harmless because the function
> does not actually modify the mask.
>
> This patch changes the function prototypes for all of the related functions
> to pass a 'struct cpumask *' instead of 'cpumask_var_t', matching what
> most other such functions do in the kernel. This lets us mark all the
> other similar functions as taking a 'const' mask where possible,
> and it avoids the warning without any change in object code.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 947bd567f7a5 ("mvebu: Use dev_pm_opp_set_sharing_cpus() to mark OPP tables as shared")
> ---
>

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

