From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v2 5/5] [RFC] PM / Domains: Remove gpd_dev_ops.active_wakeup() callback
Date: Thu, 02 Nov 2017 15:00:12 +0100
Message-ID: <7h60aslr0z.fsf@baylibre.com>
References: <1509473494-19740-1-git-send-email-geert+renesas@glider.be>
        <1509473494-19740-6-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1509473494-19740-6-git-send-email-geert+renesas@glider.be>
        (Geert Uytterhoeven's message of "Tue, 31 Oct 2017 19:11:34 +0100")
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>, Heiko Stuebner <heiko@sntech.de>, linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Geert Uytterhoeven <geert+renesas@glider.be> writes:

> There are no more users left of the gpd_dev_ops.active_wakeup()
> callback.  All have been converted to GENPD_FLAG_ACTIVE_WAKEUP.
> Hence remove the callback.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> This must not be applied before all users of active_wakup have been
> converted, hence the "RFC".


Reviewed-by: Kevin Hilman <khilman@baylibre.com>
