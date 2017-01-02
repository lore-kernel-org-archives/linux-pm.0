From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/2] iio: misc: add support for GPIO power switches
Date: Mon, 2 Jan 2017 22:53:54 +0100
Message-ID: <CACRpkdZRGygeNjK=mujT-veCW+oC_vEED9Z0fSiMxFrDT0hqzA@mail.gmail.com>
References: <1481494905-18037-1-git-send-email-bgolaszewski@baylibre.com>
 <1481494905-18037-3-git-send-email-bgolaszewski@baylibre.com>
 <CACRpkdZ7JrNfCKPuuCmkZd_7+NV0QLUN8ZMukFA0TcqS9SYXcQ@mail.gmail.com>
 <20161229162919.j2ej2cyeuoqnxykf@earth> <CACRpkdbjbtFwwQCdR3krWG0P4UMhWySTTkzqZFBZ6EGXPS=k8g@mail.gmail.com>
 <0c3511be-6a3c-f65c-c562-1c4b9318acb1@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0c3511be-6a3c-f65c-c562-1c4b9318acb1@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Cameron <jic23@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Kevin Hilman <khilman@baylibre.com>, Patrick Titiano <ptitiano@baylibre.com>, Neil Armstrong <narmstrong@baylibre.com>, Alexandre Courbot <gnurou@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Liam
List-Id: linux-pm@vger.kernel.org

On Fri, Dec 30, 2016 at 4:15 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 30/12/16 13:05, Linus Walleij wrote:

>> So this needs to be re-architected to either describe the remote system
>> in DT and handle it in the kernel, or handle it all from userspace if it
>> is a one-off non-product thing.
>
> I'm not sure this is always true (though it might be here).  There is always
> a need to describe the edge of the known world.  Be it that we have
> an accelerometer - ultimately we could describe the device generating the
> acceleration but we have no way of knowing what it is or what it will do..
>
> What we have here is a rather simple case, but what about an I/O bank on
> a PLC.  Obviously we can handle that as a bunch of GPIOs but if we know
> more about it we should have means to describe that.  Say we know they are
> always driving relays, we should be able to describe that additional known
> stuff. Relays have characteristics such as bounce times etc that if described
> would allow us to do the relevant filtering on inputs to handle this.
>
> Here the fact it is a power supply switch should be describable.  Hard to
> get right in a generic way though so in cases like this perhaps you
> are right and it should just be left undescribed and handled in userspace.
>
> Anyhow, here I think leaving it as a gpio interface is probably the way to
> go, but I'm not sure that will always be the case.

No you are right. We are at the fuzzy system perimeter.

For GPIO we currently only have asserted/unasserted, polarity
of that, open drain/source and debounce time. But we will need the whole
slew of pin control settings in the future: drive strength, schmitt-trigger
hysteresis etc etc. And if there is a further component beyond that it
may need a driver in turn even if it is "only" a relay.

Let's see about this one...

Yours,
Linus Walleij
