From: Kalle Valo <kvalo@codeaurora.org>
Subject: Re: [PATCH v7 00/10] support ROHM BD70528 PMIC
Date: Wed, 06 Feb 2019 20:31:32 +0200
Message-ID: <87o97ovke3.fsf@codeaurora.org>
References: <cover.1549444366.git.matti.vaittinen@fi.rohmeurope.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1549444366.git.matti.vaittinen@fi.rohmeurope.com> (Matti
        Vaittinen's message of "Wed, 6 Feb 2019 11:35:36 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: mazziesaccount@gmail.com, Guenter Roeck <linux@roeck-us.net>, heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com, lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, broonie@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, linus.walleij@linaro.org, bgolaszewski@baylibre.com, sre@kernel.org, lgirdwood@gmail.com, a.zummo@towertech.it, alexandre.belloni@bootlin.com, wim@linux-watchdog.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com> writes:

> Patch series introducing support for ROHM BD70528 PMIC
>
> Please note that patch 1 breaks compilation without patches 2 and 3
> Knowing the bd718x7 driver is already in upstream, it might be good
> if this change went through single tree, right?

That would break bisect, please avoid that. So after applying patches
from a patchset one by one the compilation should always succeed.

-- 
Kalle Valo
