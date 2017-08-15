From: Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 0/3] Introduce USB charger support in USB phy
Date: Tue, 15 Aug 2017 19:10:28 +0800
Message-ID: <CAMz4kuLqva+uUtwMMbHjt4BDgQuDkcz0SQY3cBFT1LGOpAXstg@mail.gmail.com>
References: <cover.1501132171.git.baolin.wang@linaro.org> <CAMz4kuKYOjHgapntbuNB9b6qz35osKetwJ8jmxb=TnDKgLEuDg@mail.gmail.com>
 <87h8x96tth.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87h8x96tth.fsf-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jun Li <jun.li-3arQi8VN3Tc@public.gmane.org>, Peter Chen <peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, NeilBrown <neilb-IBi9RG/b67k@public.gmane.org>, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, USB <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, device-mainlining-cunTk1MwBs98uUxBSJOaYoYkZiVZrdSR2LY78lusg7I@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi Felipe,

On 15 August 2017 at 17:53, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>
> Hi,
>
> Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> writes:
>>> Currently the Linux kernel does not provide any standard integration of this
>>> feature that integrates the USB subsystem with the system power regulation
>>> provided by PMICs meaning that either vendors must add this in their kernels
>>> or USB gadget devices based on Linux (such as mobile phones) may not behave
>>> as they should. Thus provide a standard USB charger support in USB phy core
>>> for doing this in kernel.
>>>
>>> Now introduce one user with wm831x_power to support and test the usb charger.
>>> In future we will also cnvert below power drivers:
>>> drivers/power/supply/axp288_charger.c
>>> drivers/power/supply/bq24190_charger.c
>>> drivers/power/supply/charger-manager.c
>>> drivers/power/supply/qcom_smbb.c
>>>
>>> Changes since v3:
>>>  - Bail out errors when failed to find usb phy for wm831x_power driver.
>>> Changes since v2:
>>>  - Add DT binding documentation for wm831x_power driver.
>>>  - Change 'usb-phy' as one optional property for wm831x_power driver.
>>> Changes since v1:
>>>  - Fix building errors.
>>
>> Do you have any comments about usb charger support in usb phy core? Thanks.
>
> No more comments from me

Thanks for your feedback. I've send out V5 patchset which just changes
phy phandle name from 'usb-phy' to 'phys' for patch 3 suggested by
Rob. Hope you can apply this version patchset into your branch if
there are no other comments.

-- 
Baolin.wang
Best Regards
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
