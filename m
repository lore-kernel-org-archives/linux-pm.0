From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [PATCH V3] cpuidle/powernv: Read target_residency value of idle
 states from DT if available
Date: Mon, 02 Feb 2015 14:25:47 +0530
Message-ID: <54CF3B93.9090507@linux.vnet.ibm.com>
References: <20150202050821.24581.56186.stgit@preeti.in.ibm.com> <1422859164.20278.1.camel@ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1422859164.20278.1.camel@ellerman.id.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Ellerman <mpe@ellerman.id.au>, rafael.j.wysocki@intel.com
Cc: stewart@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 02/02/2015 12:09 PM, Michael Ellerman wrote:
> On Mon, 2015-02-02 at 10:40 +0530, Preeti U Murthy wrote:
>> The device tree now exposes the residency values for different idle states. Read
>> these values instead of calculating residency from the latency values. The values
>> exposed in the DT are validated for optimal power efficiency. However to maintain
>> compatibility with the older firmware code which does not expose residency
>> values, use default values as a fallback mechanism. While at it, use better
>> APIs to parse the powermgmt device tree node so as to avoid endianness
>> transformation.
>>
>> Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
>> ---
>> Changes from V2: https://lkml.org/lkml/2015/1/27/1054
>> 1. Used APIs to eliminate endianness transformation
> 
> Hi Preeti,
> 
> I thought I was pretty clear when I said you should do that as a follow-up
> patch.
> 
> This is now doing too many things, it's not a single logical change, and it's
> touching code in arch/powerpc and the driver. Which means neither I nor Rafael
> can easily merge it.  
> 
> So please go back to the v2 you had. And then do the of_property_count_u32_elems()
> changes as separate patches.

Yeah I apologize for this; going back to the conversation we had, I
realize that I completely overlooked the part where you suggested it as
a second patch. Sorry for the inconvenience.

Rafael, please ignore the versions sent so far. I shall send out two
patches that are logically separated. V2 of this patch that you were
requested to pick up needs some more fixes; the patch was not freeing
the dynamically allocated data after populating the cpufreq table. Ill
fix all of these in the next posting.

Thanks

Regards
Preeti U Murthy
> 
> cheers
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
