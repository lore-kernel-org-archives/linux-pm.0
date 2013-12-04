From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] cpuidle: Check for dev before deregistering it.
Date: Wed, 04 Dec 2013 22:24:25 +0100
Message-ID: <529F9D89.9000504@linaro.org>
References: <1386086398-3686-1-git-send-email-konrad.wilk@oracle.com> <3652709.SMvyaH5n9G@vostro.rjw.lan> <529EF184.3090000@linaro.org> <20131204160911.GB391@pegasus.dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:39664 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754286Ab3LDVYR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 4 Dec 2013 16:24:17 -0500
Received: by mail-wi0-f178.google.com with SMTP id ca18so8861574wib.17
        for <linux-pm@vger.kernel.org>; Wed, 04 Dec 2013 13:24:15 -0800 (PST)
In-Reply-To: <20131204160911.GB391@pegasus.dumpdata.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org

On 12/04/2013 05:09 PM, Konrad Rzeszutek Wilk wrote:
> On Wed, Dec 04, 2013 at 10:10:28AM +0100, Daniel Lezcano wrote:
>> On 12/03/2013 10:33 PM, Rafael J. Wysocki wrote:
>>> On Tuesday, December 03, 2013 10:59:58 AM Konrad Rzeszutek Wilk wro=
te:
>>>> If not, we could end up in the unfortunate situation where
>>>> we dereference a NULL pointer b/c we have cpuidle disabled.
>>>>
>>>> This is the case when booting under Xen (which uses the
>>>> ACPI P/C states but disables the CPU idle driver) - and can
>>>> be easily reproduced when booting with cpuidle.off=3D1.
>>>>
>>>> BUG: unable to handle kernel NULL pointer dereference at          =
 (null)
>>>> IP: [<ffffffff8156db4a>] cpuidle_unregister_device+0x2a/0x90
>>>> .. snip..
>>>> Call Trace:
>>>>   [<ffffffff813b15b4>] acpi_processor_power_exit+0x3c/0x5c
>>>>   [<ffffffff813af0a9>] acpi_processor_stop+0x61/0xb6
>>>>   [<ffffffff814215bf>] __device_release_driver+0fffff81421653>] de=
vice_release_driver+0x23/0x30
>>>>   [<ffffffff81420ed8>] bus_remove_device+0x108/0x180
>>>>   [<ffffffff8141d9d9>] device_del+0x129/0x1c0
>>>>   [<ffffffff813cb4b0>] ? unregister_xenbus_watch+0x1f0/0x1f0
>>>>   [<ffffffff8141da8e>] device_unregister+0x1e/0x60
>>>>   [<ffffffff814243e9>] unregister_cpu+0x39/0x60
>>>>   [<ffffffff81019e03>] arch_unregister_cpu+0x23/0x30
>>>>   [<ffffffff813c3c51>] handle_vcpu_hotplug_event+0xc1/0xe0
>>>>   [<ffffffff813cb4f5>] xenwatch_thread+0x45/0x120
>>>>   [<ffffffff810af010>] ? abort_exclusive_wait+0xb0/0xb0
>>>>   [<ffffffff8108ec42>] kthread+0xd2/0xf0
>>>>   [<ffffffff8108eb70>] ? kthread_create_on_node+0x180/0x180
>>>>   [<ffffffff816ce17c>] ret_from_fork+0x7c/0xb0
>>>>   [<ffffffff8108eb70>] ? kthread_create_on_node+0x180/0x180
>>>>
>>>> This problem also appears in 3.12 and could be a candidate for bac=
kport.
>>>>
>>>> CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>>>> CC: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>> CC: linux-pm@vger.kernel.org
>>>> Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>>>
>>> Applied, thanks!
>>>
>>>> ---
>>>>   drivers/cpuidle/cpuidle.c | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
>>>> index 2a991e4..a55e68f 100644
>>>> --- a/drivers/cpuidle/cpuidle.c
>>>> +++ b/drivers/cpuidle/cpuidle.c
>>>> @@ -400,7 +400,7 @@ EXPORT_SYMBOL_GPL(cpuidle_register_device);
>>>>    */
>>>>   void cpuidle_unregister_device(struct cpuidle_device *dev)
>>>>   {
>>>> -	if (dev->registered =3D=3D 0)
>>>> +	if (!dev || dev->registered =3D=3D 0)
>>>>   		return;
>>>>
>>>>   	cpuidle_pause_and_lock();
>>
>> Oops, wait. Are we sure the problem is coming from cpuidle ?
>
> It is acpi_processor_power_exit assuming that the cpuidle is
> initialized. It could be fixed there too, but there are multiple
> entries in cpuidle where it does the : "if (!dev) return .."
> so I figured this should be done as well here.

I understand.

 From my POV the bug is coming from the acpi processor idle driver.

The function acpi_processor_power_init registers the cpuidle driver and=
=20
the cpuidle device when acpi_processor_registered is zero. Then it=20
increments acpi_processor_registered preventing the next call to this=20
function to register the driver but it will register the device.

As cpuidle is disabled, the cpuidle_register_driver fails, thus the=20
device is not registered and acpi_processor_registered is not=20
incremented. So all calls to acpi_processor_power_init prevents the=20
driver and the device to be registered. No problem with that.

But the function acpi_processor_power_exit does not take care of the=20
value of acpi_processor_registered and just unregister the device. Then=
=20
it decrements acpi_processor_registered which is zero to -1.

Trying to be immune from a NULL pointer in cpuidle_unregister_device=20
hides bogus code from the caller. So IMO, this check shouldn't be there=
=20
and the acpi_processor_power_exit function should be fixed instead.


>> The cpuidle_unregister_device is called with a NULL pointer, that
>> shouldn't happen.
>
> It does :-)
>>
>> Konrad, you say that could be easily reproduced. How do you produce
>> it ? Unplugging a cpu ?
>
> Yes.
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

