From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH v5 04/11] dt-bindings: iio: adc: add AXP803 ADC bindings
Date: Mon, 5 Nov 2018 13:47:50 +0800
Message-ID: <CAGb2v66mH5_J0K4ArFduvvQ2aE7mZxcyLORNPODj79-xhiKapQ@mail.gmail.com>
References: <20181023185330.10472-1-oskari@lemmela.net> <20181023185330.10472-5-oskari@lemmela.net>
 <20181024135633.GA342@bogus> <20181028154011.04efdecf@archlinux>
 <20181029130757.m5okrfvusjl5fu5m@qschulz> <CAGb2v65JKj_7VcEr1KuZVop85hn-3h73NrExprpmLbKZiosD5Q@mail.gmail.com>
 <20181103102153.4f0481ad@archlinux>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181103102153.4f0481ad@archlinux>
Sender: linux-kernel-owner@vger.kernel.org
To: jic23@jic23.retrosnub.co.uk
Cc: Rob Herring <robh@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, "open list:THERMAL" <linux-pm@vger.kernel.org>, linux-iio@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Sebastian Reichel <sre@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Vasily Khoruzhick <anarsoul@gmail.com>, Quentin Schulz <quentin.schulz@free-electrons.com>, devicetree <devicetree@vger.kernel.org>, oskari@lemmela.net, linux-gpio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>, Lee Jones <lee.jones@linaro.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Quentin Schulz <quentin.schulz@bootlin.com>
List-Id: linux-pm@vger.kernel.org

On Sat, Nov 3, 2018 at 6:22 PM Jonathan Cameron
<jic23@jic23.retrosnub.co.uk> wrote:
>
> On Wed, 31 Oct 2018 10:29:59 +0800
> Chen-Yu Tsai <wens@csie.org> wrote:
>
> > On Mon, Oct 29, 2018 at 9:10 PM Quentin Schulz
> > <quentin.schulz@bootlin.com> wrote:
> > >
> > > Hi Jonathan,
> > >
> > > On Sun, Oct 28, 2018 at 03:40:11PM +0000, Jonathan Cameron wrote:
> > > > On Wed, 24 Oct 2018 08:56:33 -0500
> > > > Rob Herring <robh@kernel.org> wrote:
> > > >
> > > > > On Tue, 23 Oct 2018 21:53:23 +0300, Oskari Lemmela wrote:
> > > > > > The AXP803 ADC is compatible with AXP813 ADC, but add
> > > > > > specific compatible for it.
> > > > > >
> > > > > > Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
> > > > > > ---
> > > > > >  Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt | 2 ++
> > > > > >  1 file changed, 2 insertions(+)
> > > > > >
> > > > >
> > > > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > >
> > > > This doesn't seem to have any dependencies with the other patches
> > > > so applied to the togreg branch of iio.git and pushed out as testing
> > > > for the autobuilders to ignore.  However I am a little curious to know
> > > > why we would add the ID and then not use it (that I can see)?
> > > >
> > >
> > > Sometimes with Allwinner (and X-Powers), two IPs seem identical until we
> > > discover something that is slightly different. When this happens, we
> > > have to add a compatible to differentiate both. However, we would also
> > > need to change the Device Tree to change the compatible. We would need
> > > to handle the driver behaviour for both Device Trees.
> > >
> > > So better anticipate a possible difference so that we don't have to do
> > > some hacks in the driver to handle the device correctly.
> > >
> > > As always, Chen-Yu or Maxime may know better so I'm just stating what I
> > > seem to recall.
> >
> > With Allwinner stuff (X-Powers included), sometimes the documents are
> > incomplete or have errors. We tend to add a model-specific compatible
> > just in case things turn out not to be so compatible, unless someone
> > has triple-checked everything, documents and actual hardware included.
> >
> > However we don't actually document these, so this patch isn't strictly
> > needed. (I suppose this might annoy the device tree binding maintainers.)
> >
> > ChenYu
> I don't think it does any harm so I'll leave it in place.  Thanks for
> the explanations.

It might cause a bit of confusion though. We are not targetting these
compatibles in terms of driver support, and they should not be used
individually. IMO dropping this patch altogether is better. In the
device tree we would use the tuplet axp803 + axp813.

ChenYu
