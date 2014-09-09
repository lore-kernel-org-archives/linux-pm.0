From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH/RFC 4/5] ARM: shmobile: R-Mobile: Add DT support for PM domains
Date: Tue, 09 Sep 2014 08:40:13 -0700
Message-ID: <7hfvg0kdk2.fsf@deeprootsystems.com>
References: <1410183344-14756-1-git-send-email-geert+renesas@glider.be>
	<1410183344-14756-5-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1410183344-14756-5-git-send-email-geert+renesas@glider.be>
	(Geert Uytterhoeven's message of "Mon, 8 Sep 2014 15:35:43 +0200")
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Ulf Hansson <ulf.hansson@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Philipp Zabel <philipp.zabel@gmail.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Geert Uytterhoeven <geert+renesas@glider.be> writes:

> Populate the PM domains from DT, and provide support to hook up devices
> to their respective PM domain.
>
> The always-on power area (e.g. C5 on r8a7740) is created as a PM domain
> without software control, to allow Run-Time management of module clocks
> for hardware blocks inside this area in the future.
> Power-on/off latencies are supported.
>
> Limitations and special cases in the non-DT case are handled through
> rmobile_pm_quirks(). Checks for hardcoded PM domain indices should be
> replaced by the analysis of relations between devices and PM domains in
> DT.
>
> Initialization is done from core_initcall(), as the
> "renesas,intc-irqpin" driver uses postcore_initcall().
>
> This is functionally almost equivalent to the non-DT case. Missing are
> Run-Time management of the module clocks (pm_clk_*()), and device
> latencies.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

[...]

> +static int r8a7740_pd_a4s_suspend(void)
> +{
> +	/*
> +	 * The A4S domain contains the CPU core and therefore it should
> +	 * only be turned off if the CPU is in use.

I think you meant "if the CPU is *not* in use."  ?  :)

Kevin

