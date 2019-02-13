From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v9 3/8] clk: bd718x7: Support ROHM BD70528 clk block
Date: Wed, 13 Feb 2019 09:43:41 -0800
Message-ID: <155007982166.115909.16929990408175018819@swboyd.mtv.corp.google.com>
References: <cover.1550063882.git.matti.vaittinen@fi.rohmeurope.com> <f3d5163067e97426a9bb00991d200f04bcd0058b.1550063882.git.matti.vaittinen@fi.rohmeurope.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f3d5163067e97426a9bb00991d200f04bcd0058b.1550063882.git.matti.vaittinen@fi.rohmeurope.com>
Sender: linux-kernel-owner@vger.kernel.org
To: matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc: Guenter Roeck <linux@roeck-us.net>, heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com, lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, broonie@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org, mturquette@baylibre.com, linus.walleij@linaro.org, bgolaszewski@baylibre.com, sre@kernel.org, lgirdwood@gmail.com, a.zummo@towertech.it, alexandre.belloni@bootlin.com, wim@linux-watchdog.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Quoting Matti Vaittinen (2019-02-13 05:29:55)
> ROHM BD70528 is an ultra low power PMIC with similar 32K clk as
> bd718x7. Only difference (from clk perspective) is register address.
> Add support for controlling BD70528 clk using bd718x7 driver.
>=20
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
