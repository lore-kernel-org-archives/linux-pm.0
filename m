From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] cpuidle - fix lock contention in the idle path
Date: Fri, 04 Jan 2013 07:27:24 +0100
Message-ID: <50E6764C.9060608@linaro.org>
References: <1356516108-11191-1-git-send-email-daniel.lezcano@linaro.org> <20130102211314.GA29447@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:63657 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751186Ab3ADG12 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 4 Jan 2013 01:27:28 -0500
Received: by mail-wg0-f47.google.com with SMTP id dq11so7567804wgb.14
        for <linux-pm@vger.kernel.org>; Thu, 03 Jan 2013 22:27:27 -0800 (PST)
In-Reply-To: <20130102211314.GA29447@sgi.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rafael.j.wysocki@intel.com
Cc: Russ Anderson <rja@sgi.com>, linux-pm@vger.kernel.org, pdeschrijver@nvidia.com, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, rja@americas.sgi.com

On 01/02/2013 10:13 PM, Russ Anderson wrote:
> On Wed, Dec 26, 2012 at 11:01:48AM +0100, Daniel Lezcano wrote:
>> The commit bf4d1b5ddb78f86078ac6ae0415802d5f0c68f92 introduces
>> a lock in the cpuidle_get_cpu_driver function. This function
>> is used in the idle_call function.
>>
>> The problem is the contention with a large number of cpus because
>> they try to access the idle routine at the same time.
>>
>> The lock could be safely removed because of how is used the
>> cpuidle api. The cpuidle_register_driver is called first but
>> until the cpuidle_register_device is not called we don't
>> enter in the cpuidle idle call function because the device
>> is not enabled.
>>
>> The cpuidle_unregister_driver function, leading the a NULL driver,
>> is not called before the cpuidle_unregister_device.
>>
>> This is how is used the cpuidle api from the different drivers.
>>
>> However, a cleanup around the lock and a proper refcounting
>> mechanism should be used to ensure the consistency in the api,
>> like cpuidle_unregister_driver should failed if its refcounting
>> is not 0.
>>
>> These modifications will need some code reorganization and rewrite
>> which does not fit with a fix.
>=20
> I agree.
>=20
>> The following patch is a hot fix by returning to the initial behavio=
r
>> by removing the lock when getting the driver.
>=20
> The patch fixes the problem.  Verified on a system with 1024 cpus.
> Thanks.
>=20
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>=20
> Reported-by: Russ Anderson <rja@sgi.com>
> Acked-by: Russ Anderson <rja@sgi.com>

Hi Rafael,

could you consider this patch for merging ?

Thanks
  -- Daniel


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

