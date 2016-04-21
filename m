From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] thermal: rcar_thermal: Fix priv->zone error handling
Date: Thu, 21 Apr 2016 15:00:53 +0200
Message-ID: <CAMuHMdWDnHDrf8d1nY0M6bY_z1sJfHbTM15QoP+dpfTJkCDrWA@mail.gmail.com>
References: <1461234295-30521-1-git-send-email-dirk.behme@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1461234295-30521-1-git-send-email-dirk.behme@de.bosch.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Dirk Behme <dirk.behme@de.bosch.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-renesas-soc@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Apr 21, 2016 at 12:24 PM, Dirk Behme <dirk.behme@de.bosch.com> wrote:
> In case thermal_zone_xxx_register() returns an error, priv->zone
> isn't NULL any more, but contains the error code.
>
> This is passed to thermal_zone_device_unregister(), then. This checks
> for priv->zone being NULL, but the error code is != NULL. So it works
> with the error code as a pointer. Crashing immediately.
>
> To fix this, reset priv->zone to NULL before entering
> rcar_gen3_thermal_remove().

Alternatively, you could prevent a non-valid zone pointer from ever
ending up in priv->zone by assigning the zone to a temporary variable,
and only storing that in priv->zone after the error check.

> Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>

Regardless of the above
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
