From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 0/2] arm64: dts: r8a7796: Add SYSC PM Domains
Date: Mon, 6 Jun 2016 10:34:00 +0900
Message-ID: <20160606013359.GE4859@verge.net.au>
References: <1464685726-21611-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1464685726-21611-1-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Magnus Damm <damm+renesas@opensource.se>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, May 31, 2016 at 11:08:43AM +0200, Geert Uytterhoeven wrote:
> 	Hi Simon, Magnus,
> 
> This patch series adds support for the power areas exposed by the System
> Controller on the Renesas R-Car M3-W SoC to the DTS.
> 
> This series is against Simon's "[PATCH v3 0/3] arm64: Add Renesas
> R8A7796 SoC support".  It has a build and runtime dependency on my series
> "[PATCH v2 0/3] soc: renesas: rcar-sysc: Add support for R-Car M3-W power
> areas".
> 
> For your convenience, I've pushed this series to the
> topic/r8a7796-sysc-dt-v1 branch of
> https://git.kernel.org/cgit/linux/kernel/git/geert/renesas-drivers.git.
> This has been tested on r8a7796/salvator-x.

Thanks, I have tentatively queued this up.
