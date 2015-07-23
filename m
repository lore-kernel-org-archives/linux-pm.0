From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 2/2] iio: light: add APDS9960 ALS + promixity driver
Date: Thu, 23 Jul 2015 20:53:11 +0100
Message-ID: <55B14627.5040903@kernel.org>
References: <1436754043-6232-1-git-send-email-mranostay@gmail.com>
 <1436754043-6232-3-git-send-email-mranostay@gmail.com>
 <55AB7FBE.1060707@kernel.org>
 <CAKzfze_2wchApiDHRaCWTgRWL_eep42hOdyXHnrE4Ox6UVxK5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAKzfze_2wchApiDHRaCWTgRWL_eep42hOdyXHnrE4Ox6UVxK5A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matt Ranostay <mranostay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, =?UTF-8?Q?Marek_Va=c5=a1ut?= <marex-ynQEQJNshbs@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

<snip>
>>> +static int apds9960_read_raw(struct iio_dev *indio_dev,
>>> +                          struct iio_chan_spec const *chan,
>>> +                          int *val, int *val2, long mask)
>>> +{
>>> +     struct apds9960_data *data = iio_priv(indio_dev);
>>> +     u16 buf;
>>> +     int ret = -EINVAL;
>>> +
>>> +     if (data->gesture_mode_running)
>>> +             return -EBUSY;
>>> +
>>> +     switch (mask) {
>>> +     case IIO_CHAN_INFO_RAW:
>>> +             apds9960_set_power_state(data, true);
>>> +             switch (chan->type) {
>>> +             case IIO_PROXIMITY:
>>> +                     if (chan->scan_index == -1) {
>>> +                             ret = regmap_read(data->regmap,
>>> +                                               chan->address, val);
>>> +                             if (!ret)
>>> +                                     ret = IIO_VAL_INT;
>>> +                     } else {
>> If the channels don't have explicity channel mask entries for a polled
>> read then there will be no way of reading them anyway except through the
>> buffered interface.
> 
> What context do you mean by channel mask entries?
.info_mask_separate = BIT(IIO_CHAN_INFO_RAW)  - or the processed variant.
> 
>>> +                             /*
>>> +                              * Cannot poll the GESTURE channels which are
>>> +                              * just usable with triggered buffers.
>>> +                              */
>>> +                             ret = -EBUSY;
>>> +                     }
>>> +                     break;
<snip>
