From: Michael Ellerman <patch-notifications-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>
Subject: Re: [v6,1/5] powernv:idle: Add IDLE_STATE_ENTER_SEQ_NORET macro
Date: Wed,  1 Feb 2017 12:05:30 +1100 (AEDT)
Message-ID: <3vClL26Q2hz9rxw@ozlabs.org>
References: <1485333389-5752-2-git-send-email-ego@linux.vnet.ibm.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1485333389-5752-2-git-send-email-ego-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Michael Neuling <mikey-/owAOxkjmzZAfugRpC6u6w@public.gmane.org>, Vaidyanathan Srinivasan <svaidy-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, "Shreyas B. Prabhu" <shreyasbp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Shilpasri G Bhat <shilpa.bhat-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Stewart Smith <stewart-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Balbir Singh <bsingharora-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Oliver O'Halloran <oohall-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Gautham R. Shenoy" <ego-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Wed, 2017-01-25 at 08:36:25 UTC, "Gautham R. Shenoy" wrote:
> From: "Gautham R. Shenoy" <ego-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
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
> Acked-by: Balbir Singh <bsingharora-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Gautham R. Shenoy <ego-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/823b7bd5156a93872d9561b3f033df

cheers
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
