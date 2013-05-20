From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] cpuidle: simplify multiple driver support
Date: Mon, 20 May 2013 22:10:21 +0200
Message-ID: <519A832D.1070208@linaro.org>
References: <1368537691-10111-1-git-send-email-daniel.lezcano@linaro.org> <519762B9.5030503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f172.google.com ([74.125.82.172]:53690 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756421Ab3ETUK1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 20 May 2013 16:10:27 -0400
Received: by mail-we0-f172.google.com with SMTP id w62so693906wes.31
        for <linux-pm@vger.kernel.org>; Mon, 20 May 2013 13:10:26 -0700 (PDT)
In-Reply-To: <519762B9.5030503@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Francesco Lavra <francescolavra.fl@gmail.com>
Cc: rjw@sisk.pl, linaro-kernel@lists.linaro.org, patches@linaro.org, linux-pm@vger.kernel.org

On 05/18/2013 01:15 PM, Francesco Lavra wrote:
> On 05/14/2013 03:21 PM, Daniel Lezcano wrote:
>> Commit bf4d1b5ddb78f86078ac6ae0415802d5f0c68f92 brought the multiple=
 driver
>> support. The code added a couple of new API to register the driver p=
er cpu.
>> That led to some code complexity to handle the kernel config options=
 when
>> the multiple driver support is enabled or not, which is not really n=
ecessary.
>> The code has to be compatible when the multiple driver support is no=
t enabled,
>> and the multiple driver support has to be compatible with the old ap=
i.
>>
>> This patch removes this API, which is not yet used by any driver but=
 needed
>> for the HMP cpuidle drivers which will come soon, and replaces its u=
sage
>> by a cpumask pointer in the cpuidle driver structure telling what cp=
us are
>> handled by the driver. That let the API cpuidle_[un]register_driver =
to be used
>> for the multipled driver support and also the cpuidle_[un]register f=
unctions,
>> added recently in the cpuidle framework.
>>
>> The current code, a bit poor in comments, has been commented and sim=
plified.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> [...]

[ ... ]

Hi Francesco,

thanks for reviewing the patch.

>> -EXPORT_SYMBOL_GPL(cpuidle_unregister_driver);
>> -
>> -#else
>> -
>> -static struct cpuidle_driver *cpuidle_curr_driver;
>> +	if (!WARN_ON(drv->refcnt > 0))
>> +		return;
>=20
> Shouldn't it be
> if (WARN_ON(drv->refcnt > 0))
> 	return;
> ?

Yes, good catch !

>> -static inline void __cpuidle_set_cpu_driver(struct cpuidle_driver *=
drv, int cpu)
>> -{
>> -	cpuidle_curr_driver =3D drv;
>> -}
>> +	__cpuidle_unset_driver(drv);
>> =20
>> -static inline struct cpuidle_driver *__cpuidle_get_cpu_driver(int c=
pu)
>> -{
>> -	return cpuidle_curr_driver;
>> +	if (drv->bctimer) {
>> +		drv->bctimer =3D 0;
>> +		on_each_cpu_mask(drv->cpumask, cpuidle_setup_broadcast_timer,
>> +				 (void *)CLOCK_EVT_NOTIFY_BROADCAST_OFF, 1);
>> +	}
>>  }
>=20
> Also, shouldn't things be undone in reverse order as they were done i=
n
> __cpuidle_register_driver()? I mean disabling the timer broadcast
> notification before calling __cpuidle_unset_driver().

Yes, that makes sense.

Thanks
  -- Daniel

--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

