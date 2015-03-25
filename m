From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 6/8] ARM: cpuidle: Enable the ARM64 driver for both ARM32/ARM64
Date: Wed, 25 Mar 2015 23:02:00 +0100
Message-ID: <55133058.6020603@linaro.org>
References: <55127A53.8050206@linaro.org>	 <1427274436-21916-1-git-send-email-daniel.lezcano@linaro.org>	 <1427274436-21916-6-git-send-email-daniel.lezcano@linaro.org> <1427316850.10958.58.camel@x220>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:38525 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751278AbbCYWCE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 25 Mar 2015 18:02:04 -0400
Received: by wibgn9 with SMTP id gn9so59267942wib.1
        for <linux-pm@vger.kernel.org>; Wed, 25 Mar 2015 15:02:03 -0700 (PDT)
In-Reply-To: <1427316850.10958.58.camel@x220>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Paul Bolle <pebolle@tiscali.nl>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, lina.iyer@linaro.org, Lorenzo.Pieralisi@arm.com

On 03/25/2015 09:54 PM, Paul Bolle wrote:
> A few nits are all I spotted.
>
> On Wed, 2015-03-25 at 10:07 +0100, Daniel Lezcano wrote:
>> --- a/drivers/cpuidle/Kconfig.arm
>> +++ b/drivers/cpuidle/Kconfig.arm
>
>> +config ARM_CPUIDLE
>> +        bool "Generic ARM/ARM64 CPU idle Driver"
>> +        select DT_IDLE_STATES
>> +        help
>> +          Select this to enable generic cpuidle driver for ARM.
>> +          It provides a generic idle driver whose idle states are c=
onfigured
>> +          at run-time through DT nodes. The CPUidle suspend backend=
 is
>> +          initialized by calling the CPU operations init idle hook
>> +          provided by architecture code.
>
> Start with a tab instead of 8 spaces, please.

Ok, I will send a fix for that on top of this patch.

>> --- /dev/null
>> +++ b/drivers/cpuidle/cpuidle-arm.c
>
>> +#include <linux/cpuidle.h>
>> +#include <linux/cpumask.h>
>> +#include <linux/cpu_pm.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>
> Is this include actually needed? I haven't tried building this withou=
t
> that include, but I spotted nothing obviously module related in this
> file.
>
>> +#include <linux/of.h>
>> +
>> +#include <asm/cpuidle.h>
>> +
>> +#include "dt_idle_states.h"
>
>> +static struct cpuidle_driver arm_idle_driver =3D {
>> +	.name =3D "arm_idle",
>> +	.owner =3D THIS_MODULE,
>
> Since this can only be built in, THIS_MODULE will (basically) be
> equivalent to NULL according to include/linux/export.h. So I suppose
> this line can be dropped.

Yeah, THIS_MODULE is present in all drivers. Very likely we can safely=20
remove it.

>> +	/*
>> +	 * State at index 0 is standby wfi and considered standard
>> +	 * on all ARM platforms. If in some platforms simple wfi
>> +	 * can't be used as "state 0", DT bindings must be implemented
>> +	 * to work around this issue and allow installing a special
>> +	 * handler for idle state index 0.
>> +	 */
>> +	.states[0] =3D {
>> +		.enter                  =3D arm_enter_idle_state,
>> +		.exit_latency           =3D 1,
>> +		.target_residency       =3D 1,
>> +		.power_usage		=3D UINT_MAX,
>> +		.name                   =3D "WFI",
>> +		.desc                   =3D "ARM WFI",
>> +	}
>> +};
>
> I did notice that these two nits are already present in
> drivers/cpuidle/cpuidle-arm64.c. But since this patch is not just mov=
ing
> that file's content around, you might as well look into those two nit=
s.

We can address the module code removal in a separate patchset as this i=
s=20
the case for all the drivers.


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

