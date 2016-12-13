From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/2] devicetree: power: add bindings for GPIO-driven
 power switches
Date: Tue, 13 Dec 2016 13:27:12 -0600
Message-ID: <20161213192712.gbaw4t4awayybnta@rob-hp-laptop>
References: <1481494905-18037-1-git-send-email-bgolaszewski@baylibre.com>
 <1481494905-18037-2-git-send-email-bgolaszewski@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1481494905-18037-2-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>, Patrick Titiano <ptitiano@baylibre.com>, Neil Armstrong <narmstrong@baylibre.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Sun, Dec 11, 2016 at 11:21:44PM +0100, Bartosz Golaszewski wrote:
> Some boards are equipped with simple, GPIO-driven power load switches.
> An example of such ICs is the TI tps229* series.

How is this different than a GPIO regulator? The input and output 
voltages just happen to be the same. I could be convinced this is 
different enough to have a different compatible, but it somewhat seems 
you want to use this for IIO, so you are creating a different binding 
for that usecase.

Rob
