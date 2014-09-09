From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH/RFC 1/5] PM / Domains: Add DT bindings for power-on/off latencies
Date: Tue, 09 Sep 2014 08:57:50 -0700
Message-ID: <7h8ulskcqp.fsf@deeprootsystems.com>
References: <1410183344-14756-1-git-send-email-geert+renesas@glider.be>
	<1410183344-14756-2-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1410183344-14756-2-git-send-email-geert+renesas@glider.be>
	(Geert Uytterhoeven's message of "Mon, 8 Sep 2014 15:35:40 +0200")
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Ulf Hansson <ulf.hansson@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Philipp Zabel <philipp.zabel@gmail.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Geert Uytterhoeven <geert+renesas@glider.be> writes:

> PM domain power on/off-latencies are properties of the hardware.
> In legacy code, they're specified from platform code.
> On DT platforms, their values should come from DT.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Nice.

Acked-by: Kevin Hilman <khilman@linaro.org>

Kevin
