From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [patch 0/5] powercap/intel_rapl: Fixes, hotplug conversion and
 simplifcation
Date: Wed, 23 Nov 2016 11:06:47 -0800
Message-ID: <20161123110647.37485542@icelake>
References: <20161122210518.079483154@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:28642 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756303AbcKWTIg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 23 Nov 2016 14:08:36 -0500
In-Reply-To: <20161122210518.079483154@linutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Rafael Wysocki <rjw@sisk.pl>, x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@intel.com>, jacob.jun.pan@linux.intel.com

On Tue, 22 Nov 2016 21:15:56 -0000
Thomas Gleixner <tglx@linutronix.de> wrote:

> The driver fails to:
> 
>  - initialize packages which are not available at driver init time,
> though the value of that initialization is completely unclear as
> nothing ever uses these values. I fixed it up nevertheless and leave
> it to the maintainers to decide whether it should completely go away.
> 
>  - to propagate error codes in the hotplug online path, where a
>    registration fails and the package data is freed, but return code
> is 0.
> 
> The initialization/removal code of that driver is a maze of
> duplicated code which is more or less the same as the cpu hotplug
> code. After switching over the driver to the hotplug statemachine,
> the whole init/removal machinery can be replaced by
> installing/removing the hotplug state.
> 
> The total damage is:
> 
>  intel_rapl.c |  363
> ++++++++++++++++------------------------------------------- 1 file
> changed, 104 insertions(+), 259 deletions(-)
> 
> and the binary size shrinks as well:
> 
>    text	   data	    bss	    dec	    hex
>    7996	    625	     32	   8653
> 21cd	  Before 7216	    593	     32
> 7841	   1ea1	  After
> 
I have successfully tested this patchset with various cpu online/offline
scenarios on both single and dual socket systems.

Looks good to me. The cpu topology management is much more streamlined.
Thanks. I also sent out this patch below on top of yours.

[PATCH] powercap/intel_rapl: fix and tidy up error handling

Thanks,

Jacob
> Thanks,
> 
> 	tglx
> 
> 
> 
> 

[Jacob Pan]
