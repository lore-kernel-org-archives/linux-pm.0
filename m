From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] cpuidle: fix unremovable issue for module driver
Date: Tue, 30 Jul 2013 13:19:46 +0200
Message-ID: <51F7A152.3030602@linaro.org>
References: <1375167319-12821-1-git-send-email-dongsheng.wang@freescale.com> <51F7872F.30101@linaro.org> <ABB05CD9C9F68C46A5CEDC7F15439259FEF32C@039-SN2MPN1-021.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:54528 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751482Ab3G3LTp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jul 2013 07:19:45 -0400
Received: by mail-wi0-f169.google.com with SMTP id f14so1963263wiw.0
        for <linux-pm@vger.kernel.org>; Tue, 30 Jul 2013 04:19:44 -0700 (PDT)
In-Reply-To: <ABB05CD9C9F68C46A5CEDC7F15439259FEF32C@039-SN2MPN1-021.039d.mgd.msft.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wang Dongsheng-B40534 <B40534@freescale.com>
Cc: "rjw@sisk.pl" <rjw@sisk.pl>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>

On 07/30/2013 12:48 PM, Wang Dongsheng-B40534 wrote:
>=20
>=20
>> -----Original Message-----
>> From: Daniel Lezcano [mailto:daniel.lezcano@linaro.org]
>> Sent: Tuesday, July 30, 2013 5:28 PM
>> To: Wang Dongsheng-B40534
>> Cc: rjw@sisk.pl; linux-pm@vger.kernel.org; linuxppc-dev@lists.ozlabs=
=2Eorg
>> Subject: Re: [PATCH] cpuidle: fix unremovable issue for module drive=
r
>>
>> On 07/30/2013 08:55 AM, Dongsheng Wang wrote:
>>> From: Wang Dongsheng <dongsheng.wang@freescale.com>
>>>
>>> After __cpuidle_register_device, the cpu incs are added up, but dec=
s
>>> are not, thus the module refcount is not match. So the module "exit=
"
>>> function can not be executed when we do remove operation. Move
>>> module_put into __cpuidle_register_device to fix it.
>>
>> Sorry, I still don't get it :/
>>
>> register->module_get
>> unregister->module_put
>>
>> you change it by:
>>
>> register->module_get
>> register->module_put
>> unregister->none
>>
>> which is wrong.
>>
> module_get->set per cpu incs=3D1
> module_put->set per cpu decs=3D1
>=20
> module_refcount-> incs - decs;
>=20
> "unregister" usually call in module->exit function.=20
> But if module_refcount is not zero, the module->exit() cannot be exec=
uted.

Ok, IIUC, the refcount is decremented in the unregister function but
this one is never called because the refcount is not zero.

=46unny, that means the module format was *never* used at all as it doe=
s
not work.

I am wondering if we shouldn't just remove the module support for
cpuidle. Rafael ?

> See, kernel/module.c +874
> delete_module()-->try_stop_module();

Thanks, I believe I understand the refcount mechanism.

> Test Log:
> root:~# rmmod cpuidle-e500
> module_refcount: incs[9], decs[1]
> rmmod: can't unload 'cpuidle_e500': Resource temporarily unavailable
>=20
>> Can you describe the problem you are facing ? (a bit more than "I ca=
n't
>> unload the module").
>>
>>> Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
>>>
>>> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
>>> index d75040d..e964ada 100644
>>> --- a/drivers/cpuidle/cpuidle.c
>>> +++ b/drivers/cpuidle/cpuidle.c
>>> @@ -351,11 +351,8 @@ EXPORT_SYMBOL_GPL(cpuidle_disable_device);
>>>
>>>  static void __cpuidle_unregister_device(struct cpuidle_device *dev=
)
>>> {
>>> -	struct cpuidle_driver *drv =3D cpuidle_get_cpu_driver(dev);
>>> -
>>>  	list_del(&dev->device_list);
>>>  	per_cpu(cpuidle_devices, dev->cpu) =3D NULL;
>>> -	module_put(drv->owner);
>>>  }
>>>
>>>  static int __cpuidle_device_init(struct cpuidle_device *dev) @@
>>> -384,6 +381,8 @@ static int __cpuidle_register_device(struct
>> cpuidle_device *dev)
>>>  	per_cpu(cpuidle_devices, dev->cpu) =3D dev;
>>>  	list_add(&dev->device_list, &cpuidle_detected_devices);
>>>
>>> +	module_put(drv->owner);
>>> +
>>>  	ret =3D cpuidle_coupled_register_device(dev);
>>>  	if (ret) {
>>>  		__cpuidle_unregister_device(dev);
>>>



--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

