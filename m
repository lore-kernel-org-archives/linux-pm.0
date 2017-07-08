From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 5/5] powernv:idle: Disable LOSE_FULL_CONTEXT states when
 stop-api fails.
Date: Sat, 8 Jul 2017 19:05:26 +1000
Message-ID: <20170708190526.44ea9ab9@roar.ozlabs.ibm.com>
References: <1499272696-28751-1-git-send-email-ego@linux.vnet.ibm.com>
        <1499272696-28751-6-git-send-email-ego@linux.vnet.ibm.com>
        <20170707012916.215ed32a@roar.ozlabs.ibm.com>
        <20170707173710.GE8913@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36541 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752636AbdGHJFp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 8 Jul 2017 05:05:45 -0400
In-Reply-To: <20170707173710.GE8913@in.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Fri, 7 Jul 2017 23:07:10 +0530
Gautham R Shenoy <ego@linux.vnet.ibm.com> wrote:

> On Fri, Jul 07, 2017 at 01:29:16AM +1000, Nicholas Piggin wrote:
> > On Wed,  5 Jul 2017 22:08:16 +0530
> > "Gautham R. Shenoy" <ego@linux.vnet.ibm.com> wrote:
> >   
> > > From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> > > 
> > > Currently, we use the opal call opal_slw_set_reg() to inform the that
> > > the Sleep-Winkle Engine (SLW) to restore the contents of some of the
> > > Hypervisor state on wakeup from deep idle states that lose full
> > > hypervisor context (characterized by the flag
> > > OPAL_PM_LOSE_FULL_CONTEXT).
> > > 
> > > However, the current code has a bug in that if opal_slw_set_reg()
> > > fails, we don't disable the use of these deep states (winkle on
> > > POWER8, stop4 onwards on POWER9).
> > > 
> > > This patch fixes this bug by ensuring that if the the sleep winkle
> > > engine is unable to restore the hypervisor states in
> > > pnv_save_sprs_for_deep_states(), then we mark as invalid the states
> > > which lose full context.
> > > 
> > > As a side-effect, since supported_cpuidle_states in
> > > pnv_probe_idle_states() consists of flags of only the valid states,
> > > this patch will ensure that no other subsystem in the kernel can use
> > > the states which lose full context on stop-api failures.  
> > 
> > Looks good. Is there something minimal we can do for stable here?
> > 
> > Aside question, do we need to restore LPCR at all with the SLW engine?
> > It gets set up again when by the idle wakeup code.  
> 
> 
> > 
> > And does POWER9 really need MSR and PSSCR restored by SLW? (going a bit
> > off topic here, I'm just curious)  
> 
> MSR is needed to be restored so that we wakeup with the right
> endianness and with the IR,DR disabled.

And POWER8 does not require this?

> PSSCR is set to a value so that in case of a special wakeup for a
> deep-stop, the SLW can program the core to go back to the stop level
> provided by the PSSCR value via the stop-api.

It always restores to deepest stop? Is there any way to restore to the
achieved stop level? Maybe there is no usefulness for that.

Thanks,
Nick
