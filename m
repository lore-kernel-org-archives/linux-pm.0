From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v7 03/10] clk: bd718x7: use chip specific and generic data structs
Date: Wed, 06 Feb 2019 09:30:47 -0800
Message-ID: <154947424775.74891.14167975959188860194@swboyd.mtv.corp.google.com>
References: <cover.1549444366.git.matti.vaittinen@fi.rohmeurope.com> <d30e869929638cb4907e52222124df8250b0980c.1549444366.git.matti.vaittinen@fi.rohmeurope.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d30e869929638cb4907e52222124df8250b0980c.1549444366.git.matti.vaittinen@fi.rohmeurope.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, mazziesaccount@gmail.com
Cc: Guenter Roeck <linux@roeck-us.net>, heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com, lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, broonie@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org, mturquette@baylibre.com, linus.walleij@linaro.org, bgolaszewski@baylibre.com, sre@kernel.org, lgirdwood@gmail.com, a.zummo@towertech.it, alexandre.belloni@bootlin.com, wim@linux-watchdog.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Quoting Matti Vaittinen (2019-02-06 01:38:54)
> Header rohm-bd718x7.h was split to generic and component specific
> parts. This changed the struct bd718x7. Adapt the clk driver to
> these changes.
>=20
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
