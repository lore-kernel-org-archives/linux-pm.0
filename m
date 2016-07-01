From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v4] cpuidle: Fix last_residency division
Date: Fri, 1 Jul 2016 10:06:59 +0200
Message-ID: <577624A3.2000406@linaro.org>
References: <1467297253-2171-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <5775335E.2040003@linaro.org>
 <alpine.LFD.2.20.1606301132350.12094@knanqh.ubzr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:37396 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752669AbcGAIHA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 1 Jul 2016 04:07:00 -0400
Received: by mail-wm0-f44.google.com with SMTP id a66so17833097wme.0
        for <linux-pm@vger.kernel.org>; Fri, 01 Jul 2016 01:07:00 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.20.1606301132350.12094@knanqh.ubzr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, anton@samba.org, mpe@ellerman.id.au, bsingharora@gmail.com, David.Laight@ACULAB.COM, arnd@arndb.de

On 06/30/2016 05:37 PM, Nicolas Pitre wrote:
> On Thu, 30 Jun 2016, Daniel Lezcano wrote:

[ ... ]

>>> +	if (likely(nsec < DIV_APPROXIMATION_THRESHOLD)) {
>>> +		u32 usec =3D nsec;
>>> +
>>> +		usec +=3D usec >> 5;
>>> +		usec =3D usec >> 10;
>>> +
>>> +		/* Can safely cast to int since usec is < INT_MAX */
>>> +		return usec;
>>> +	} else {
>>> +		u64 usec =3D div_u64(nsec, 1000);
>>> +
>>> +		if (usec > INT_MAX)
>>> +			usec =3D INT_MAX;
>>> +
>>> +		/* Can safely cast to int since usec is < INT_MAX */
>>> +		return usec;
>>> +	}
>>> +}
>>
>>
>> What bothers me with this division is the benefit of adding an extra=
 ultra
>> optimized division by 1000 in cpuidle.h while we have already ktime_=
divns
>> which is optimized in ktime.h.
>
> It is "optimized" but still much heavier than what is presented above=
 as
> it provides maximum precision.
>
> It all depends on how important the performance gain from the origina=
l
> shift by 10 was in the first place.

Actually the original shift was there because it was convenient as a=20
simple ~div1000 operation. But against all odds, the approximation=20
introduced a regression on a very specific use case on PowerPC.

We are not in the hot path and I think we can live with a ktime_divns=20
without problem. That would simplify the fix I believe.

Perhaps the div1000 routine could be moved in ktime.h to be used as a=20
helper for ktime_divns when we divide by the 1000 constant and submitte=
d=20
in a separate patch as an optimization.

--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

