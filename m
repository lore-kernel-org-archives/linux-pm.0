From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] ARM/cpuidle: remove __init tag from Calxeda cpuidle probe
 function
Date: Sat, 14 Dec 2013 10:04:20 +0100
Message-ID: <52AC1F14.9090602@linaro.org>
References: <1386967759-12952-1-git-send-email-andre.przywara@linaro.org> <52AB82CD.3040100@linaro.org> <52AB8E8D.70806@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:45270 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752040Ab3LNJEW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 14 Dec 2013 04:04:22 -0500
Received: by mail-wg0-f41.google.com with SMTP id y10so238059wgg.2
        for <linux-pm@vger.kernel.org>; Sat, 14 Dec 2013 01:04:20 -0800 (PST)
In-Reply-To: <52AB8E8D.70806@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andre Przywara <andre.przywara@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, rob.herring@calxeda.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 12/13/2013 11:47 PM, Andre Przywara wrote:
> On 12/13/2013 10:57 PM, Daniel Lezcano wrote:
>> On 12/13/2013 09:49 PM, Andre Przywara wrote:
>>> Commit 60a66e370007e8535b7a561353b07b37deaf35ba changed the Calxeda
>>> cpuidle driver to a platform driver, copying the __init tag from th=
e
>>> _init() to the newly used _probe() function. However, "probe should
>>> not be __init." (Rob said ;-)
>>> Remove the __init tag to fix a section mismatch in the Calxeda
>>> cpuidle driver.
>>>
>>> Signed-off-by: Andre Przywara <andre.przywara@linaro.org>
>>> ---
>>
>> Applied to my tree for 3.14.
>
> Daniel,
>
> thanks!
> But since this is a regression (3.12 compiles fine), can someone plea=
se
> push this still for 3.13? If I am not mistaken, the rework was
> introduced in the last merge window, so I'd consider this a bug fix.

Yep. Done.

   -- Daniel

>> Thanks for the fix.
>
>>
>>    -- Daniel
>>
>>>   drivers/cpuidle/cpuidle-calxeda.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/cpuidle/cpuidle-calxeda.c
>>> b/drivers/cpuidle/cpuidle-calxeda.c
>>> index 3679563..6e51114 100644
>>> --- a/drivers/cpuidle/cpuidle-calxeda.c
>>> +++ b/drivers/cpuidle/cpuidle-calxeda.c
>>> @@ -65,7 +65,7 @@ static struct cpuidle_driver calxeda_idle_driver =
=3D {
>>>       .state_count =3D 2,
>>>   };
>>>
>>> -static int __init calxeda_cpuidle_probe(struct platform_device *pd=
ev)
>>> +static int calxeda_cpuidle_probe(struct platform_device *pdev)
>>>   {
>>>       return cpuidle_register(&calxeda_idle_driver, NULL);
>>>   }
>>>
>>
>>
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

