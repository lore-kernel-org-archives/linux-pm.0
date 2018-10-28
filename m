From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Subject: Re: [PATCH v5 04/11] dt-bindings: iio: adc: add AXP803 ADC bindings
Date: Sun, 28 Oct 2018 15:40:11 +0000
Message-ID: <20181028154011.04efdecf@archlinux>
References: <20181023185330.10472-1-oskari@lemmela.net>
        <20181023185330.10472-5-oskari@lemmela.net>
        <20181024135633.GA342@bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181024135633.GA342@bogus>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Oskari Lemmela <oskari@lemmela.net>, Linus Walleij <linus.walleij@linaro.org>, Sebastian Reichel <sre@kernel.org>, Lee Jones <lee.jones@linaro.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Vasily Khoruzhick <anarsoul@gmail.com>, Quentin Schulz <quentin.schulz@free-electrons.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, 24 Oct 2018 08:56:33 -0500
Rob Herring <robh@kernel.org> wrote:

> On Tue, 23 Oct 2018 21:53:23 +0300, Oskari Lemmela wrote:
> > The AXP803 ADC is compatible with AXP813 ADC, but add
> > specific compatible for it.
> > 
> > Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
> > ---
> >  Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt | 2 ++
> >  1 file changed, 2 insertions(+)
> >   
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

This doesn't seem to have any dependencies with the other patches
so applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to ignore.  However I am a little curious to know
why we would add the ID and then not use it (that I can see)?

Thanks,

Jonathan
