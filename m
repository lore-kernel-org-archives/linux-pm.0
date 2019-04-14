From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Subject: Re: [PATCH v2 2/4] iio: inkern: Convert iio_read_avail_channel_raw
 into a wrapper
Date: Sun, 14 Apr 2019 11:35:42 +0100
Message-ID: <20190414113542.27e1831f@archlinux>
References: <20190323172809.14407-1-contact@artur-rojek.eu>
        <20190323172809.14407-2-contact@artur-rojek.eu>
        <20190324152750.43edf737@archlinux>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190324152750.43edf737@archlinux>
Sender: linux-kernel-owner@vger.kernel.org
To: Artur Rojek <contact@artur-rojek.eu>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
List-Id: linux-pm@vger.kernel.org

On Sun, 24 Mar 2019 15:27:50 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Sat, 23 Mar 2019 18:28:07 +0100
> Artur Rojek <contact@artur-rojek.eu> wrote:
> 
> > Convert "iio_read_avail_channel_raw" over to a wrapper around
> > "iio_read_avail_channel_attribute".
> > 
> > With the introduction of "iio_read_avail_channel_attribute",
> > the necessity of having a separate call to read raw channel values
> > became redundant.
> > 
> > Signed-off-by: Artur Rojek <contact@artur-rojek.eu>  
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Applied to the ib-jz47xx-battery-prereq branch of iio.git

Thanks,

Jonathan

> 
> > ---
> > 
> > Changes:
> > 
> > v2: new patch
> > 
> >  drivers/iio/inkern.c | 12 ++----------
> >  1 file changed, 2 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> > index f19dbde3c945..4a5eff3f18bc 100644
> > --- a/drivers/iio/inkern.c
> > +++ b/drivers/iio/inkern.c
> > @@ -759,16 +759,8 @@ int iio_read_avail_channel_raw(struct iio_channel *chan,
> >  	int ret;
> >  	int type;
> >  
> > -	mutex_lock(&chan->indio_dev->info_exist_lock);
> > -	if (!chan->indio_dev->info) {
> > -		ret = -ENODEV;
> > -		goto err_unlock;
> > -	}
> > -
> > -	ret = iio_channel_read_avail(chan,
> > -				     vals, &type, length, IIO_CHAN_INFO_RAW);
> > -err_unlock:
> > -	mutex_unlock(&chan->indio_dev->info_exist_lock);
> > +	ret = iio_read_avail_channel_attribute(chan, vals, &type, length,
> > +					 IIO_CHAN_INFO_RAW);
> >  
> >  	if (ret >= 0 && type != IIO_VAL_INT)
> >  		/* raw values are assumed to be IIO_VAL_INT */  
> 
