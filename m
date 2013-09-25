From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH V4 1/2] cpuidle: simplify multiple driver support
Date: Wed, 25 Sep 2013 17:02:20 +0200
Message-ID: <5242FAFC.8010905@linaro.org>
References: <1370641990-13884-1-git-send-email-daniel.lezcano@linaro.org> <CAKohponeFAc3EVEOO_Tpd61eE7UQmEmWfuaYd-VdR=UKnDFUgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:45860 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755443Ab3IYPCY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 25 Sep 2013 11:02:24 -0400
Received: by mail-wi0-f181.google.com with SMTP id ex4so5698786wid.2
        for <linux-pm@vger.kernel.org>; Wed, 25 Sep 2013 08:02:22 -0700 (PDT)
In-Reply-To: <CAKohponeFAc3EVEOO_Tpd61eE7UQmEmWfuaYd-VdR=UKnDFUgw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>, Len Brown <lenb@kernel.org>

On 09/18/2013 07:21 AM, Viresh Kumar wrote:
> On 8 June 2013 03:23, Daniel Lezcano <daniel.lezcano@linaro.org> wrot=
e:
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
>> for the multiple driver support and also the cpuidle_[un]register fu=
nctions,
>> added recently in the cpuidle framework.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>=20
> Sorry for jumping onto this thread so late :(
> The current code in cpuidle/driver.c contains two definitions of thes=
e routines:
> __cpuidle_get_cpu_driver() and __cpuidle_{set|unset}_driver(), enclos=
ed
> withing #if/else..
>=20
> These duplicate routines exist only to save some space where we don't
> have multiple drivers for a platform, right? So, that we don't waste =
up
> space for per-cpu variables for holding cpuidle_driver..

That's right.

> But what about multi platform kernels? This config option would be en=
abled
> then and we would finally run into the same problem again..
>=20
> The worst side of this is: We will run separate code paths for a plat=
form
> which doesn't have support for multiple drivers in the multiplatform =
kernel..
> Even if it works, it looks a bit wrong design wise..

Where is it wrong in design ? If the multiple driver support is enabled
in the kernel but the driver handles all the cpu, it works.

> Either we can have a runtime variable in cpuidle_driver or somewhere =
else
> that will let us know if we want multiple drivers for our platform or=
 not
>=20
> OR
>=20
> do the per-cpu stuff for everybody..

I don't think it is worth to add more code complexity to save an extra
small chunk of memory on ARM. If we don't want to support the multiple
driver, the option is disabled and we use a single variable. That is th=
e
case for x86. If we want to enable it for multiple platforms support on
ARM, then we need per-cpu and we lose a bit of per-cpu memory.

  -- Daniel

--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

