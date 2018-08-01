From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [v4, 1/2] powernv/cpuidle: Parse dt idle properties into global structure
Date: Wed,  1 Aug 2018 15:23:59 +1000 (AEST)
Message-ID: <41gMDH3hWCz9s3x@ozlabs.org>
References: <20180705114022.19285-2-akshay.adiga@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180705114022.19285-2-akshay.adiga@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-pm@vger.kernel.org
Cc: stewart@linux.vnet.ibm.com, ego@linux.vnet.ibm.com, rjw@rjwysocki.net, npiggin@gmail.com, Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

On Thu, 2018-07-05 at 11:40:21 UTC, Akshay Adiga wrote:
> Device-tree parsing happens twice, once while deciding idle state to be
> used for hotplug and once during cpuidle init. Hence, parsing the device
> tree and caching it will reduce code duplication. Parsing code has been
> moved to pnv_parse_cpuidle_dt() from pnv_probe_idle_states(). In addition
> to the properties in the device tree the number of available states is
> also required.
> 
> Signed-off-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
> Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/9c7b185ab2fe313b4426bf55da3624

cheers
