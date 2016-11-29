From: Balbir Singh <bsingharora@gmail.com>
Subject: Re: [PATCH v3 1/3] powernv:idle: Add IDLE_STATE_ENTER_SEQ_NORET macro
Date: Tue, 29 Nov 2016 21:42:20 +1100
Message-ID: <de9bf0bb-d188-86f5-86b1-b5931e587b63@gmail.com>
References: <cover.1478760806.git.ego@linux.vnet.ibm.com>
 <e3af60739710139801505562b4f09d59a1786f65.1478760806.git.ego@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34446 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751629AbcK2Kmo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Nov 2016 05:42:44 -0500
In-Reply-To: <e3af60739710139801505562b4f09d59a1786f65.1478760806.git.ego@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, Michael Neuling <mikey@neuling.org>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>, "Shreyas B. Prabhu" <shreyasbp@gmail.com>, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, Stewart Smith <stewart@linux.vnet.ibm.com>, Oliver O'Halloran <oohall@gmail.com>
Cc: "\"linuxppc-dev"@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, "skiboot\""@lists.ozlabs.org



On 10/11/16 18:54, Gautham R. Shenoy wrote:
> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> 
> Currently all the low-power idle states are expected to wake up
> at reset vector 0x100. Which is why the macro IDLE_STATE_ENTER_SEQ
> that puts the CPU to an idle state and never returns.
> 
> On ISA_300, when the ESL and EC bits in the PSSCR are zero, the
> CPU is expected to wake up at the next instruction of the idle
> instruction.
> 
> This patch adds a new macro named IDLE_STATE_ENTER_SEQ_NORET for the

I think something like IDLE_STATE_ENTER_SEQ_LOSE_CTX would be better?

> no-return variant and reuses the name IDLE_STATE_ENTER_SEQ
> for a variant that allows resuming operation at the instruction next
> to the idle-instruction.
> 
<snip>
> +
> +#define	IDLE_STATE_ENTER_SEQ_NORET(IDLE_INST)			\
> +	IDLE_STATE_ENTER_SEQ(IDLE_INST)                         \

So we start off with both as the same?

>  	b	.
>  #endif /* CONFIG_PPC_P7_NAP */
<snip>
Balbir
