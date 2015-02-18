From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: driver/cpuidle-powernv: Avoid endianness conversions while parsing DT
Date: Thu, 19 Feb 2015 10:35:06 +1100 (AEDT)
Message-ID: <20150218233506.4B5411400F1@ozlabs.org>
References: <20150203062810.13207.93694.stgit@preeti.in.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150203062810.13207.93694.stgit@preeti.in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Cc: stewart@linux.vnet.ibm.com, rafael.j.wysocki@intel.com, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, 2015-03-02 at 06:31:15 UTC, Preeti U Murthy wrote:
> We currently read the information about idle states from the DT
> so as to populate the cpuidle table. Use those APIs to read from
> the DT that can avoid endianness conversions of the property values
> in the cpuidle driver.
> 
> Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
