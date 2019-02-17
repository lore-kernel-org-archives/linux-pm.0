From: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Subject: Re: [PATCH] cpufreq: powernv: fix missing check of return value in
 init_powernv_pstates()
Date: Mon, 18 Feb 2019 00:41:49 +0530
Message-ID: <20190217190155.GA25556@aks.ibm>
References: <20190216170623.12634-1-tiny.windzz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190216170623.12634-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yangtao Li <tiny.windzz@gmail.com>
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sat, Feb 16, 2019 at 12:06:23PM -0500, Yangtao Li wrote:
> kmalloc() could fail, so insert a check of its return value. And
> if it fails, returns -ENOMEM.
> 
> And remove (struct pstate_idx_revmap_data *) to fix coccinelle WARNING
> by the way.
> 
> WARNING: casting value returned by memory allocation function to (struct
> pstate_idx_revmap_data *) is useless.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/cpufreq/powernv-cpufreq.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
Looks good to me. Thanks for fixing this.
