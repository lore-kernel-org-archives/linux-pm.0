From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [v2] powerpc/powernv/idle: Disable LOSE_FULL_CONTEXT states when stop-api fails
Date: Wed,  9 Aug 2017 23:34:12 +1000 (AEST)
Message-ID: <3xSC0h6Tj7z9sN5@ozlabs.org>
References: <1502181795-15477-1-git-send-email-ego@linux.vnet.ibm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:50601 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752520AbdHINeO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 9 Aug 2017 09:34:14 -0400
In-Reply-To: <1502181795-15477-1-git-send-email-ego@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Neuling <mikey@neuling.org>, Nicholas Piggin <npiggin@gmail.com>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Tue, 2017-08-08 at 08:43:15 UTC, "Gautham R. Shenoy" wrote:
> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> 
> Currently, we use the opal call opal_slw_set_reg() to inform the
> Sleep-Winkle Engine (SLW) to restore the contents of some of the
> Hypervisor state on wakeup from deep idle states that lose full
> hypervisor context (characterized by the flag
> OPAL_PM_LOSE_FULL_CONTEXT).
> 
> However, the current code has a bug in that if opal_slw_set_reg()
> fails, we don't disable the use of these deep states (winkle on
> POWER8, stop4 onwards on POWER9).
> 
> This patch fixes this bug by ensuring that if programing the
> sleep-winkle engine to restore the hypervisor states in
> pnv_save_sprs_for_deep_states() fails, then we exclude such states by
> clearing the OPAL_PM_LOSE_FULL_CONTEXT flag from
> supported_cpuidle_states. As a result POWER8 will be prevented from
> using winkle for CPU-Hotplug, and POWER9 will put the offlined CPUs to
> the default stop state when available.
> 
> Further, we ensure in the initialization of the cpuidle-powernv driver
> to only include those states whose flags are present in
> supported_cpuidle_states, thereby skipping OPAL_PM_LOSE_FULL_CONTEXT
> states when they have been disabled due to stop-api failure.
> 
> Fixes: 1e1601b38e6 ("powerpc/powernv/idle: Restore SPRs for deep idle
> states via stop API.")
> 
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/785a12afdb4a52903447fd890633c8

cheers
