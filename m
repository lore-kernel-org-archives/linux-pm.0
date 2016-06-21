From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v12 1/4] gadget: Introduce the usb charger framework
Date: Tue, 21 Jun 2016 19:23:39 +0800
Message-ID: <CAMz4kuJHPqvYiUGi8Ar5cR_8dENddvVjNEuG1wJVt3E3vp1UOQ@mail.gmail.com>
References: <cover.1466497505.git.baolin.wang@linaro.org> <831e03e8935b4c62e1e6bf94c93e0a08a73d89b2.1466497505.git.baolin.wang@linaro.org>
 <87eg7qon3r.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f169.google.com ([209.85.161.169]:35558 "EHLO
	mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751709AbcFULaI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jun 2016 07:30:08 -0400
Received: by mail-yw0-f169.google.com with SMTP id l125so10751561ywb.2
        for <linux-pm@vger.kernel.org>; Tue, 21 Jun 2016 04:30:07 -0700 (PDT)
In-Reply-To: <87eg7qon3r.fsf@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Felipe Balbi <balbi@kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, robh@kernel.org, Jun Li <jun.li@nxp.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Ruslan Bilovol <ruslan.bilovol@gmail.com>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, r.baldyga@samsung.com, grygorii.strashko@ti.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, device-mainlining@lists.linuxfoundation.org, LKML <linux-kernel@vger.kernel.org>

On 21 June 2016 at 18:25, Felipe Balbi <balbi@kernel.org> wrote:
>
> Hi,
>
> Baolin Wang <baolin.wang@linaro.org> writes:
>> This patch introduces the usb charger driver based on usb gadget that
>> makes an enhancement to a power driver. It works well in practice but
>> that requires a system with suitable hardware.
>>
>> The basic conception of the usb charger is that, when one usb charger
>> is added or removed by reporting from the usb gadget state change or
>> the extcon device state change, the usb charger will report to power
>> user to set the current limitation.
>>
>> The usb charger will register notifiees on the usb gadget or the extcon
>> device to get notified the usb charger state. It also supplies the
>> notification mechanism to userspace When the usb charger state is changed.
>>
>> Power user will register a notifiee on the usb charger to get notified
>> by status changes from the usb charger. It will report to power user
>> to set the current limitation when detecting the usb charger is added
>> or removed from extcon device state or usb gadget state.
>>
>> This patch doesn't yet integrate with the gadget code, so some functions
>> which rely on the 'gadget' are not completed, that will be implemented
>> in the following patches.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>> Reviewed-by: Li Jun <jun.li@nxp.com>
>> Tested-by: Li Jun <jun.li@nxp.com>
>> ---
>>  drivers/usb/gadget/Kconfig       |    7 +
>>  drivers/usb/gadget/udc/Makefile  |    1 +
>>  drivers/usb/gadget/udc/charger.c |  770 ++++++++++++++++++++++++++++++++++++++
>>  include/linux/usb/charger.h      |  191 ++++++++++
>>  include/uapi/linux/usb/charger.h |   31 ++
>>  5 files changed, 1000 insertions(+)
>>  create mode 100644 drivers/usb/gadget/udc/charger.c
>>  create mode 100644 include/linux/usb/charger.h
>>  create mode 100644 include/uapi/linux/usb/charger.h
>>
>> diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
>> index 2057add..89f4e9b 100644
>> --- a/drivers/usb/gadget/Kconfig
>> +++ b/drivers/usb/gadget/Kconfig
>> @@ -134,6 +134,13 @@ config U_SERIAL_CONSOLE
>>       help
>>          It supports the serial gadget can be used as a console.
>>
>> +config USB_CHARGER
>> +     bool "USB charger support"
>
> you didn't build test all possibilities, did you?
>
> I have a feeling this won't link if USB_GADGET=m. Can you test that?

OK.

>
>> diff --git a/drivers/usb/gadget/udc/charger.c b/drivers/usb/gadget/udc/charger.c
> [...]
>> +struct class *usb_charger_class;
>
> We already have a UDC class, do we really, really need another class
> here?

We want to manage the usb charger devices by this class and one usb
charger device is not equal with one usb device which managed by UDC
class, so can we use UDC class to manage charger devices?
By the way, you also suggested to use the 'class' things instead of
'bus' in previous mail.

>
>> +subsys_initcall(usb_charger_class_init);
>
> this should always work as module_init(). Please make sure that's the
> case.

we should make sure the charger class has been allocated before user
try to add a new gadget to the udc class. So it should be issued
before 'module_init()' (many usb drivers are at module_init level).
Another hand this follows the UDC class allocation.

>
> --
> balbi



-- 
Baolin.wang
Best Regards
