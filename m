From: Lan Tianyu <lantianyu1986-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH v2 3/6] usb: add runtime pm support for usb port device
Date: Wed, 14 Nov 2012 20:45:57 +0800
Message-ID: <50A39285.80305@gmail.com>
References: <1352793605-4168-1-git-send-email-tianyu.lan@intel.com> <5876155.rAsY9PFrXq@vostro.rjw.lan> <50A33B7D.2000100@intel.com> <2700525.6XmcYg8quR@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <2700525.6XmcYg8quR-sKB8Sp2ER+y1GS7QM15AGw@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Cc: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, oneukum-l3A5Bk7waGM@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

=E4=BA=8E 2012/11/14 17:49, Rafael J. Wysocki =E5=86=99=E9=81=93:
> On Wednesday, November 14, 2012 02:34:37 PM Lan Tianyu wrote:
>> On 2012=E5=B9=B411=E6=9C=8814=E6=97=A5 08:08, Rafael J. Wysocki wrot=
e:
>>> On Tuesday, November 13, 2012 04:00:02 PM Lan Tianyu wrote:
>>>> This patch is to add runtime pm callback for usb port device.
>>>> Set/clear PORT_POWER feature in the resume/suspend callbak.
>>>> Add portnum for struct usb_port to record port number.
>>>>
>>>> Signed-off-by: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>>>
>>> This one looks reasonable to me.  From the PM side
>>>
>>> Acked-by: Rafael J. Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>> Hi Rafael and Alan:
>> 	This patch has a collaboration problem with pm qos. Since pm core w=
ould
>> pm_runtime_get_sync/put(port_dev) if pm qos flags was changed and po=
rt's
>> suspend call_back() clear PORT_POWER feature without any check. This
>> will cause PORT_POWER feather being cleared every time after pm qos
>> flags being changed.
>>
>> 	I have an idea that add check in the port's runtime idle callback.
>> Check NO_POWER_OFF flag firstly. If set return. Second, for port wit=
hout
>> device, suspend port directly and for port with device, increase chi=
ld
>> device's runtime usage without resume and do barrier to ensure all
>> suspend process finish, at last check the child runtime status. If i=
t
>> was suspended, suspend port and if do nothing.
>>
>> static int usb_port_runtime_idle(struct device *dev)
>> {
>> 	struct usb_port *port_dev =3D to_usb_port(dev);
>> 	int retval =3D 0;
>>
>> 	if (dev_pm_qos_flags(&port_dev->dev, PM_QOS_FLAG_NO_POWER_OFF)
>> 			=3D=3D PM_QOS_FLAGS_ALL)
>> 		return 0;
>>
>> 	if (!port_dev->child) {
>> 		retval =3D pm_runtime_suspend(&port_dev->dev);
>> 		if (!retval)
>> 			port_dev->power_on =3Dfalse;
>> 	}
>> 	else {
>
> This usually is written as "} else {" in the kernel code.
>
>> 		pm_runtime_get_noresume(&port_dev->child->dev);
>> 		pm_runtime_barrier(&port_dev->child->dev);
>> 		if (port_dev->child->dev.power.runtime_status
>> 				=3D=3D RPM_SUSPENDED) {
>> 			retval =3D pm_runtime_suspend(&port_dev->dev);
>> 			if (!retval)
>> 				port_dev->power_on =3Dfalse;
>> 		}=09
>> 		pm_runtime_put_noidle(&port_dev->child->dev);
>> 	}
>
> Hmm.  If child->dev is not suspended, then our usage_count should be
> at least 1, so pm_runtime_suspend(&port_dev->dev) shouldn't actually
> suspend us.  Isn't that the case?
No, because the child device is not under port device and so even if
child->dev is not suspended, port device's usage still can be 0 and
power off the port.
>
> Rafael
>
>

--=20
Best regards
Tianyu Lan
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
