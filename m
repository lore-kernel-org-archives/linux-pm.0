From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v3 1/3] gadget: Support for the usb charger framework
Date: Wed, 19 Aug 2015 09:29:33 +0800
Message-ID: <CAMz4kuKJN4EOm84NyP76SfiHFFC14e_mkcxb-aPQ2viX-2+HFQ@mail.gmail.com>
References: <cover.1439866451.git.baolin.wang@linaro.org>
	<6a4d68543dcffe76993dc70d94a0a04617ef2257.1439866451.git.baolin.wang@linaro.org>
	<20150818160414.GB3551@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f171.google.com ([209.85.160.171]:36470 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750822AbbHSB3e (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 18 Aug 2015 21:29:34 -0400
Received: by ykfw73 with SMTP id w73so123665992ykf.3
        for <linux-pm@vger.kernel.org>; Tue, 18 Aug 2015 18:29:34 -0700 (PDT)
In-Reply-To: <20150818160414.GB3551@kroah.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Felipe Balbi <balbi@ti.com>, Mark Brown <broonie@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, LKML <linux-kernel@vger.kernel.org>, Peter Chen <peter.chen@freescale.com>, sojka@merica.cz, Alan Stern <stern@rowland.harvard.edu>, r.baldyga@samsung.com, yoshihiro.shimoda.uh@renesas.com, linux-usb@vger.kernel.org, device-mainlining@lists.linuxfoundation.org, sre@kernel.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, sameo@linux.intel.com, Lee Jones <lee.jones@linaro.org>, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org

On 19 August 2015 at 00:04, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Tue, Aug 18, 2015 at 07:14:19PM +0800, Baolin Wang wrote:
>> The usb charger framework is based on usb gadget, and each usb gadget
>> can be one usb charger to set the current limitation.
>>
>> This patch adds a notifier mechanism for usb charger to report to usb
>> charger when the usb gadget state is changed.
>>
>> Also we introduce a callback 'get_charger_type' which will implemented
>> by user for usb gadget operations to get the usb charger type.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>> ---
>>  drivers/usb/gadget/udc/udc-core.c |   41 ++++++++++++++++++++++++++++++++++++-
>>  include/linux/usb/gadget.h        |   20 ++++++++++++++++++
>>  2 files changed, 60 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/gadget/udc/udc-core.c b/drivers/usb/gadget/udc/udc-core.c
>> index f660afb..1971218 100644
>> --- a/drivers/usb/gadget/udc/udc-core.c
>> +++ b/drivers/usb/gadget/udc/udc-core.c
>> @@ -28,6 +28,7 @@
>>  #include <linux/usb/ch9.h>
>>  #include <linux/usb/gadget.h>
>>  #include <linux/usb.h>
>> +#include <linux/usb/usb_charger.h>
>
> You just broke the build, which proves you did not properly test this
> patch series, so why should we even consider it?
>

Oh, I'm very sorry about that. I'll re-check my patch and test it
carefully. Thanks for your comments.

> greg k-h



-- 
Baolin.wang
Best Regards
