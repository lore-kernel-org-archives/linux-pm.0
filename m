From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/3] PM / core: Re-factor some code dealing with parents
 in __device_suspend()
Date: Wed, 8 Nov 2017 16:26:18 +0100
Message-ID: <CAMuHMdUhPTwXGD4ay34VxYoxuJPJDujy0CMMd5MNuR=HfESTZg@mail.gmail.com>
References: <1510154134-1248-1-git-send-email-ulf.hansson@linaro.org> <1510154134-1248-2-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1510154134-1248-2-git-send-email-ulf.hansson@linaro.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms@verge.net.au>, Niklas Soderlund <niklas.soderlund+renesas@ragnatech.se>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Nov 8, 2017 at 4:15 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> Let's make the code a bit more readable by moving some of the code, which
> deals with adjustments for parent devices in __device_suspend(), into its
> own function.
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
