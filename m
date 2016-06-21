From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [RESEND PATCH v11 1/4] gadget: Introduce the usb charger framework
Date: Tue, 21 Jun 2016 15:55:52 +0800
Message-ID: <CAMz4kuLA6-Vq9Ub-mapMg0oZo212i+jPOk4+TbAHCsHWfDOuXA@mail.gmail.com>
References: <cover.1465807514.git.baolin.wang@linaro.org> <710550bd6c860d7dbdd3e7225ef51b59ae9c39fb.1465807514.git.baolin.wang@linaro.org>
 <AM4PR04MB21308ECE74B23A44E51C42B689530@AM4PR04MB2130.eurprd04.prod.outlook.com>
 <CAMz4ku+1HxXLhFJp6mK+hRqKxHZ+ELC3CmJhupLgDcO7SJXy5g@mail.gmail.com> <874m8nouhf.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f175.google.com ([209.85.161.175]:36071 "EHLO
	mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751209AbcFUIDO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jun 2016 04:03:14 -0400
Received: by mail-yw0-f175.google.com with SMTP id b72so7135465ywa.3
        for <linux-pm@vger.kernel.org>; Tue, 21 Jun 2016 01:03:13 -0700 (PDT)
In-Reply-To: <874m8nouhf.fsf@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Felipe Balbi <balbi@kernel.org>
Cc: Jun Li <jun.li@nxp.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "sre@kernel.org" <sre@kernel.org>, "dbaryshkov@gmail.com" <dbaryshkov@gmail.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "robh@kernel.org" <robh@kernel.org>, "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>, "ruslan.bilovol@gmail.com" <ruslan.bilovol@gmail.com>, "peter.chen@freescale.com" <peter.chen@freescale.com>, "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>, "r.baldyga@samsung.com" <r.baldyga@samsung.com>, "yoshihiro.shimoda.uh@renesas.com" <yoshihiro.shimoda.uh@renesas.com>, "lee.jones@linaro.org" <lee.jones@linaro.org>, "broonie@kernel.org" <broonie@kernel.org>, "ckeepax@opensource.wolfsonmicro.com" <ckeepax@opensource.wolfsonmicro.com>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.>

Hi Felipe,

On 21 June 2016 at 15:45, Felipe Balbi <balbi@kernel.org> wrote:
>
> Hi Baolin,
>
> Baolin Wang <baolin.wang@linaro.org> writes:
>>>> -----Original Message-----
>>>> From: linux-usb-owner@vger.kernel.org [mailto:linux-usb-
>>>> owner@vger.kernel.org] On Behalf Of Baolin Wang
>>>> Sent: Monday, June 13, 2016 4:47 PM
>>>> To: balbi@kernel.org; gregkh@linuxfoundation.org; sre@kernel.org;
>>>> dbaryshkov@gmail.com; dwmw2@infradead.org
>>>> Cc: robh@kernel.org; m.szyprowski@samsung.com; ruslan.bilovol@gmail.com;
>>>> peter.chen@freescale.com; stern@rowland.harvard.edu; r.baldyga@samsung.com;
>>>> yoshihiro.shimoda.uh@renesas.com; lee.jones@linaro.org; broonie@kernel.org;
>>>> ckeepax@opensource.wolfsonmicro.com; patches@opensource.wolfsonmicro.com;
>>>> baolin.wang@linaro.org; linux-pm@vger.kernel.org; linux-
>>>> usb@vger.kernel.org; device-mainlining@lists.linuxfoundation.org; linux-
>>>> kernel@vger.kernel.org
>>>> Subject: [RESEND PATCH v11 1/4] gadget: Introduce the usb charger
>>>> framework
>>>>
>>>> This patch introduces the usb charger driver based on usb gadget that
>>>> makes an enhancement to a power driver. It works well in practice but that
>>>> requires a system with suitable hardware.
>>>>
>>>> The basic conception of the usb charger is that, when one usb charger is
>>>> added or removed by reporting from the usb gadget state change or the
>>>> extcon device state change, the usb charger will report to power user to
>>>> set the current limitation.
>>>>
>>>> The usb charger will register notifiees on the usb gadget or the extcon
>>>> device to get notified the usb charger state. It also supplies the
>>>> notification mechanism to userspace When the usb charger state is changed.
>>>>
>>>> Power user will register a notifiee on the usb charger to get notified by
>>>> status changes from the usb charger. It will report to power user to set
>>>> the current limitation when detecting the usb charger is added or removed
>>>> from extcon device state or usb gadget state.
>>>>
>>>> This patch doesn't yet integrate with the gadget code, so some functions
>>>> which rely on the 'gadget' are not completed, that will be implemented in
>>>> the following patches.
>>>>
>>>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>>>
>>> Reviewed-by: Li Jun <jun.li@nxp.com>
>>> Tested-by: Li Jun <jun.li@nxp.com>
>>
>> Do you have any comments about this patchset, if not I will resend it
>> with testing by Li Jun (thanks for Jun reviewing and testing). Thanks.
>
> please resend. I don't have the series in my queue anymore, sorry.

OK. I would like to resend this patchset. Thanks.

-- 
Baolin.wang
Best Regards
