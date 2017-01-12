From: Balbir Singh <bsingharora@gmail.com>
Subject: Re: [PATCH v5 1/5] powernv:idle: Add IDLE_STATE_ENTER_SEQ_NORET macro
Date: Thu, 12 Jan 2017 15:12:37 +0530
Message-ID: <20170112094237.GB3006@localhost.localdomain>
References: <1484039224-5630-1-git-send-email-ego@linux.vnet.ibm.com>
 <1484039224-5630-2-git-send-email-ego@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33074 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750768AbdALJms (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Jan 2017 04:42:48 -0500
Content-Disposition: inline
In-Reply-To: <1484039224-5630-2-git-send-email-ego@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, Michael Neuling <mikey@neuling.org>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>, "Shreyas B. Prabhu" <shreyasbp@gmail.com>, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, Stewart Smith <stewart@linux.vnet.ibm.com>, Balbir Singh <bsingharora@gmail.com>, Oliver O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, mark.rutland@arm.com

On Tue, Jan 10, 2017 at 02:37:00PM +0530, Gautham R. Shenoy wrote:
> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> 
> Currently all the low-power idle states are expected to wake up
> at reset vector 0x100. Which is why the macro IDLE_STATE_ENTER_SEQ
> that puts the CPU to an idle state and never returns.
> 
> On ISA v3.0, when the ESL and EC bits in the PSSCR are zero, the CPU
> is expected to wake up at the next instruction of the idle
> instruction.
> 
> This patch adds a new macro named IDLE_STATE_ENTER_SEQ_NORET for the
> no-return variant and reuses the name IDLE_STATE_ENTER_SEQ
> for a variant that allows resuming operation at the instruction next
> to the idle-instruction.
> 
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> ---
> No changes from v4
>

Acked-by: Balbir Singh <bsingharora@gmail.com> 
