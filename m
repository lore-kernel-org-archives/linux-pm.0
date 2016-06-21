From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v12 2/4] gadget: Support for the usb charger framework
Date: Tue, 21 Jun 2016 20:43:45 +0800
Message-ID: <CAMz4kuLnKH3to_gYdZC3+eos8a4i9nyqXQZyjui+eryv5i+_EQ@mail.gmail.com>
References: <cover.1466497505.git.baolin.wang@linaro.org> <f7bae2566824a5e1da14c1a19dee6af5f250262f.1466497506.git.baolin.wang@linaro.org>
 <87bn2uomzd.fsf@linux.intel.com> <CAMz4ku+t66t+E3dCysfE9yNkKRCYwv7mXpJs4ShGbZWSZO_B9g@mail.gmail.com>
 <87twgmn4m7.fsf@linux.intel.com> <CAMz4kuKtof=wret_JJVaxe3uXjtaSeCFWn8V6y2wzTjjmrQVLQ@mail.gmail.com>
 <87inx2n2vs.fsf@linux.intel.com> <CAMz4kuKnzjPOqEr9kJY6SCnq2rszsc55X5=7mWb+ZcbL6G_8DQ@mail.gmail.com>
 <87d1nan2ft.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f170.google.com ([209.85.161.170]:35469 "EHLO
	mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751658AbcFUMsz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jun 2016 08:48:55 -0400
Received: by mail-yw0-f170.google.com with SMTP id l125so12428256ywb.2
        for <linux-pm@vger.kernel.org>; Tue, 21 Jun 2016 05:48:55 -0700 (PDT)
In-Reply-To: <87d1nan2ft.fsf@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Felipe Balbi <balbi@kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, robh@kernel.org, Jun Li <jun.li@nxp.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Ruslan Bilovol <ruslan.bilovol@gmail.com>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, r.baldyga@samsung.com, grygorii.strashko@ti.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, device-mainlining@lists.linuxfoundation.org, LKML <linux-kernel@vger.kernel.org>

On 21 June 2016 at 20:36, Felipe Balbi <balbi@kernel.org> wrote:
>
> Hi,
>
> Baolin Wang <baolin.wang@linaro.org> writes:
>>> Baolin Wang <baolin.wang@linaro.org> writes:
>>>>> Baolin Wang <baolin.wang@linaro.org> writes:
>>>>>>> Can't you just tie a charger to a UDC and avoid the charger class
>>>>>>> completely?
>>>>>>
>>>>>> Yeah, I also hope so. But we really want something to manage the
>>>>>> charger devices, do you have any good suggestion to avoid the 'class'
>>>>>> but also can manage the charger devices?
>>>>>
>>>>> manage in what way? It seems to me that they don't need to be real
>>>>> devices, just a handle as part of struct usb_gadget, no?
>>>>
>>>> Although charger device is not one real hardware device, we also use
>>>> one 'struct device' to describe it in charger.c file. So we should
>>>> manage the 'struct device' with one proper way.
>>>
>>> that's fine, but why do you think they need a struct device to start with?
>>
>> We can get/put usb charger and mange usb charger attributes with the
>> device model if we use a struct device.
>
> We already have that as part of struct usb_udc. Why don't you just
> create a subdirectory called charger which will hold all your
> charger-related attributes. That directory will only be created if a
> valid ->charger pointer exists.

That means we can remove all the device and class things in charger.c
file, right? OK, I try to do that. Thanks.

>
> USB Charging is always tied to a peripheral side controller, anyway.
>
> --
> balbi



-- 
Baolin.wang
Best Regards
