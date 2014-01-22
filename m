From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RFC PATCH] cpuidle: reduce unnecessary loop in c-state selection
Date: Wed, 22 Jan 2014 09:19:47 +0100
Message-ID: <52DF7F23.10104@linaro.org>
References: <1389876316-27161-1-git-send-email-alex.shi@linaro.org> <13647359.XRIaiKjIK6@vostro.rjw.lan> <52DF78F1.7080204@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:57417 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751516AbaAVITt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 22 Jan 2014 03:19:49 -0500
Received: by mail-we0-f174.google.com with SMTP id x55so48007wes.33
        for <linux-pm@vger.kernel.org>; Wed, 22 Jan 2014 00:19:48 -0800 (PST)
In-Reply-To: <52DF78F1.7080204@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alex Shi <alex.shi@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: linux-pm@vger.kernel.org

On 01/22/2014 08:53 AM, Alex Shi wrote:
> On 01/16/2014 11:53 PM, Rafael J. Wysocki wrote:
>> Hi Len, what do you think?
>
> Is this patch correct?

Well, there is no rule telling in what order the idle states are, excep=
t=20
they are ordered by power consumption.

But regarding how are defined the different idle states in the drivers,=
=20
I think this patch makes sense.

>>
>> On Thursday, January 16, 2014 08:45:16 PM Alex Shi wrote:
>>> All deeper c-state have the longer target_residency and exit_latenc=
y
>>> So, if the one can not meet our prediction, neither any later.
>>> So, just break out the for loop to save few checking instructions.
>>>
>>> Signed-off-by: Alex Shi <alex.shi@linaro.org>
>>> ---
>>>   drivers/cpuidle/governors/menu.c | 6 +++---
>>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/gov=
ernors/menu.c
>>> index cf7f2f0..48ed3fb 100644
>>> --- a/drivers/cpuidle/governors/menu.c
>>> +++ b/drivers/cpuidle/governors/menu.c
>>> @@ -352,11 +352,11 @@ static int menu_select(struct cpuidle_driver =
*drv, struct cpuidle_device *dev)
>>>   		if (s->disabled || su->disable)
>>>   			continue;
>>>   		if (s->target_residency > data->predicted_us)
>>> -			continue;
>>> +			break;
>>>   		if (s->exit_latency > latency_req)
>>> -			continue;
>>> +			break;
>>>   		if (s->exit_latency * multiplier > data->predicted_us)
>>> -			continue;
>>> +			break;
>>>
>>>   		data->last_state_idx =3D i;
>>>   		data->exit_us =3D s->exit_latency;
>>>
>>
>
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

