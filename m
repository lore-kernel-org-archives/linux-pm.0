From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/2] iio: misc: add support for GPIO power switches
Date: Wed, 28 Dec 2016 13:50:17 +0100
Message-ID: <CACRpkdZ7JrNfCKPuuCmkZd_7+NV0QLUN8ZMukFA0TcqS9SYXcQ@mail.gmail.com>
References: <1481494905-18037-1-git-send-email-bgolaszewski@baylibre.com> <1481494905-18037-3-git-send-email-bgolaszewski@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1481494905-18037-3-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Kevin Hilman <khilman@baylibre.com>, Patrick Titiano <ptitiano@baylibre.com>, Neil Armstrong <narmstrong@baylibre.com>, Alexandre Courbot <gnurou@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Mark Brown <broonie@kernel.org>Liam Girdwood <l>
List-Id: linux-pm@vger.kernel.org

On Sun, Dec 11, 2016 at 11:21 PM, Bartosz Golaszewski
<bgolaszewski@baylibre.com> wrote:

> Some power-measuring ADCs work together with power load switches which
> allow to power-cycle measured devices.
>
> An example use case would be measuring the power consumption of a
> development board during boot using a power monitor such as TI INA226
> and power-cycling the board remotely using a TPS229* power switch.
>
> Add an iio driver for simple GPIO power switches and expose a sysfs
> attribute allowing to toggle their state.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

I don't get this, isn't this doing the same as
drivers/power/reset/gpio-poweroff.c
?

With the only difference that the latter uses the standard syscall
from pm_power_off to reboot the system instead of some random
sysfs file.

Yours,
Linus Walleij
