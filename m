From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 3/3] PM / Domains: Take WAKEUP_POWERED driver flag into account
Date: Wed, 8 Nov 2017 16:32:23 +0100
Message-ID: <CAMuHMdXW8JCzAA62iV=D-q4pc8pxdDKYC84hNs0BO_LfdBzUUA@mail.gmail.com>
References: <1510154134-1248-1-git-send-email-ulf.hansson@linaro.org> <1510154134-1248-4-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1510154134-1248-4-git-send-email-ulf.hansson@linaro.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms@verge.net.au>, Niklas Soderlund <niklas.soderlund+renesas@ragnatech.se>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Nov 8, 2017 at 4:15 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> Make genpd to take the WAKEUP_POWERED driver flag into account during
> system suspend/resume. More precisely, in case the WAKEUP_POWERED flag is
> set, let's leave the device in full power state and prevent the PM domain
> from being powered off.
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
