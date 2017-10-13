From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH/RFC 2/5] mfd: bd9571mwv: Add DDR Backup Power register
 bit definitions
Date: Fri, 13 Oct 2017 09:51:09 +0100
Message-ID: <20171013085109.m264vnvvorbwnw42@dell>
References: <1507649178-31473-1-git-send-email-geert+renesas@glider.be>
 <1507649178-31473-3-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1507649178-31473-3-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, 10 Oct 2017, Geert Uytterhoeven wrote:

> Add definitions for the KEEPON_* bits in the "BKUP Mode Cnt" register,
> which control the DDR rails to be kept powered when backup mode is
> enabled.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  include/linux/mfd/bd9571mwv.h | 5 +++++
>  1 file changed, 5 insertions(+)

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
