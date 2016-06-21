From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v12 4/4] power: wm831x_power: Support USB charger current
 limit management
Date: Tue, 21 Jun 2016 19:57:56 +0800
Message-ID: <CAMz4kuKXGxpk=2Z9K9QHzK=+6unsxvn-ifx=rTy2YW8bBvn=4A@mail.gmail.com>
References: <cover.1466497505.git.baolin.wang@linaro.org> <7dc384248d51b1de0df54909f3c5550584b31357.1466497506.git.baolin.wang@linaro.org>
 <878txyomue.fsf@linux.intel.com> <20160621110332.GC26099@sirena.org.uk>
 <CAMz4kuJnkd=zpbnaCRcYd4wjzWVpr5Zom0BBJRnjTTikpwxKjA@mail.gmail.com> <87oa6un4fr.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f173.google.com ([209.85.161.173]:35129 "EHLO
	mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751578AbcFUL6l (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jun 2016 07:58:41 -0400
Received: by mail-yw0-f173.google.com with SMTP id l125so11291789ywb.2
        for <linux-pm@vger.kernel.org>; Tue, 21 Jun 2016 04:57:57 -0700 (PDT)
In-Reply-To: <87oa6un4fr.fsf@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Felipe Balbi <balbi@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, robh@kernel.org, Jun Li <jun.li@nxp.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Ruslan Bilovol <ruslan.bilovol@gmail.com>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, r.baldyga@samsung.com, grygorii.strashko@ti.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, device-mainlining@lists.linuxfoundation.org, LKML <linux-kernel@vger.kernel.org>

On 21 June 2016 at 19:53, Felipe Balbi <balbi@kernel.org> wrote:
>
> Hi,
>
> Baolin Wang <baolin.wang@linaro.org> writes:
>> On 21 June 2016 at 19:03, Mark Brown <broonie@kernel.org> wrote:
>>> On Tue, Jun 21, 2016 at 01:30:49PM +0300, Felipe Balbi wrote:
>>>> Baolin Wang <baolin.wang@linaro.org> writes:
>>>> > @@ -607,8 +647,31 @@ static int wm831x_power_probe(struct platform_device *pdev)
>>>> >             }
>>>> >     }
>>>
>>>> > +   if (wm831x_pdata && wm831x_pdata->usb_gadget) {
>>>> > +           power->usb_charger =
>>>> > +                   usb_charger_find_by_name(wm831x_pdata->usb_gadget);
>>>
>>>> the fact that you rely on strings and pass them via pdata is an
>>>> indication that you don't have enough description of the HW. Seems like
>>>> we need to come up with a set of DT properties which tie a charger to a
>>>> UDC.
>>>
>>>> I'm thinking a phandle would be enough?
>>>
>>> The wm831x has no DT support currently.
>>
>> Another hand I suppose the usb charger is one virtual device and does
>> not need be described from DT.
>
> Right, I don't think that should be a device at all. But you can pass a
> phandle to the UDC controller and use that to get to struct usb_gadget
> from which you could reach ->charger.

Ah, make sense.

-- 
Baolin.wang
Best Regards
