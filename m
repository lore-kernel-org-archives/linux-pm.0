From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v8 5/7] qcom: cpuidle: Add cpuidle driver for QCOM cpus
Date: Fri, 24 Oct 2014 10:56:35 +0200
Message-ID: <544A1443.8000707@linaro.org>
References: <1412718106-17049-1-git-send-email-lina.iyer@linaro.org> <1412718106-17049-6-git-send-email-lina.iyer@linaro.org> <5448E103.9070505@linaro.org> <20141023124303.GA16417@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:41867 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751690AbaJXI4j (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 24 Oct 2014 04:56:39 -0400
Received: by mail-wg0-f44.google.com with SMTP id y10so614897wgg.3
        for <linux-pm@vger.kernel.org>; Fri, 24 Oct 2014 01:56:38 -0700 (PDT)
In-Reply-To: <20141023124303.GA16417@red-moon>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Lina Iyer <lina.iyer@linaro.org>, "khilman@linaro.org" <khilman@linaro.org>, "sboyd@codeaurora.org" <sboyd@codeaurora.org>, "galak@codeaurora.org" <galak@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "msivasub@codeaurora.org" <msivasub@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On 10/23/2014 02:43 PM, Lorenzo Pieralisi wrote:
> On Thu, Oct 23, 2014 at 12:05:39PM +0100, Daniel Lezcano wrote:
>
> [...]
>
>>> diff --git a/drivers/cpuidle/cpuidle-qcom.c b/drivers/cpuidle/cpuid=
le-qcom.c
>>> new file mode 100644
>>> index 0000000..0a65065
>>> --- /dev/null
>>> +++ b/drivers/cpuidle/cpuidle-qcom.c
>>> @@ -0,0 +1,79 @@
>>> +/*
>>> + * Copyright (c) 2014, Linaro Limited.
>>> + *
>>> + * This program is free software; you can redistribute it and/or m=
odify
>>> + * it under the terms of the GNU General Public License version 2 =
and
>>> + * only version 2 as published by the Free Software Foundation.
>>> + *
>>> + * This program is distributed in the hope that it will be useful,
>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>> + * GNU General Public License for more details.
>>> + *
>>> + */
>>> +
>>> +#include <linux/cpu_pm.h>
>>> +#include <linux/cpuidle.h>
>>> +#include <linux/module.h>
>>> +#include <linux/platform_device.h>
>>> +
>>> +#include <soc/qcom/pm.h>
>>> +#include "dt_idle_states.h"
>>> +
>>> +static void (*qcom_idle_enter)(enum pm_sleep_mode);
>>> +
>>> +static int qcom_lpm_enter_stby(struct cpuidle_device *dev,
>>> +                             struct cpuidle_driver *drv, int index=
)
>>> +{
>>> +     qcom_idle_enter(PM_SLEEP_MODE_STBY);
>>
>> Could you replace this function by a generic one ?
>>
>> It would be nice to have qcom_cpu_standby(void) and
>> qcom_cpu_powerdown(void) and let behind the mysterious words 'Single
>> Power Collapse' in the low level code which is qcom specific :)
>>
>> I guess you had to create a single "qcom_idle_enter" because of a si=
ngle
>> pointer in the platform data. I am working on a common structure to =
be
>> shared across the drivers as a common way to pass the different
>> callbacks without including a soc specific header.
>>
>> struct cpuidle_ops {
>>          int (*standby)(void *data);
>>          int (*retention)(void *data);
>>          int (*poweroff)(void *data);
>> };
>>
>> So maybe you can either:
>>
>> 1. wait I post this structure and provide the driver with this one
>> 2. create a similar structure and I will take care to upgrade when I
>> post the patchset with the common structure.
>>
>> The issue I see with this common structure is the initialization of =
the
>> qcom_idle_state_match array.
>
> Because you do not know which function to call when right ?

Hi Lorenzo,

that's correct.

Perhaps an alternative could be to use the 'weak' attribute instead of =
a=20
structure and define the different ops like the cpu_do_idle() does.

> That's why
> I think it is up to the CPUidle back-end to make that decision and wh=
y
> I think that the contract between the CPUidle driver and the back-end
> should be the idle index. Even if you have pointers to functions,
> the CPUidle driver do not know what parameter it has to chuck into
> the void data, which is likely to be platform specific too. Granted,
> you can make those cpuidle_ops a set of pairs, {function, parameter}
> associated with an idle index, but then you will end up implementing
> what I suggest below.

I don't see where is the problem if the backend driver passes the=20
different CPU PM ops. If the cpuidle driver and the backend PM code wan=
t=20
to pass an index as 'data', I don't like that but it is ok. But I don't=
=20
want to provide the index as part of the API.

We can see the mess when the code began to play with the indexes as a=20
specific idle state (cf. CPUIDLE_DRIVER_STATE_START magic).

> If you have a look at how the MCPM wrapper works on bL driver, that's
> exactly the same problem. At the moment we are supporting only cluste=
r
> shutdown. If we were to add a core gating idle state, how could the
> MCPM back-end differentiate between core and cluster states ? At the
> moment the only way would consist in passing the residency through
> mcpm_suspend() parameter. We could pass the idle state index, it is t=
he
> same story.
>
> That's the reasoning behind cpu_suspend on ARM64, the index determine=
s
> what should be done, it is up to the platform back end to execute the
> required actions (and it is not because we have PSCI on ARM64, that
> concept is generic and should be made similar on ARM32 IMHO).
>
> DT idle states are sorted by definition, and they can be parsed by
> the arch back-end too to determine the actions required by an idle
> state index (eg most likely information coming from power domains).
>
> The glue code on arm64 is cpu_init_idle(), which takes charge of
> initializing the idle state platform specific actions/parameters/etc.
>
> Everything is open to debate, as long as we nail down an interface on
> arm32 and we stick to that from now onwards, I do not think you are f=
ar
> from achieving that at all.




--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

