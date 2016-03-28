From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 3/3] drivers/cpufreq: make ppc_cbe_cpufreq_pmi driver
 explicitly non-modular
Date: Mon, 28 Mar 2016 08:03:14 +0530
Message-ID: <20160328023314.GA28406@vireshk-i7>
References: <1459116497-19991-1-git-send-email-paul.gortmaker@windriver.com>
 <1459116497-19991-4-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:34369 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753310AbcC1CdS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 27 Mar 2016 22:33:18 -0400
Received: by mail-pf0-f174.google.com with SMTP id x3so126133370pfb.1
        for <linux-pm@vger.kernel.org>; Sun, 27 Mar 2016 19:33:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1459116497-19991-4-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Christian Krafft <krafft@de.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, linux-pm@vger.kernel.org

On 27-03-16, 18:08, Paul Gortmaker wrote:
> The Kconfig for this driver is currently:
> 
> config CPU_FREQ_CBE_PMI
>     bool "CBE frequency scaling using PMI interface"
> 
> ...meaning that it currently is not being built as a module by
> anyone.  Lets remove the modular and unused code here, so that
> when reading the driver there is no doubt it is builtin-only.
> 
> Since module_init translates to device_initcall in the non-modular
> case, the init ordering remains unchanged with this commit.
> 
> We also delete the MODULE_LICENSE tag etc. since all that information
> is already contained at the top of the file in the comments.
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Christian Krafft <krafft@de.ibm.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>  drivers/cpufreq/ppc_cbe_cpufreq_pmi.c | 15 ++-------------
>  1 file changed, 2 insertions(+), 13 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
