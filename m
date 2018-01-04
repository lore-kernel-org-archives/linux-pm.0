From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2 0/2] arm64: dts: r8a7795: r8a7796: add thermal cooling
 management
Date: Thu, 4 Jan 2018 17:50:53 +0100
Message-ID: <20180104165053.jtycpk36fiaursho@verge.net.au>
References: <20180104160320.11514-1-niklas.soderlund+renesas@ragnatech.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180104160320.11514-1-niklas.soderlund+renesas@ragnatech.se>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, linux-renesas-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, Jan 04, 2018 at 05:03:18PM +0100, Niklas Söderlund wrote:
> Hi,
> 
> This series adds support for for using CPUFreq as a cooling device for
> the A57 CUP:s on Renesas H3 and M3-W SoC:s. It depends on Simon Horman's
> topic/rcar-gen3-cpufreq-v4 branch [1] and is tested on H3 and M3-W. For 
> test results and test procedure please see:
> 
>    http://elinux.org/R-Car/Tests:rcar_gen3_thermal
> 
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
> * Changes since v1
> - Added acks from Eduardo Valentin.
> - Rebased on top of the latest branch of Simons work.
> 
> Niklas Söderlund (2):
>   arm64: dts: r8a7795: add thermal cooling management
>   arm64: dts: r8a7796: add thermal cooling management

Thanks, applied.
