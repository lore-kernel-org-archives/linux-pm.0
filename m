From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [3/3] drivers/cpufreq: make ppc_cbe_cpufreq_pmi driver explicitly non-modular
Date: Mon, 11 Apr 2016 22:35:10 +1000 (AEST)
Message-ID: <3qk8fQ3wrVz9t3p@ozlabs.org>
References: <1459116497-19991-4-git-send-email-paul.gortmaker@windriver.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459116497-19991-4-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Paul Gortmaker <paul.gortmaker@windriver.com>, Paul Mackerras <paulus@samba.org>, Viresh Kumar <viresh.kumar@linaro.org>, Christian Krafft <krafft@de.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: linux-pm@vger.kernel.org

On Sun, 2016-27-03 at 22:08:17 UTC, Paul Gortmaker wrote:
> The Kconfig for this driver is currently:
> 
> config CPU_FREQ_CBE_PMI
>     bool "CBE frequency scaling using PMI interface"
> 
> ...meaning that it currently is not being built as a module by
> anyone.  Lets remove the modular and unused code here, so that
> when reading the driver there is no doubt it is builtin-only.
> 
...
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/6a0bcab9c6c337e14689cabd27

cheers
