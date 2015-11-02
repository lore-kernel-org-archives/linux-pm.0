From: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] thermal: of: Introduce governor selection in dts
Date: Mon, 2 Nov 2015 13:24:22 -0800
Message-ID: <20151102212420.GH4469@localhost.localdomain>
References: <CAM2ehZYXsqCoS9ygXNfPHxt9-b5cFxH_ovrgjvM-BfDO6REcUg@mail.gmail.com>
 <20150807103121.GC7646@leverpostej>
 <CAM2ehZYy3SNKhXvF0XyQsoPFab2JqrVq3wLKadPVxBsVG3E7jw@mail.gmail.com>
 <20150810174723.GC2747@e104805>
 <55C9BB53.1090001@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55C9BB53.1090001-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>
Cc: Javi Merino <javi.merino-5wv7dgnIgG8@public.gmane.org>, =?utf-8?B?IkNodW5nLVlpaCBXYW5nICjnjovltIfmh78pIg==?= <cywang-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <Pawel.Moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Aug 11, 2015 at 10:07:31AM +0100, Sudeep Holla wrote:
>=20
>=20
> On 10/08/15 18:47, Javi Merino wrote:
> >On Mon, Aug 10, 2015 at 09:00:49AM +0100, Chung-Yih Wang (=E7=8E=8B=E5=
=B4=87=E6=87=BF) wrote:
> >>This patch was originally introduced when we made power_allocator t=
he
> >>default governor where we had issues in binding a thermal zone w/o
> >>parameters to. Then we came out this facility for binding a specifi=
c
> >>governor to a thermal zone in dts instead of the default governor.
> >>Javi seems like this idea much.
> >
> >While I can understand why this is not suitable for devicetree, we
> >should have a way in the kernel to configure different governors for
> >different thermal zones defined in device tree.  Thermal zones defin=
ed
> >from platform code can choose the thermal governor when they are
> >registered.
> >
> >If this information can't go in device tree, where can we put it? As
> >an additional parameter to thermal_zone_of_sensor_register()?
> >
>=20
> Why can't it be via sysfs allowing users to select their choice of
> governor ? (like cpuidle/freq or even devfreq I assume)
>=20

Yes, sysfs configuration is the current recommended way.=20

Although it is tempting to have it in device tree, its
design decisions are not meant for OS implementation/specifics.

BR,

> Regards,
> Sudeep
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
