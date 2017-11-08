From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 0/5] PM / Domains: Remove gpd_dev_ops.active_wakeup() callback
Date: Wed, 08 Nov 2017 01:17:27 +0100
Message-ID: <2130215.VAlC8oaDc3@aspire.rjw.lan>
References: <1510058895-21712-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1510058895-21712-1-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>, Heiko Stuebner <heiko@sntech.de>, linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, November 7, 2017 1:48:10 PM CET Geert Uytterhoeven wrote:
> 	Hi Rafael, Ulf, Kevin,
> 
> It is quite common for PM Domains to require slave devices to be kept
> active during system suspend if they are to be used as wakeup sources.
> To enable this, currently each PM Domain or driver has to provide its
> own gpd_dev_ops.active_wakeup() callback.
> 
> All existing callbacks either return always true, or a fixed value
> depending on the PM Domain.
> 
> Hence this patch series simplifies active wakeup handling by replacing
> the callback by a flag:
>   - Patch 1 adds a new new flag GENPD_FLAG_ACTIVE_WAKEUP, to be set by
>     PM Domain drivers that want to use the new handling,
>   - Patches 2-4 convert all existing users of the callback to the new
>     flag,
>   - Patch 5 removes the callback.
> 
> This series was extracted from "[PATCH 00/10] PM / Domain: renesas: Fix
> active wakeup behavior", and retains only PM Domain changes to existing
> drivers.
> 
> Changes compared to v2:
>   - Add Acked-by, Reviewed-by,
>   - Drop RFC status from dependent patches, as everything can go in
>     through the pm tree.
> 
> Changes compared to v1 (most suggested by Ulf):
>   - Use the flag in se instead of setting up an "always true" callback,
>   - Convert the mediatek and rockchip PM Domain drivers,
>   - Remove the callback.
> 
> Thanks for applying for v4.15!

Queued up for 4.15, thanks!

Rafael
