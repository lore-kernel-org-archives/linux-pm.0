From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v6 2/2] ARM hibernation / suspend-to-disk
Date: Fri, 28 Feb 2014 10:20:18 +0000
Message-ID: <20140228102018.GP21483@n2100.arm.linux.org.uk>
References: <1393545478-14908-1-git-send-email-sebastian.capella@linaro.org> <1393545478-14908-3-git-send-email-sebastian.capella@linaro.org> <530FD3CF.2040900@codeaurora.org> <530FEAA9.7040601@ti.com> <530FF245.7070300@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:57957 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751172AbaB1KU3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 28 Feb 2014 05:20:29 -0500
Content-Disposition: inline
In-Reply-To: <530FF245.7070300@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Russ Dill <Russ.Dill@ti.com>, Sebastian Capella <sebastian.capella@linaro.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Nicolas Pitre <nico@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Will Deacon <will.deacon@arm.com>, Jonathan Austin <jonathan.austin@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

On Thu, Feb 27, 2014 at 06:19:49PM -0800, Stephen Boyd wrote:
> On 02/27/14 17:47, Russ Dill wrote:
> > On 02/27/2014 04:09 PM, Stephen Boyd wrote:
> >> On 02/27/14 15:57, Sebastian Capella wrote:
> >>> diff --git a/arch/arm/include/asm/memory.h
> >>> b/arch/arm/include/asm/memory.h index 8756e4b..1079ea8 100644 ---
> >>> a/arch/arm/include/asm/memory.h +++
> >>> b/arch/arm/include/asm/memory.h @@ -291,6 +291,7 @@ static inline
> >>> void *phys_to_virt(phys_addr_t x) */ #define __pa(x)
> >>> __virt_to_phys((unsigned long)(x)) #define __va(x)			((void
> >>> *)__phys_to_virt((phys_addr_t)(x))) +#define __pa_symbol(x)
> >>> __pa(RELOC_HIDE((unsigned long)(x), 0))
> >> Just curious, is there a reason for the RELOC_HIDE() here? Or 
> >> __pa_symbol() for that matter? It looks like only x86 uses this on
> >> the __nosave_{begin,end} symbol. Maybe it's copy-pasta?
> > From my understanding this needs to stick around so long as gcc 3.x is
> > supported (did it get dropped yet?) on ARM Linux since it doesn't
> > support -fno-strict-overflow.
> 
> I don't think it's been dropped yet but I wonder if anyone has tried
> recent kernels with such a compiler?
> 
> Would the usage of &__pv_table_begin in arch/arm/mm/mmu.c also need the
> same treatment?

We've never had to play these kinds of games on ARM irrespective of
compiler version.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
