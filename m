From: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Subject: Re: [PATCH V2 3/6] power: mxs_power: add driver for mxs power subsystem
Date: Wed, 27 May 2015 18:34:01 +0200
Message-ID: <5565F1F9.2010801@i2se.com>
References: <1430346747-28728-1-git-send-email-stefan.wahren@i2se.com> <1430346747-28728-4-git-send-email-stefan.wahren@i2se.com> <20150523174149.GA16004@earth> <55656E70.6030906@i2se.com> <20150527135150.GA9205@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150527135150.GA9205@earth>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org, sebastien.szymanski-d2DlULPkwbNWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi Sebastian,

Am 27.05.2015 um 15:51 schrieb Sebastian Reichel:
> Hi Stefan,
>
> On Wed, May 27, 2015 at 09:12:48AM +0200, Stefan Wahren wrote:
>> Am 23.05.2015 um 19:41 schrieb Sebastian Reichel:
>>> On Wed, Apr 29, 2015 at 10:32:24PM +0000, Stefan Wahren wrote:
>>>> This patch adds a minimal driver for the Freescale i.MX23, i.MX28
>>>> power subsystem. It's required to trigger the probing of the underlying
>>>> drivers like on-chip regulators.
>>> I'm not sure what you need the power supply class for. I see only
>>> one property (ac connected), which is constant. Maybe just drop
>>> the power supply stuff?
>> those SoCs could be powered by 3 different sources:
>> - 5V wall
>> - USB
>> - battery
>>
>> I choose the first one as a base, because it's the simplest one.
>> Unfortunately i don't have the time to implement all of them.
> From what I can see the driver does not implement the 5V wall
> charger handling. It simply assumes, that the 5V wall charger
> is there.

the driver consists of multiple files in the mxs sub directory.
I linked to the main file to reduce search effort. The battery
handling incl. charging should be implemented in ddi_power_battery.c

>From my understanding it's not possible to determine where the 5V
exactly come from (either 5V wall plug or USB). The driver simply uses
the USB PHY state.

>
> While you can skip implementation of battery connection check
> you should make sure, that AC is actually connected.

Do you refer to the right state of property POWER_SUPPLY_PROP_ONLINE or
driver probing?

Stefan


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
