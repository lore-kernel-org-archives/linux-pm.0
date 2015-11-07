From: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH v2 0/9] Better compatible for the rockchip thermal and support RK3368 SoCs
Date: Sun, 08 Nov 2015 00:13:27 +0100
Message-ID: <4207814.5j47hyHv2C@phil>
References: <1446700685-18017-1-git-send-email-wxt@rock-chips.com> <1509087.903MXQEqfv@phil> <563E1E7A.6010503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <563E1E7A.6010503-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Caesar Wang <caesar.upstream-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Jiri Kosina <trivial-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi Caesar,

Am Samstag, 7. November 2015, 23:53:30 schrieb Caesar Wang:
> =E5=9C=A8 2015=E5=B9=B411=E6=9C=8807=E6=97=A5 03:03, Heiko Stuebner =E5=
=86=99=E9=81=93:[]
>=20
> [....]
>=20
> > I call dibs on the devicetree patches :-) .
> >
> > Code and dt parts are very much separate, so I'd like to take the d=
t parts
> > though my tree and arm-soc to keep further dts changes together.
> > Of course only once you are ok with the code parts :-)
> >
> > Devicetree parts themselfs look ok to me.
>=20
> Many thanks, I guess that I don't need send the dts patch again.;-)
> the Code is still a bit change for thermal driver.

I think you should still send the dts patches with next revisions. I ca=
n
only take the patches, once Eduardo is satisfied with the code changes
that include the new binding, and while I hope that this will be in v3,=
 it
will be hard if we get to v5 or so, to grep through the older revisions=
,
trying to find the dts changes :-).


Heiko
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
