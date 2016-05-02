From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] PM / OPP: pass cpumask by reference
Date: Mon, 2 May 2016 13:41:06 +0530
Message-ID: <20160502081106.GG2855@vireshk-i7>
References: <1462016049-1976580-1-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:36622 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751500AbcEBILK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 2 May 2016 04:11:10 -0400
Received: by mail-pf0-f182.google.com with SMTP id c189so77528128pfb.3
        for <linux-pm@vger.kernel.org>; Mon, 02 May 2016 01:11:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1462016049-1976580-1-git-send-email-arnd@arndb.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Viresh Kumar <vireshk@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 30-04-16, 13:33, Arnd Bergmann wrote:
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
>  drivers/base/power/opp/cpu.c | 10 +++++-----
>  include/linux/pm_opp.h       | 20 ++++++++++----------
>  2 files changed, 15 insertions(+), 15 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
