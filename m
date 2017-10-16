From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH/RFC 5/5] arm64: dts: renesas: salvator-common: Configure
 PMIC for DDR Backup Power
Date: Mon, 16 Oct 2017 09:09:10 +0200
Message-ID: <20171016070909.vwg5x6wntqgvtdr5@verge.net.au>
References: <1507649178-31473-1-git-send-email-geert+renesas@glider.be>
 <1507649178-31473-6-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1507649178-31473-6-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Lee Jones <lee.jones@linaro.org>, linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Oct 10, 2017 at 05:26:18PM +0200, Geert Uytterhoeven wrote:
> On Salvator-X(S), all of DDR0, DDR1, DDR0C, and DDR1C need to be kept
> powered when backup mode is enabled.
> 
> Reflect this in the rohm,ddr-backup-power property for the BD9571MWV
> PMIC.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>


Hi,

I have marked this as deferred pending acceptance of the bindings.
Please repost or otherwise ping me once that dependency is in place.
