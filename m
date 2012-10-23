From: Lan Tianyu <lantianyu1986@gmail.com>
Subject: Re: USB port power off discussion
Date: Tue, 23 Oct 2012 22:47:38 +0800
Message-ID: <5086AE0A.3010608@gmail.com>
References: <Pine.LNX.4.44L0.1210221422380.1724-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:59541 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754994Ab2JWOry (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 23 Oct 2012 10:47:54 -0400
In-Reply-To: <Pine.LNX.4.44L0.1210221422380.1724-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Sarah Sharp <sarah.a.sharp@linux.intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Lan Tianyu <tianyu.lan@intel.com>, Greg KH <gregkh@linuxfoundation.org>, Len Brown <lenb@kernel.org>, Arjan Van De Ven <arjan@linux.intel.com>, Oliver Neukum <oneukum@suse.de>, USB list <linux-usb@vger.kernel.org>, Linux-pm mailing list <linux-pm@vger.kernel.org>

=E4=BA=8E 2012/10/23 2:37, Alan Stern =E5=86=99=E9=81=93:
> On Mon, 22 Oct 2012, Sarah Sharp wrote:
>
>> On Mon, Oct 15, 2012 at 08:42:47AM +0200, Rafael J. Wysocki wrote:
>>> Sorry for the delay, I have been distracted by a number of things.
>>
>> Me too. :)
>>
>>> On Monday 24 of September 2012 15:10:36 Sarah Sharp wrote:
>>>> On Tue, Sep 25, 2012 at 12:09:06AM +0200, Rafael J. Wysocki wrote:
>>>>> What about hubs connected to such ports?  I don't think they're g=
oing to
>>>>> work when power is removed from it, are they?
>>>>
>>>> USB hubs would have remote wakeup enabled, so we would never power=
 off
>>>> their port with the "auto" policy.
>>>
>>> Here's my idea how to arrange things.
>>>
>>> Why don't make runtime PM manage the USB port power on/off such tha=
t the
>>> port's .runtime_suspend() routine will remove power from it, if
>>> PM_QOS_FLAG_NO_POWER_OFF is not (effectively) set for it, and its
>>> .runtime_resume() will restore power to it (if removed previously).
>>
>> Ok, so you're basically proposing we power off suspended devices, ex=
cept
>> when userspace (or perhaps the kernel) sets PM_QOS_FLAG_NO_POWER_OFF=
?
>
> Rafael is suggesting that the interface to control when ports get
> powered off should be associated with the usb_port device, rather tha=
n
> with the usb_device attached to the port.

That means we should add a driver for usb port device?

>
>> What happens if userspace clears the PM_QOS_FLAG_NO_POWER_OFF flag w=
hile
>> the port is suspended?  Does the USB core then re-power it on?  Shou=
ld
>> it also resume the device?
>
> I don't know how the PM QOS flags interact with runtime PM.  Rafael m=
ay
> still be working on that.
I think we can add a notifier event for PM Qos flags, just like the one=
 for
PM Qos latency. Add notifier callback to check whether PM_QOS_FLAG_NO_P=
OWER_OFF
is clear or set when flags was changed.

=46or both setting or clearing PM_QOS_FLAG_NO_POWER_OFF, invoking=20
pm_runtime_get_sync()
to resume port device and then pm_runtime_put_sync()(device will be sus=
pended again
and power off or not depending on the setting).

>
> At any rate, runtime suspend for the usb_port will remove power.
> Runtime resume will turn power back on.  But if there's a usb_device
> attached to the port, resuming the port will not necessarily resume t=
he
> device.  (However, we will be careful to make sure that the port cann=
ot
> be runtime suspended unless the device is suspended first.)
>
>>> The USB core will then do pm_runtime_get_sync() on the port every t=
ime
>>> a device depending on it is added and pm_runtime_put() every time s=
uch
>>> a device is removed.
>>
>> Are you saying that every time a device is connected to an _external=
_
>> hub, the USB core would call pm_runtime_get_sync()?  If you apply th=
at
>> policy to roothubs, then you're basically disabling port power off w=
hen
>> a device is connected, which doesn't make sense in conjunction to yo=
ur
>> last sentence, so now I'm just confused, sorry.
>
> He is saying that the core would call pm_runtime_get_sync(&port->dev)=
,
> not pm_runtime_get_sync(&udev->dev).  And this would only be for whil=
e
> the device was active, not for when the device is suspended (unless t=
he
> device can't handle loss of power).
>
>> Wouldn't it make more sense to call pm_runtime_get_sync() when remot=
e
>> wakeup is enabled for a device, and pm_runtime_put() when remote wak=
eup
>> is disabled?  That way, when an external hub is attached to the port=
, it
>> always has remote wakeup enabled, so we will always increment the PM
>> counter. [1]
>>
>>> The initial setting of PM_QOS_FLAG_NO_POWER_OFF in the PM QoS reque=
st
>>> structure used by user space will depend on the type of the port (e=
=2Eg.
>>> it will be unset for ports that aren't visible to the user and conn=
ectable).
>>>
>>> That should allow things to work automatically and it should allow =
user space
>>> to override the defaults in any case, either by disabling runtime P=
M for the
>>> ports altogether (by writing "on" to their device objects' "control=
" sysfs
>>> files), or by setting/unsetting PM_QOS_FLAG_NO_POWER_OFF in the PM =
QoS
>>> request controlled by it as desired.
>>
>> Are you then pushing the policy decision for whether ports should be
>> powered off completely into userspace then?  I.e. you want userspace=
 to
>> read the ACPI port connect type info and clear PM_QOS_FLAG_NO_POWER_=
OFF
>> in the userspace structure if the port is not user visible and not
>> connectable?
>>
>> Or are you thinking the kernel will set PM_QOS_FLAG_NO_POWER_OFF bas=
ed
>> on the ACPI tables and userspace will have the option to override it=
?
>
> The latter.
>
>> We also probably need to allow USB interface drivers to set
>> PM_QOS_FLAG_NO_POWER_OFF as well, for cases like devices that have
>> firmware or other internal state.  We probably need a USB core API t=
o
>> add a request for PM_QOS_FLAG_NO_POWER_OFF to be set, and a way to c=
lear
>> that flag if the driver is unbound or the driver decides it's safe t=
o
>> power off the device.
>
> How about adding a no_power_off flag to the usb_interface structure,
> analogous to the needs_remote_wakeup flag?
I think we can add a new request for kernel space to set pm qos flags.
Now Rafael has added a request for user space. Because user choice shou=
ld
be kept. So we should add one for kernel space. We can issue the reques=
t
where a device can not be power off in the driver or remote wakeup is
enabled/disabled.

usb interfaces also have pm qos flags in their struct device. So we can
reuse it. When usb device are being suspended, check all its interface
NO_POWER_OFF flag and issue request to set its NO_POWER_OFF flag.

>
> Alan Stern
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--=20
Best regards
Tianyu Lan
