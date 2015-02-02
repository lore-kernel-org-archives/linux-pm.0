From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH V3] cpuidle/powernv: Read target_residency value of idle
 states from DT if available
Date: Mon, 02 Feb 2015 17:39:24 +1100
Message-ID: <1422859164.20278.1.camel@ellerman.id.au>
References: <20150202050821.24581.56186.stgit@preeti.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:47820 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932486AbbBBGj0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 2 Feb 2015 01:39:26 -0500
In-Reply-To: <20150202050821.24581.56186.stgit@preeti.in.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Cc: stewart@linux.vnet.ibm.com, rafael.j.wysocki@intel.com, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Mon, 2015-02-02 at 10:40 +0530, Preeti U Murthy wrote:
> The device tree now exposes the residency values for different idle states. Read
> these values instead of calculating residency from the latency values. The values
> exposed in the DT are validated for optimal power efficiency. However to maintain
> compatibility with the older firmware code which does not expose residency
> values, use default values as a fallback mechanism. While at it, use better
> APIs to parse the powermgmt device tree node so as to avoid endianness
> transformation.
> 
> Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
> ---
> Changes from V2: https://lkml.org/lkml/2015/1/27/1054
> 1. Used APIs to eliminate endianness transformation

Hi Preeti,

I thought I was pretty clear when I said you should do that as a follow-up
patch.

This is now doing too many things, it's not a single logical change, and it's
touching code in arch/powerpc and the driver. Which means neither I nor Rafael
can easily merge it.  

So please go back to the v2 you had. And then do the of_property_count_u32_elems()
changes as separate patches.

cheers


