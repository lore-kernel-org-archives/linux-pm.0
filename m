From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] cpuidle - fix lock contention in the idle path
Date: Mon, 07 Jan 2013 00:07:00 +0100
Message-ID: <50EA0394.9020701@linaro.org>
References: <1356516108-11191-1-git-send-email-daniel.lezcano@linaro.org> <20130102211314.GA29447@sgi.com> <50E6764C.9060608@linaro.org> <3077900.eue4T2ZoF8@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3077900.eue4T2ZoF8@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Russ Anderson <rja@sgi.com>, linux-pm@vger.kernel.org, pdeschrijver@nvidia.com, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, rja@americas.sgi.com
List-Id: linux-pm@vger.kernel.org


[ ... ]

>>>> The following patch is a hot fix by returning to the initial behav=
ior
>>>> by removing the lock when getting the driver.
>>>
>>> The patch fixes the problem.  Verified on a system with 1024 cpus.
>>> Thanks.
>>>
>>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>
>>> Reported-by: Russ Anderson <rja@sgi.com>
>>> Acked-by: Russ Anderson <rja@sgi.com>
>>
>> Hi Rafael,
>>
>> could you consider this patch for merging ?
>=20
> Yes, I've taken it already.
>=20
> I'll include it into the next pull request.

Ok, thanks.

I noticed you rephrased the changelog. Thanks for that also.

 -- Daniel



--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

  * English - detected
  * English
  * French

  * English
  * French

 <javascript:void(0);> <#>
