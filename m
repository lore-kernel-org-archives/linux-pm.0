From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [V2] cpuidle/powernv: Read target_residency value of idle states from DT if available
Date: Fri, 30 Jan 2015 14:56:52 +1100 (AEDT)
Message-ID: <20150130035652.3C252140277@ozlabs.org>
References: <20150128021044.11166.81418.stgit@preeti.in.ibm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:49617 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753396AbbA3D4y (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 29 Jan 2015 22:56:54 -0500
In-Reply-To: <20150128021044.11166.81418.stgit@preeti.in.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>, mpe@ellerman.id.au
Cc: rafael.j.wysocki@intel.com, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Wed, 2015-28-01 at 02:13:06 UTC, Preeti U Murthy wrote:
> The device tree now exposes the residency values for different idle states. Read
> these values instead of calculating residency from the latency values. The values
> exposed in the DT are validated for optimal power efficiency. However to maintain
> compatibility with the older firmware code which does not expose residency
> values, use default values as a fallback mechanism. While at it, handle some
> cleanups.
> 
> Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
> Acked-by: Stewart Smith <stewart@linux.vnet.ibm.com>

This looks good to me.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

I'm assuming Rafael will take it.

cheers
