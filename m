From: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Subject: Re: [PATCH 0/2] arm64: dts: r8a7795: r8a7796: add thermal cooling
 management
Date: Fri, 15 Sep 2017 09:37:22 +0200
Message-ID: <20170915073722.GE3924@verge.net.au>
References: <20170913105909.13230-1-niklas.soderlund+renesas@ragnatech.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170913105909.13230-1-niklas.soderlund+renesas-1zkq55x86MTxsAP9Fp7wbw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas-1zkq55x86MTxsAP9Fp7wbw@public.gmane.org>
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Wed, Sep 13, 2017 at 12:59:07PM +0200, Niklas Söderlund wrote:
> Hi,
> 
> This series adds support for for using CPUFreq as a cooling device for 
> the A57 CUP:s on Renesas H3 and M3-W SoC:s. It depends on Simon Horman's 
> topic/rcar-gen3-cpufreq branch [1] and is tested on-top the latest 
> renesas-drivers on H3 and M3-W. For test results and test procedure 
> please see:
> 
>    http://elinux.org/R-Car/Tests:rcar_gen3_thermal

My cpufreq work needs revising to address review from both Geert and
yourself. I will try to address this in the near future. In the mean time
I have marked this series as Deferred.

> Few notes on the specific values used in this series and why they might 
> need to be changed.
> 
> - The trip point temperature of 95000 used is the most conservative one 
>   from the BSP and maybe should be set at 110000 which is the most 
>   aggressive one in the BSP.
> 
> - The cooling states described in all cooling-maps nodes might be 
>   subject to change depending on the out-come of the ongoing review 
>   process of Simon's work. It should use the highest possible cooling 
>   state so if the number of states change due review of his work this 
>   should be reflected in this series.
> 
> 1.  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git
> 
> Niklas Söderlund (2):
>   arm64: dts: r8a7795: add thermal cooling management
>   arm64: dts: r8a7796: add thermal cooling management
> 
>  arch/arm64/boot/dts/renesas/r8a7795.dtsi | 40 ++++++++++++++++++++++++++++++++
>  arch/arm64/boot/dts/renesas/r8a7796.dtsi | 38 ++++++++++++++++++++++++++++++
>  2 files changed, 78 insertions(+)
> 
> -- 
> 2.14.1
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
