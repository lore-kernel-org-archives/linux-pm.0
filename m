From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: Build error in drivers/cpufreq/intel_pstate.c
Date: Tue, 30 Oct 2018 09:22:50 -0700
Message-ID: <8a97f82e93fa42022aaf186ccbe6fef6be56e236.camel@linux.intel.com>
References: <e176a41a-eb24-7f2c-bb75-a9b18eab420f@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e176a41a-eb24-7f2c-bb75-a9b18eab420f@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Igor Stoppa <igor.stoppa@gmail.com>, Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,
On Tue, 2018-10-30 at 18:00 +0200, Igor Stoppa wrote:
> Hi,
> I'm getting the following build error:
> 
> /home/igor/dev/kernel/linux/drivers/cpufreq/intel_pstate.c: In
> function 
> ‘show_base_frequency’:
> /home/igor/dev/kernel/linux/drivers/cpufreq/intel_pstate.c:726:10: 
> error: implicit declaration of function 
> ‘intel_pstate_get_cppc_guranteed’; did you mean
> ‘intel_pstate_get_epp’? 
> [-Werror=implicit-function-declaration]
>    ratio = intel_pstate_get_cppc_guranteed(policy->cpu);
>            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>            intel_pstate_get_epp
> 
> 

This should fix this:

https://patchwork.kernel.org/patch/10653593/

Thanks,
Srinivas
> 
> on top of:
> 
> commit 11743c56785c751c087eecdb98713eef796609e0
> Merge: 929e134c43c9 928002a5e9da
> 
> --
> igor
