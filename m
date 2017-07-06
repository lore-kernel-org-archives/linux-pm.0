From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 5/5] powernv:idle: Disable LOSE_FULL_CONTEXT states when
 stop-api fails.
Date: Fri, 7 Jul 2017 01:29:16 +1000
Message-ID: <20170707012916.215ed32a@roar.ozlabs.ibm.com>
References: <1499272696-28751-1-git-send-email-ego@linux.vnet.ibm.com>
        <1499272696-28751-6-git-send-email-ego@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1499272696-28751-6-git-send-email-ego@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed,  5 Jul 2017 22:08:16 +0530
"Gautham R. Shenoy" <ego@linux.vnet.ibm.com> wrote:

> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> 
> Currently, we use the opal call opal_slw_set_reg() to inform the that
> the Sleep-Winkle Engine (SLW) to restore the contents of some of the
> Hypervisor state on wakeup from deep idle states that lose full
> hypervisor context (characterized by the flag
> OPAL_PM_LOSE_FULL_CONTEXT).
> 
> However, the current code has a bug in that if opal_slw_set_reg()
> fails, we don't disable the use of these deep states (winkle on
> POWER8, stop4 onwards on POWER9).
> 
> This patch fixes this bug by ensuring that if the the sleep winkle
> engine is unable to restore the hypervisor states in
> pnv_save_sprs_for_deep_states(), then we mark as invalid the states
> which lose full context.
> 
> As a side-effect, since supported_cpuidle_states in
> pnv_probe_idle_states() consists of flags of only the valid states,
> this patch will ensure that no other subsystem in the kernel can use
> the states which lose full context on stop-api failures.

Looks good. Is there something minimal we can do for stable here?

Aside question, do we need to restore LPCR at all with the SLW engine?
It gets set up again when by the idle wakeup code.

And does POWER9 really need MSR and PSSCR restored by SLW? (going a bit
off topic here, I'm just curious)

Thanks,
Nick
