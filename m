From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 1/2] devicetree: power: add bindings for GPIO-driven power
 switches
Date: Fri, 30 Dec 2016 15:03:06 +0000
Message-ID: <5bbedbb7-2391-c927-deab-75fd9fffe7f6@kernel.org>
References: <1481494905-18037-1-git-send-email-bgolaszewski@baylibre.com>
 <1481494905-18037-2-git-send-email-bgolaszewski@baylibre.com>
 <20161213192712.gbaw4t4awayybnta@rob-hp-laptop>
 <CAMpxmJWw3wCE4ch8TVik+2b3BC8Lvxbi13HGd9GxruSRLu95Mg@mail.gmail.com>
 <CAL_JsqLwS51MhOJQb-Lmo=osHiYKcAcCJaxKJFdSvZBpafz7Gw@mail.gmail.com>
 <CAMuHMdWfAwPE2N-_0WhW5+EEK3bqWoo9HpQZTgLzRRutCg++qg@mail.gmail.com>
 <505b7c02-e7dd-b0a5-8009-dca9101b0dd4@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <505b7c02-e7dd-b0a5-8009-dca9101b0dd4@metafoo.de>
Sender: linux-gpio-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Rob Herring <robh@kernel.org>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>, Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Mark Rutland <mark.rutland@arm.com>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, linux-devicetree <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Kevin Hilman <khilman@baylibre.com>, Patrick Titiano <ptitiano@baylibre.com>, Neil Armstrong <narmstrong@baylibre.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio <linux-gpio@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, linux-pm <linux-pm@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: linux-pm@vger.kernel.org

On 23/12/16 11:40, Lars-Peter Clausen wrote:
> On 12/23/2016 10:07 AM, Geert Uytterhoeven wrote:
>> BTW, I'm not an IIO expert, but from my limited knowledge, it looks like "O"
>> support in IIO is limited to DACs?
> 
> Depends on what you categorize as DACs. There are also
> potentiometer/rheostat drivers. They are kind of like DACs but the unit you
> control are ohm, rather than current or voltage.
Though they are still in staging there are also things like function generators.

I've been mulling doing a driver for the st-powerstep01 parts as well which
is a smart stepper motor controller.  At that level we'd need to start describing
the connected stepper motors in DT :) Whole chunk of API to define to do that
though - might well take longer than writing the driver.

So in practice yeah - dac like things, but then on the input side they are almost
all really ADCs with some funny analog stuff on the front end ;)

Arguably switches are 1 bit DACs ;)

The distinction here is whether 'what is passing through' the device is knowable.
So regulators and your power switch are well described.  A relay less so unless
we know what load it is switching...

+ it's IIO.  We are open to almost anything as long as we aren't stepping on
any toes!

Jonathan

> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

