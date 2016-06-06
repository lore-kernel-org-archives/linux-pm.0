From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2 0/3]  soc: renesas: rcar-sysc: Add support for R-Car
 M3-W power areas
Date: Mon, 6 Jun 2016 10:14:52 +0900
Message-ID: <20160606011451.GD4859@verge.net.au>
References: <1464627911-8126-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1464627911-8126-1-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Magnus Damm <damm+renesas@opensource.se>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, May 30, 2016 at 07:05:08PM +0200, Geert Uytterhoeven wrote:
> 	Hi Simon, Magnus,
> 
> This patch series adds support for the power areas exposed by the System
> Controller on the Renesas R-Car M3-W SoC. This is a prerequisite for
> enabling devices (e.g. VSP and FCP) that reside in power areas.
> 
> /sys/kernel/debug/pm_genpd/pm_genpd_summary output:
> 
>     domain                          status          slaves
> 	/device                                             runtime status
>     ----------------------------------------------------------------------
>     clock-controller                on              
>     a3ir                            off-0           
>     3dg-b                           off-0           
>     3dg-a                           off-0           3dg-b
>     a2vc1                           off-0           
>     a2vc0                           off-0           
>     a3vc                            off-0           a2vc0, a2vc1
>     cr7                             off-0           
>     ca53-cpu3                       on              
>     ca53-cpu2                       on              
>     ca53-cpu1                       on              
>     ca53-cpu0                       on              
>     ca53-scu                        on              ca53-cpu0, ca53-cpu1, ca53-cpu2, ca53-cpu3
>     ca57-cpu1                       on              
>     ca57-cpu0                       on              
>     ca57-scu                        on              ca57-cpu0, ca57-cpu1
>     always-on                       on              ca57-scu, ca53-scu, cr7, a3vc, 3dg-a, a3ir
> 	/devices/platform/soc/e6e88000.serial               active
> 
> Changes compared to v1:
>   - Add Acked-by.
> 
> For your convenience, I've pushed this series to the
> topic/r8a7796-sysc-v2 branch of
> https://git.kernel.org/cgit/linux/kernel/git/geert/renesas-drivers.git.
> This has been tested on r8a7796/salvator-x, and the code (minus the
> acks, i.e. v1), has been part of renesas-drivers since 2016-05-10.
> 
> Thanks!

Thanks, I have queued these up for v4.8.
