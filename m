From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 2/3] thermal: Add Mediatek thermal controller support
Date: Wed, 26 Aug 2015 16:02:25 +0200
Message-ID: <55DDC6F1.8090105@linaro.org>
References: <1440057962-13373-1-git-send-email-s.hauer@pengutronix.de> <1440057962-13373-3-git-send-email-s.hauer@pengutronix.de> <55D65ED7.7010102@linaro.org> <20150826135421.GV18700@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150826135421.GV18700@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, Daniel Kurtz <djkurtz@chromium.org>, kernel@pengutronix.de, Matthias Brugger <matthias.bgg@gmail.com>
List-Id: linux-pm@vger.kernel.org

On 08/26/2015 03:54 PM, Sascha Hauer wrote:
> On Fri, Aug 21, 2015 at 01:12:23AM +0200, Daniel Lezcano wrote:
>> On 08/20/2015 10:06 AM, Sascha Hauer wrote:
>>> This adds support for the Mediatek thermal controller found on MT81=
73
>>> and likely other SoCs.
>>> The controller is a bit special. It does not have its own ADC, inst=
ead
>>> it controls the on-SoC AUXADC via AHB bus accesses. For this reason
>>> we need the physical address of the AUXADC. Also it controls a mux
>>> using AHB bus accesses, so we need the APMIXEDSYS physical address =
aswell.
>>>
>>> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
>>> ---
>>
>> [ ... ]
>>
>>> diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_th=
ermal.c
>>> new file mode 100644
>>> index 0000000..06d52ef
>>> --- /dev/null
>>> +++ b/drivers/thermal/mtk_thermal.c
>>> @@ -0,0 +1,582 @@
>>> +/*
>>> + * Copyright (c) 2014 MediaTek Inc.
>>
>> 2015 ?
>
> Can change to 2015
>
>>
>>> + * Author: Hanyi.Wu <hanyi.wu@mediatek.com>
>>
>> Hanyi Wu ?
>
> It's the original author of this code.

Sorry I wasn't clear. I was suggesting to remove the dot between Hanyi=20
and Wu.

>>> +#define TEMP_MONINT_COLD(sp)			(BIT(0) << ((sp) * 5))
>>> +#define TEMP_MONINT_HOT(sp)			(BIT(1) << ((sp) * 5))
>>> +#define TEMP_MONINT_LOW_OFS(sp)			(BIT(2) << ((sp) * 5))
>>> +#define TEMP_MONINT_HIGH_OFS(sp)		(BIT(3) << ((sp) * 5))
>>> +#define TEMP_MONINT_HOT_TO_NORM(sp)		(BIT(4) << ((sp) * 5))
>>> +#define TEMP_MONINT_TIMEOUT			BIT(15)
>>> +#define TEMP_MONINT_IMMEDIATE_SENSE(sp)		BIT(16 + (sp))
>>> +#define TEMP_MONINT_FILTER_SENSE(sp)		BIT(19 + (sp))
>>> +#define TEMP_ADCWRITECTRL_ADC_EXTRA_WRITE	BIT(2)
>>> +#define TEMP_ADCWRITECTRL_ADC_EXTRA1_WRITE	BIT(3)
>>> +#define TEMP_PROTCTL_AVERAGE			(0 << 16)
>>> +#define TEMP_PROTCTL_MAXIMUM			(1 << 16)
>>> +#define TEMP_PROTCTL_SELECTED			(2 << 16)
>>
>> <-- Not used.
>
> Will remove.
>
> Sascha
>
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
