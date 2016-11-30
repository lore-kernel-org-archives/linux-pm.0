From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH] PM / Domains: Do not print PM domain add error message if EPROBE_DEFER
Date: Wed, 30 Nov 2016 08:41:36 -0800
Message-ID: <m2k2bkkji7.fsf@baylibre.com>
References: <1480508696-19294-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1480508696-19294-1-git-send-email-geert+renesas@glider.be>
        (Geert Uytterhoeven's message of "Wed, 30 Nov 2016 13:24:56 +0100")
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Geert Uytterhoeven <geert+renesas@glider.be> writes:

> EPROBE_DEFER is not an error, hence printing an error message like
>
>     renesas_irqc e61c0000.interrupt-controller: failed to add to PM domain always-on: -517
>
> may confuse the user.
>
> Suppress the error message in case of EPROBE_DEFER to fix this.
>
> Reported-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Yes, I had noticed this too but not got around to fixing it.

Acked-by: Kevin Hilman <khilman@baylibre.com>

Kevin
