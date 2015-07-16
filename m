From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] gpio: rcar: Fine-grained Runtime PM support
Date: Thu, 16 Jul 2015 10:43:05 +0200
Message-ID: <CACRpkdagkFPVvU3Ox1YHhg9edzxPQyd6XddC1vLMj20HhAyY7A@mail.gmail.com>
References: <1435243557-7050-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1435243557-7050-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Alexandre Courbot <gnurou@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Jun 25, 2015 at 4:45 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> Currently gpio modules are runtime-resumed at probe time. This means the
> gpio module will be active all the time (except during system suspend,
> if not configured as a wake-up source).
>
> While an R-Car Gen2 gpio module retains pins configured for output at
> the requested level while put in standby mode, gpio registercannot be
> accessed while suspended.  Unfortunately pm_runtime_get_sync() cannot be
> called from all contexts where gpio register access is needed. Hence
> move the Runtime PM handling from probe/remove time to gpio request/free
> time, which is probably the best we can do.
>
> On r8a7791/koelsch, gpio modules 0, 1, 3, and 4 are now suspended during
> normal use (gpio2 is used for LEDs and regulators, gpio5 for keys, gpio6
> for SD-Card CD & WP, gpio7 for keys and regulators).
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Patch applied unless Magnus complains.

Yours,
Linus Walleij
