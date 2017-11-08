From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/3] PM / core: Add WAKEUP_POWERED driver flag
Date: Wed, 8 Nov 2017 16:32:08 +0100
Message-ID: <CAMuHMdX0CKJYrw56KN2+vfUmCuQgbr7pHL1qWBciX9jXjVo3+Q@mail.gmail.com>
References: <1510154134-1248-1-git-send-email-ulf.hansson@linaro.org> <1510154134-1248-3-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1510154134-1248-3-git-send-email-ulf.hansson@linaro.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms@verge.net.au>, Niklas Soderlund <niklas.soderlund+renesas@ragnatech.se>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Nov 8, 2017 at 4:15 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> For some bus types and PM domains, it's not sufficient to only check the
> return value from device_may_wakeup(), to fully understand how to treat the
> device during system suspend.
>
> In particular, sometimes the device may need to stay in full power state,
> to have wakeup signals enabled for it. Therefore, define and document a
> WAKEUP_POWERED flag, to enable drivers to instruct bus types and PM domains
> exactly about that.
>
> During __device_suspend() in the PM core, let's make sure to also propagate
> the setting of the flag to the parent device, when wakeup signals are
> enabled and unless the parent has the "ignore_children" flag set. This
> makes it also consistent with how the existing "wakeup_path" flag is being
> assigned.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
