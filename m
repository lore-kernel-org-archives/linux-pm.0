From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 2/2] powernv/cpuidle: Use parsed device tree values
 for cpuidle_init
Date: Tue, 3 Jul 2018 15:17:59 +0530
Message-ID: <20180703094759.GB24693@in.ibm.com>
References: <1530609656-13301-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
 <1530609656-13301-3-git-send-email-akshay.adiga@linux.vnet.ibm.com>
Reply-To: ego@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1530609656-13301-3-git-send-email-akshay.adiga@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net, stewart@linux.vnet.ibm.com, benh@kernel.crashing.org, svaidy@linux.vnet.ibm.com, ego@linux.vnet.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au
List-Id: linux-pm@vger.kernel.org

Hi Akshay,

On Tue, Jul 03, 2018 at 02:50:56PM +0530, Akshay Adiga wrote:
> Export pnv_idle_states and nr_pnv_idle_states so that its accessible to
> cpuidle driver. Use properties from pnv_idle_states structure for powernv
> cpuidle_init.
> 
> Signed-off-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
> ---

[..snip..]

> 
>  		/*
>  		 * For nap and fastsleep, use default target_residency
>  		 * values if f/w does not expose it.
>  		 */

This comment can also go, since we are no longer hard-coding the
residency values in the kernel.

Otherwise looks good to me.

Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>


--
Thanks and Regards
gautham.
