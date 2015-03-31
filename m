From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH/RFC 1/5] clk: shmobile: rcar-gen2: Add CPG Clock Domain support
Date: Tue, 31 Mar 2015 15:25:46 -0700
Message-ID: <7h4mp0953p.fsf@deeprootsystems.com>
References: <1426708017-28885-1-git-send-email-geert+renesas@glider.be>
	<1426708017-28885-2-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1426708017-28885-2-git-send-email-geert+renesas@glider.be>
	(Geert Uytterhoeven's message of "Wed, 18 Mar 2015 20:46:53 +0100")
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Geert Uytterhoeven <geert+renesas@glider.be> writes:

> Add Clock Domain support to the R-Car Gen2 Clock Pulse Generator (CPG)
> driver using the generic PM Domain.  This allows to power-manage the
> module clocks of SoC devices that are part of the CPG Clock Domain using
> Runtime PM, or for system suspend/resume.
>
> SoC devices that are part of the CPG Clock Domain and can be
> power-managed through their primary clock should be tagged in DT with a
> proper "power-domains" property.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Kevin Hilman <khilman@linaro.org>
