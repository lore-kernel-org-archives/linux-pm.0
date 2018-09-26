From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 1/4] power: supply: core: Introduce one property to
 present the battery internal resistance
Date: Wed, 26 Sep 2018 10:00:33 +0200
Message-ID: <CACRpkdY3YsXsJy0OwGYLuB+x32hbkAHum4w5KQTCGoi-OXt-QA@mail.gmail.com>
References: <358665e3f4f9ec105dc2f8a2dc6dd98dbe761fae.1537930252.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <358665e3f4f9ec105dc2f8a2dc6dd98dbe761fae.1537930252.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linux PM list <linux-pm@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, yuanjiang.yu@unisoc.com, Mark Brown <broonie@kernel.org>, Craig Tatlor <ctatlor97@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Sep 26, 2018 at 4:59 AM Baolin Wang <baolin.wang@linaro.org> wrote:

> Introduce one property to present the battery internal resistance for battery
> information.
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
> Changes from v1:
>  - New patch in v2.

I'm a bit confused by the physics in this patch.

The internal resistance of a battery is not a constant in its life cycle,
this varies over the age of the battery, and the reason I thing is
chemical residuals accumulating on the anode and cathode inside
the battery and the energy storage medium aging. (Plus/minus my
ignorance about how batteries actually work.)

AFAIK the fact that the internal resistance varies is of high
importance for people developing algorithms of battery capacity
and longevity. Such that some (hardware) capacity monitors go
to great lengths to measure with high precision the current
internal resistance of the battery for their algorithms.

Sorry for making things more complex, but should it be named
"factory-internal-resistance-micro-ohms" or
"typical-internal-resistance-micro-ohms"?

Yours,
Linus Walleij
