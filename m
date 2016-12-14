From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 1/2] devicetree: power: add bindings for GPIO-driven power switches
Date: Wed, 14 Dec 2016 17:58:21 +0100
Message-ID: <CAMpxmJWw3wCE4ch8TVik+2b3BC8Lvxbi13HGd9GxruSRLu95Mg@mail.gmail.com>
References: <1481494905-18037-1-git-send-email-bgolaszewski@baylibre.com>
 <1481494905-18037-2-git-send-email-bgolaszewski@baylibre.com> <20161213192712.gbaw4t4awayybnta@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f172.google.com ([209.85.223.172]:34258 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756215AbcLNQ6c (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Dec 2016 11:58:32 -0500
Received: by mail-io0-f172.google.com with SMTP id p42so45552510ioo.1
        for <linux-pm@vger.kernel.org>; Wed, 14 Dec 2016 08:58:23 -0800 (PST)
In-Reply-To: <20161213192712.gbaw4t4awayybnta@rob-hp-laptop>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org, linux-devicetree <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Kevin Hilman <khilman@baylibre.com>, Patrick Titiano <ptitiano@baylibre.com>, Neil Armstrong <narmstrong@baylibre.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio <linux-gpio@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, linux-pm <linux-pm@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>

2016-12-13 20:27 GMT+01:00 Rob Herring <robh@kernel.org>:
> On Sun, Dec 11, 2016 at 11:21:44PM +0100, Bartosz Golaszewski wrote:
>> Some boards are equipped with simple, GPIO-driven power load switches.
>> An example of such ICs is the TI tps229* series.
>
> How is this different than a GPIO regulator? The input and output
> voltages just happen to be the same. I could be convinced this is
> different enough to have a different compatible, but it somewhat seems
> you want to use this for IIO, so you are creating a different binding
> for that usecase.
>

It's more of a fixed regulator I suppose. Do you mean adding a new
compatible to the fixed-regulator binding (e.g. "gpio-power-switch" or
"simple-power-switch") and then providing an iio driver for toggling
the switch?

Thanks,
Bartosz
