From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH v2 4/5] [RFC] soc: rockchip: power-domain: Use GENPD_FLAG_ACTIVE_WAKEUP
Date: Thu, 02 Nov 2017 10:51:27 +0100
Message-ID: <1719851.1v65Il0leT@diego>
References: <1509473494-19740-1-git-send-email-geert+renesas@glider.be> <1509473494-19740-5-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1509473494-19740-5-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@kernel.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>, linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Am Dienstag, 31. Oktober 2017, 19:11:33 CET schrieb Geert Uytterhoeven:
> Set the newly introduced GENPD_FLAG_ACTIVE_WAKEUP, which allows to
> remove the driver's own flag-based callback.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

looks ok, so
Acked-by: Heiko Stuebner <heiko@sntech.de>
