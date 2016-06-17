From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [RESEND PATCH v11 1/4] gadget: Introduce the usb charger framework
Date: Fri, 17 Jun 2016 14:19:05 +0800
Message-ID: <CAMz4ku+1HxXLhFJp6mK+hRqKxHZ+ELC3CmJhupLgDcO7SJXy5g@mail.gmail.com>
References: <cover.1465807514.git.baolin.wang@linaro.org> <710550bd6c860d7dbdd3e7225ef51b59ae9c39fb.1465807514.git.baolin.wang@linaro.org>
 <AM4PR04MB21308ECE74B23A44E51C42B689530@AM4PR04MB2130.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f181.google.com ([209.85.161.181]:35262 "EHLO
	mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751111AbcFQGTH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jun 2016 02:19:07 -0400
Received: by mail-yw0-f181.google.com with SMTP id z186so63543733ywd.2
        for <linux-pm@vger.kernel.org>; Thu, 16 Jun 2016 23:19:06 -0700 (PDT)
In-Reply-To: <AM4PR04MB21308ECE74B23A44E51C42B689530@AM4PR04MB2130.eurprd04.prod.outlook.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jun Li <jun.li@nxp.com>
Cc: "balbi@kernel.org" <balbi@kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "sre@kernel.org" <sre@kernel.org>, "dbaryshkov@gmail.com" <dbaryshkov@gmail.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "robh@kernel.org" <robh@kernel.org>, "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>, "ruslan.bilovol@gmail.com" <ruslan.bilovol@gmail.com>, "peter.chen@freescale.com" <peter.chen@freescale.com>, "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>, "r.baldyga@samsung.com" <r.baldyga@samsung.com>, "yoshihiro.shimoda.uh@renesas.com" <yoshihiro.shimoda.uh@renesas.com>, "lee.jones@linaro.org" <lee.jones@linaro.org>, "broonie@kernel.org" <broonie@kernel.org>, "ckeepax@opensource.wolfsonmicro.com" <ckeepax@opensource.wolfsonmicro.com>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>

Hi Felipe,

On 13 June 2016 at 23:13, Jun Li <jun.li@nxp.com> wrote:
> Hi
>
>> -----Original Message-----
>> From: linux-usb-owner@vger.kernel.org [mailto:linux-usb-
>> owner@vger.kernel.org] On Behalf Of Baolin Wang
>> Sent: Monday, June 13, 2016 4:47 PM
>> To: balbi@kernel.org; gregkh@linuxfoundation.org; sre@kernel.org;
>> dbaryshkov@gmail.com; dwmw2@infradead.org
>> Cc: robh@kernel.org; m.szyprowski@samsung.com; ruslan.bilovol@gmail.com;
>> peter.chen@freescale.com; stern@rowland.harvard.edu; r.baldyga@samsung.com;
>> yoshihiro.shimoda.uh@renesas.com; lee.jones@linaro.org; broonie@kernel.org;
>> ckeepax@opensource.wolfsonmicro.com; patches@opensource.wolfsonmicro.com;
>> baolin.wang@linaro.org; linux-pm@vger.kernel.org; linux-
>> usb@vger.kernel.org; device-mainlining@lists.linuxfoundation.org; linux-
>> kernel@vger.kernel.org
>> Subject: [RESEND PATCH v11 1/4] gadget: Introduce the usb charger
>> framework
>>
>> This patch introduces the usb charger driver based on usb gadget that
>> makes an enhancement to a power driver. It works well in practice but that
>> requires a system with suitable hardware.
>>
>> The basic conception of the usb charger is that, when one usb charger is
>> added or removed by reporting from the usb gadget state change or the
>> extcon device state change, the usb charger will report to power user to
>> set the current limitation.
>>
>> The usb charger will register notifiees on the usb gadget or the extcon
>> device to get notified the usb charger state. It also supplies the
>> notification mechanism to userspace When the usb charger state is changed.
>>
>> Power user will register a notifiee on the usb charger to get notified by
>> status changes from the usb charger. It will report to power user to set
>> the current limitation when detecting the usb charger is added or removed
>> from extcon device state or usb gadget state.
>>
>> This patch doesn't yet integrate with the gadget code, so some functions
>> which rely on the 'gadget' are not completed, that will be implemented in
>> the following patches.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>
> Reviewed-by: Li Jun <jun.li@nxp.com>
> Tested-by: Li Jun <jun.li@nxp.com>

Do you have any comments about this patchset, if not I will resend it
with testing by Li Jun (thanks for Jun reviewing and testing). Thanks.

>
>> ---
>>  drivers/usb/gadget/Kconfig       |    7 +
>>  drivers/usb/gadget/udc/Makefile  |    1 +
>>  drivers/usb/gadget/udc/charger.c |  770
>> ++++++++++++++++++++++++++++++++++++++
>>  include/linux/usb/charger.h      |  191 ++++++++++
>>  include/uapi/linux/usb/charger.h |   31 ++
>>  5 files changed, 1000 insertions(+)
>>  create mode 100644 drivers/usb/gadget/udc/charger.c  create mode 100644
>> include/linux/usb/charger.h  create mode 100644
>> include/uapi/linux/usb/charger.h



-- 
Baolin.wang
Best Regards
