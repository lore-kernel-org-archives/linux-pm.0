From: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Subject: Re: [PATCH v2 3/3] power: supply: bq24735-charger: allow chargers to
 share the ac-detect gpio
Date: Wed, 14 Dec 2016 18:41:00 +0100
Message-ID: <e1667d9d-17bf-2fe5-8a65-af73b6507cbd@axentia.se>
References: <1481673405-4547-1-git-send-email-peda@axentia.se>
 <1481673405-4547-4-git-send-email-peda@axentia.se>
 <20161214165921.jsatcznbljd7anqi@earth>
 <20161214170114.ckozfple475kqajh@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161214170114.ckozfple475kqajh@earth>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 2016-12-14 18:01, Sebastian Reichel wrote:
> [of course I forgot to actually add gpio people, let's try again]
> 
> On Wed, Dec 14, 2016 at 05:59:21PM +0100, Sebastian Reichel wrote:
>> Hi,
>>
>> On Wed, Dec 14, 2016 at 12:56:45AM +0100, Peter Rosin wrote:
>>> If several parallel bq24735 chargers have their ac-detect gpios wired
>>> together (or if only one of the parallel bq24735 chargers have its
>>> ac-detect pin wired to a gpio, and the others are assumed to react the
>>> same), then all driver instances need to check the same gpio. But the
>>> gpio subsystem does not allow sharing gpios, so handle that locally.
>>
>> Adding GPIO subsystem people to see if they can come up with
>> something in the gpiod API for this usecase.

Right, I don't like how my new code steps away from gpio descriptors.

>>> However, only do this for the polling case, sharing is not supported if
>>> the ac detection is handled with interrupts.
>>
>> Why? I guess you only added the gpio polling stuff for the shared
>> gpio feature, so we can skip the gpio polling if we add shared irq
>> support instead?

Nope, the hw really can't do interrupts on the gpio, it's just not wired
up for that. The gpio is on an expander, and the irq line from the expander
top the cpu is not there (due to a desire to minimize the number of
connections between two parts of the system). So I need both polling and
sharing.

Cheers,
peda

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
