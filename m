From: Jonathan Cameron <Jonathan.Cameron-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/8] iio: adc: axp20x_adc: add support for AXP813 ADC
Date: Tue, 12 Dec 2017 15:12:32 +0000
Message-ID: <20171212151232.00006fd0@huawei.com>
References: <cover.4052f8c517c42db26a3cabe078cad333243d371c.1512396054.git-series.quentin.schulz@free-electrons.com>
        <ef830ce470a4f0f4be6040a776b6928bf89c0143.1512396054.git-series.quentin.schulz@free-electrons.com>
        <20171210163655.43fbd3c0@archlinux>
        <b2cdd796-5c22-c114-bc74-41b900a05464@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <b2cdd796-5c22-c114-bc74-41b900a05464-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, knaack.h-Mmb7MZpHnFY@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, icenowy-h8G6r0blFSE@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Mon, 11 Dec 2017 09:18:55 +0100
Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:

> Hi Jonathan,
> 
> On 10/12/2017 17:36, Jonathan Cameron wrote:
> > On Mon,  4 Dec 2017 15:12:48 +0100
> > Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
> >   
> >> The X-Powers AXP813 PMIC is really close to what is already done for
> >> AXP20X/AXP22X.
> >>
> >> There are two pairs of bits to set the rate (one for Voltage and Current
> >> measurements and one for TS/GPIO0 voltage measurements) instead of one.  
> > 
> > This would normally imply we need to split the device into two logical
> > IIO devices.  However, that only becomes relevant if we are using
> > buffered output which this driver doesn't support.  
> > > It'll be nasty to deal with this if we add that support down the line  
> > though.  Up to you though as it's more likely to be your problem than
> > anyone else's :)
> >   
> 
> I have no plans for supporting buffered output for the AXPs at the
> moment. But that's an interesting (and important) limitation to raise.
> Wouldn't be more of a hack to have two IIO devices representing the
> actual same IP?

We have thought about allowing multiple buffers from a single IIO device
but that makes for some horrible changes to the ABI - so as things stand
the only option is two devices for one IP.  Ultimately they aren't really
two devices - in the same way we have triggers separating registered on
the IIO bus (often many of them).  Just two different elements of the same IP.

> 
> > For now you could elect to support the different sampling frequencies
> > if you wanted to but just providing controls for each channel.
> >   
> 
> I guess that you're offering to use IIO_CHAN_INFO_SAMP_FREQ in
> info_mask_separate for each channel?
Yes
> 
> > Given the driver doesn't currently expose these at all (I think)
> > this is all rather immaterial ;)  
> 
> I'm not giving the user the option to chose the sampling frequency for
> now. I have no plans to do it either, but I think it would be rather
> simple to later add support for setting frequency sampling since we only
> need to add a sysfs entry (with IIO_CHAN_INFO_SAMP_FREQ) that does not
> exist yet. Don't you think? Am I missing something?
No should be straight forward as long as we keep clear of the buffered
interfaces with their limitations.

> 
> Thanks,
> Quentin
