From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 0/5] PM / Domains: Remove gpd_dev_ops.active_wakeup() callback
Date: Wed, 1 Nov 2017 11:10:21 +0100
Message-ID: <CAPDyKFoVnWKSGncWD6fxNLgbpuz-weJhqjgptEset2S8F2A6AA@mail.gmail.com>
References: <1509473494-19740-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1509473494-19740-1-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>, Heiko Stuebner <heiko@sntech.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-mediatek@lists.infradead.org, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 31 October 2017 at 19:11, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
>         Hi Rafael, Ulf, Kevin,
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
> Changes compared to v1 (most suggested by Ulf):
>   - Use the flag in se instead of setting up an "always true" callback,
>   - Convert the mediatek and rockchip PM Domain drivers,
>   - Remove the callback.
>
> If this idea is accepted, I think it would be good to still queue the first
> patch for v4.15.  That would allow the changes to the PM Domain drivers
> to go in through the respective platform trees in v4.16.
> Then the final patch has to be postponed until v4.17.
> Alternatively, everything can go in through the PM tree in one shot.

For the series:

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

It's easier if everything goes via Rafael's PM tree. Moreover, this
series is to me rather trivial, so I would actually recommend to pick
it all for 4.15. Mainly because, moving too slowly forward, allows new
users to show up of the callback you remove in patch5.

Kind regards
Uffe

>
> Thanks for your comments!
>
> Geert Uytterhoeven (5):
>   PM / Domains: Allow genpd users to specify default active wakeup
>     behavior
>   [RFC] ARM: shmobile: pm-rmobile: Use GENPD_FLAG_ACTIVE_WAKEUP
>   [RFC] soc: mediatek: Use GENPD_FLAG_ACTIVE_WAKEUP
>   [RFC] soc: rockchip: power-domain: Use GENPD_FLAG_ACTIVE_WAKEUP
>   [RFC] PM / Domains: Remove gpd_dev_ops.active_wakeup() callback
>
>  arch/arm/mach-shmobile/pm-rmobile.c |  8 +-------
>  drivers/base/power/domain.c         | 13 ++++---------
>  drivers/soc/mediatek/mtk-scpsys.c   | 14 ++------------
>  drivers/soc/rockchip/pm_domains.c   | 14 ++------------
>  include/linux/pm_domain.h           |  8 ++++----
>  5 files changed, 13 insertions(+), 44 deletions(-)
>
> --
> 2.7.4
>
> Gr{oetje,eeting}s,
>
>                                                 Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                                             -- Linus Torvalds
