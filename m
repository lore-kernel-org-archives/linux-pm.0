From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 1/2] powernv/cpuidle: Parse dt idle properties into
 global structure
Date: Tue, 3 Jul 2018 15:16:36 +0530
Message-ID: <20180703094636.GA24693@in.ibm.com>
References: <1530609656-13301-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
 <1530609656-13301-2-git-send-email-akshay.adiga@linux.vnet.ibm.com>
Reply-To: ego@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1530609656-13301-2-git-send-email-akshay.adiga@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net, stewart@linux.vnet.ibm.com, benh@kernel.crashing.org, svaidy@linux.vnet.ibm.com, ego@linux.vnet.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au
List-Id: linux-pm@vger.kernel.org

Hi Akshay,

On Tue, Jul 03, 2018 at 02:50:55PM +0530, Akshay Adiga wrote:
> Device-tree parsing happens twice, once while deciding idle state to be
> used for hotplug and once during cpuidle init. Hence, parsing the device
> tree and caching it will reduce code duplication. Parsing code has been
> moved to pnv_parse_cpuidle_dt() from pnv_probe_idle_states(). In addition
> to the properties in the device tree the number of available states is
> also required.
> 
> Signed-off-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

Looks good.
Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
