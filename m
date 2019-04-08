From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH RFC] gpio: pca953x: Configure wake-up path when wake-up is enabled
Date: Mon, 8 Apr 2019 14:50:36 +0200
Message-ID: <CACRpkdaAZ8C-kmhWRMqu3y6yVJ--6UFjnoRi_iRtogwzzyGseQ@mail.gmail.com>
References: <20190320103927.21227-1-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190320103927.21227-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Mar 20, 2019 at 11:39 AM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> If a device is part of the wake-up path, it should indicate this by
> setting its power.wakeup_path field.  This allows the genpd core code to
> keep the device enabled during system suspend when needed.
>
> As regulators powering devices are not handled by genpd, the driver
> handles these itself, and thus must skip regulator control when the
> device is part of the wake-up path.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Patch applied with Ulf's Review tag.

If there are even better ways to do it I think we can fix that on top of
this, it is best to start with something that obviously works and
take it from there.

Yours,
Linus Walleij
