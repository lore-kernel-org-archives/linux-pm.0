From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 3/8] mfd: axp20x: probe axp20x_adc driver for AXP813
Date: Sun, 10 Dec 2017 16:40:27 +0000
Message-ID: <20171210164027.7ad5bd6c@archlinux>
References: <cover.4052f8c517c42db26a3cabe078cad333243d371c.1512396054.git-series.quentin.schulz@free-electrons.com>
        <302c93023d8c4a54cafe321d912df484e39727b7.1512396054.git-series.quentin.schulz@free-electrons.com>
        <20171205080855.arr7vlgnxoxmyedd@flea.lan>
        <2021a653-d01e-f46f-2438-0760f579e0dc@free-electrons.com>
        <CAGb2v67nD+WAEEyridP1K=k_KgBprWmbNNL7FPdZWv9ZYdrjJg@mail.gmail.com>
        <41fcadb9-4fa9-65e8-5ef3-5844bcba1b1d@free-electrons.com>
        <CAGb2v66esOimRhDHL6QgYU3iWg2a6JiQm__0ivv3SdnQv=SGQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751726AbdLJQke (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 10 Dec 2017 11:40:34 -0500
In-Reply-To: <CAGb2v66esOimRhDHL6QgYU3iWg2a6JiQm__0ivv3SdnQv=SGQg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, Lee Jones <lee.jones@linaro.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, "open list:THERMAL" <linux-pm@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-iio@vger.kernel.org, Icenowy Zheng <icenowy@aosc.io>, linux-sunxi <linux-sunxi@googlegroups.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

On Thu, 7 Dec 2017 17:14:30 +0800
Chen-Yu Tsai <wens@csie.org> wrote:

> On Thu, Dec 7, 2017 at 5:03 PM, Quentin Schulz
> <quentin.schulz@free-electrons.com> wrote:
> > Hi Chen-Yu,
> >
> > On 07/12/2017 09:54, Chen-Yu Tsai wrote:  
> >> On Thu, Dec 7, 2017 at 4:51 PM, Quentin Schulz
> >> <quentin.schulz@free-electrons.com> wrote:  
> >>> Hi Maxime,
> >>>
> >>> On 05/12/2017 09:08, Maxime Ripard wrote:  
> >>>> On Mon, Dec 04, 2017 at 03:12:49PM +0100, Quentin Schulz wrote:  
> >>>>> This makes the axp20x_adc driver probe with platform device id
> >>>>> "axp813-adc".
> >>>>>
> >>>>> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> >>>>> ---
> >>>>>  drivers/mfd/axp20x.c | 4 +++-
> >>>>>  1 file changed, 3 insertions(+), 1 deletion(-)
> >>>>>
> >>>>> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> >>>>> index 2468b43..42e54d1 100644
> >>>>> --- a/drivers/mfd/axp20x.c
> >>>>> +++ b/drivers/mfd/axp20x.c
> >>>>> @@ -878,7 +878,9 @@ static struct mfd_cell axp813_cells[] = {
> >>>>>              .resources              = axp803_pek_resources,
> >>>>>      }, {
> >>>>>              .name                   = "axp20x-regulator",
> >>>>> -    }
> >>>>> +    }, {
> >>>>> +            .name                   = "axp813-adc",
> >>>>> +    },  
> >>>>
> >>>> Any particular reason you're not adding it to the DT?
> >>>>  
> >>>
> >>> No, no particular reason. It's just the way it is currently for AXP209
> >>> and AXP22x so did the same for AXP813.
> >>>
> >>> I'll add DT "support" in next version for all AXPs supported by this
> >>> driver. Or is it worthy of a small separate patch series?  
> >>
> >> IIRC there's no DT support because there's no need to reference
> >> it in the device tree.
> >>  
> >
> > No current need but that does not mean there won't be a need later for
> > drivers to map IIO channels from the ADC driver (i.e. some components
> > wired to GPIOs of the PMIC for example).  
> 
> Hmm... Why would you map the IIO channels from the ADC? I thought those
> were all accessible from userspace?

There is a reasonably fully featured consumer interface for IIO channels
as well. Here it's being used internal to the hardware, but yes if
you want to do the mappings to other devices, it will need to 'exist'
in the device tree.

I'm guessing that you have something in mind that needs this.  If not I'd
leave it until there is a real user.

> 
> However, proper muxing of the GPIO pin to the ADC function makes sense.
> 
Agreed.

Jonathan

> ChenYu
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
