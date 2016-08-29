From: Santosh Shilimkar <santosh.shilimkar-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 3/5] firmware: ti_sci: Add support for Device control
Date: Mon, 29 Aug 2016 15:30:18 -0700
Message-ID: <e936ee55-34ec-dbc6-5ba0-7fe9c54013cc@oracle.com>
References: <20160819225159.10758-1-nm@ti.com>
 <20160819225159.10758-4-nm@ti.com>
 <9a6a8663-a3f7-7875-253f-98232d56b860@ti.com>
 <CAGo_u6p3Bm+zGDtxpOyT+DeGN8_XPWWE0zhCYuxsH47n41Z8jg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAGo_u6p3Bm+zGDtxpOyT+DeGN8_XPWWE0zhCYuxsH47n41Z8jg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
Cc: Russell King <rmk+kernel-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Andrew F . Davis" <afd-l0cyMroinI0@public.gmane.org>, dt list <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Russ Dill <Russ.Dill-l0cyMroinI0@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi Nishant,

On 8/23/2016 11:45 AM, Nishanth Menon wrote:
> On Sun, Aug 21, 2016 at 10:56 PM, Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org> wrote:
>>>  /**
>>> + * tis_sci_is_response_ack() - Generic ACK/NACK message checkup
>>> + * @r:       pointer to response buffer
>>> + *
>>> + * Return: true if the response was an ACK, else returns false.
>>> + */
>>> +static inline bool tis_sci_is_response_ack(void *r)
>>
>> May be just ti_sci_is_response_ack() to be consistent? or you wanted to
>> keep it tis_sci* ?
>
>
> Uggh.. Fat fingered that one.. thanks for catching.. fixed and will
> post a v2 next week if there is no further comments
>
I would like to send the next merge window queue up so please repost
the reviewed patches which needs to be queued up.

Regards,
Santosh
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
