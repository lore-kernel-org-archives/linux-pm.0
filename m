From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 1/2] devicetree: power: add bindings for GPIO-driven power switches
Date: Thu, 15 Dec 2016 11:57:18 +0100
Message-ID: <CAMpxmJVwgHGrywDFnE9dNfB9UL89hLyiRO2He7uyiRgBpEfjkg@mail.gmail.com>
References: <1481494905-18037-1-git-send-email-bgolaszewski@baylibre.com>
 <1481494905-18037-2-git-send-email-bgolaszewski@baylibre.com>
 <20161213192712.gbaw4t4awayybnta@rob-hp-laptop> <CAMpxmJWw3wCE4ch8TVik+2b3BC8Lvxbi13HGd9GxruSRLu95Mg@mail.gmail.com>
 <54679B04-3A57-4F0E-8EE6-BB37785F8E10@jic23.retrosnub.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54679B04-3A57-4F0E-8EE6-BB37785F8E10@jic23.retrosnub.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc: Rob Herring <robh@kernel.org>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org, linux-devicetree <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Kevin Hilman <khilman@baylibre.com>, Patrick Titiano <ptitiano@baylibre.com>, Neil Armstrong <narmstrong@baylibre.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio <linux-gpio@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, linux-pm <linux-pm@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: linux-pm@vger.kernel.org

2016-12-14 18:36 GMT+01:00 Jonathan Cameron <jic23@jic23.retrosnub.co.uk>:
>
>
> On 14 December 2016 16:58:21 GMT+00:00, Bartosz Golaszewski
> <bgolaszewski@baylibre.com> wrote:
>>2016-12-13 20:27 GMT+01:00 Rob Herring <robh@kernel.org>:
>>> On Sun, Dec 11, 2016 at 11:21:44PM +0100, Bartosz Golaszewski wrote:
>>>> Some boards are equipped with simple, GPIO-driven power load
>>switches.
>>>> An example of such ICs is the TI tps229* series.
>>>
>>> How is this different than a GPIO regulator? The input and output
>>> voltages just happen to be the same. I could be convinced this is
>>> different enough to have a different compatible, but it somewhat
>>seems
>>> you want to use this for IIO, so you are creating a different binding
>>> for that usecase.
>>>
>>
>>It's more of a fixed regulator I suppose. Do you mean adding a new
>>compatible to the fixed-regulator binding (e.g. "gpio-power-switch" or
>>"simple-power-switch") and then providing an iio driver for toggling
>>the switch?
>
> I am rather torn on whether the IIO interface makes any sense beyond that of
> convenience.
>

The question is: will the iio maintainers be ok with adding support
for interfaces different than iio (I guess so since Lars already
mentioned wanting to support the GPIO chardev)? If so, I'm ok with not
using the iio framework in the kernel.

> A bridge to a regulator in general might make sense to cover the case of a
> reg effectively
> acting as a DAC at the edge of the known hardware.
>
> Lars' point about perhaps adding support for the new gpio userspace stuff to
> libiio would in
> this case also be rather papering over the issue.
> There is known hardware there so we should describe it!
>
> I think we should be considering this as the general case of the Linux
> controlled power supply.
> How do we want to represent that?
> Ultimately does a general regulator userspace interface make sense?
>
> Classic case of people cutting our hardware in half and making boundaries
> beyond which lie dragons.
>
> I would love to see the general case covered.
>

It seems as if this is already covered by the userspace-consumer
regulator driver, but it doesn't speak device tree yet. I guess we
could reuse it by merging the proposed gpio-power-switch binding and
extending it to parse DT.

Best regards,
Bartosz Golaszewski
