From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 1/3] powernv:idle: Add IDLE_STATE_ENTER_SEQ_NORET macro
Date: Mon, 5 Dec 2016 14:52:11 +0530
Message-ID: <20161205092211.GA24305@in.ibm.com>
References: <cover.1478760806.git.ego@linux.vnet.ibm.com>
 <e3af60739710139801505562b4f09d59a1786f65.1478760806.git.ego@linux.vnet.ibm.com>
 <de9bf0bb-d188-86f5-86b1-b5931e587b63@gmail.com>
Reply-To: ego@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <de9bf0bb-d188-86f5-86b1-b5931e587b63@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Balbir Singh <bsingharora@gmail.com>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, Michael Neuling <mikey@neuling.org>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>, "Shreyas B. Prabhu" <shreyasbp@gmail.com>, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, Stewart Smith <stewart@linux.vnet.ibm.com>, Oliver O'Halloran <oohall@gmail.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Balbir,

On Tue, Nov 29, 2016 at 09:42:20PM +1100, Balbir Singh wrote:
> 
> 
> On 10/11/16 18:54, Gautham R. Shenoy wrote:
> > From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> > 
> > Currently all the low-power idle states are expected to wake up
> > at reset vector 0x100. Which is why the macro IDLE_STATE_ENTER_SEQ
> > that puts the CPU to an idle state and never returns.
> > 
> > On ISA_300, when the ESL and EC bits in the PSSCR are zero, the
> > CPU is expected to wake up at the next instruction of the idle
> > instruction.
> > 
> > This patch adds a new macro named IDLE_STATE_ENTER_SEQ_NORET for the
> 
> I think something like IDLE_STATE_ENTER_SEQ_LOSE_CTX would be better?

As you pointed out below, the macro encapsulates the magic sequence
that needs to be executed to go to a particular idle-state.

The behaviour changes based on ESL=EC=1 (or nap,fastsleep,winkle on
POWER8) in which case wake up is at 0x100. When ESL=EC=0, the wakeup
happens at the subsequent instruction.

So, more than whether the context is lost or not, the intent is to
indicate whether the wakeup happens at the next instruction or at
0x100.

> 
> > no-return variant and reuses the name IDLE_STATE_ENTER_SEQ
> > for a variant that allows resuming operation at the instruction next
> > to the idle-instruction.
> > 
> <snip>
> > +
> > +#define	IDLE_STATE_ENTER_SEQ_NORET(IDLE_INST)			\
> > +	IDLE_STATE_ENTER_SEQ(IDLE_INST)                         \
> 
> So we start off with both as the same?
> 
> >  	b	.
> >  #endif /* CONFIG_PPC_P7_NAP */
> <snip>
> Balbir
> 
--
Thanks and Regards
gautham.
