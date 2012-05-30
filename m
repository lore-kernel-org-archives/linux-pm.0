From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [linux-pm] [RFC] the generic thermal layer enhancement
Date: Wed, 30 May 2012 16:51:00 +0800
Message-ID: <1338367860.1472.129.camel@rui.sh.intel.com>
References: <1338367742.1472.128.camel@rui.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1338367742.1472.128.camel@rui.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Jean Delvare <jdelvare@suse.com>, "Brown, Len" <len.brown@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, Amit Kachhap <amit.kachhap@linaro.org>
List-Id: linux-pm@vger.kernel.org

On =E4=B8=89, 2012-05-30 at 16:49 +0800, Zhang Rui wrote:
> Hi, all,
>=20
> It is great to see more and more users of the generic thermal layer.
> But as we know, the original design of the generic thermal layer come=
s
> from ACPI thermal management, and some of its implementation seems to=
 be
> too ACPI specific nowadays.
>=20
> Recently I'm thinking of enhance the generic thermal layer so that it
> works well for more platforms.
>=20
> Below are some thoughts of mine, after reading the patches from Amit
> Daniel Kachhap, and ACPI 3.0 thermal model. Actually, I have started
> coding some RFC patches. But I do really want to get feedback from yo=
u
> before going on.
>=20
> G1. supporting multiple cooling states for active cooling devices.
>=20
>     The current active cooling device supports two cooling states onl=
y,
>     please refer to the code below, in driver/thermal/thermal_sys.c
>                 case THERMAL_TRIP_ACTIVE:
>                         ...
>                         if (temp >=3D trip_temp)
>                                 cdev->ops->set_cur_state(cdev, 1);
>                         else
>                                 cdev->ops->set_cur_state(cdev, 0);
>                         break;
>=20
>     This is an ACPI specific thing, as our ACPI FAN used to support
>     ON/OFF only.
>     I think it is reasonable to support multiple active cooling state=
s
>     as they are common on many platforms, and note that this is also
>     true for ACPI 3.0 FAN device (_FPS).
>=20
> G2. introduce cooling states range for a certain trip point
>=20
>     This problem comes with the first one.
>     If the cooling devices support multiple cooling states, and surel=
y
>     we may want only several cooling states for a certain trip point,
>     and other cooling states for other active trip points.
>     To do this, we should be able to describe the cooling device
>     behavior for a certain trip point, rather than for the entire
>     thermal zone.
>=20
> G3. kernel thermal passive cooling algorithm
>=20
>     Currently, tc1 and tc2 are hard requirements for kernel passive
>     cooling. But non-ACPI platforms do not have this information
>     (please correct me if I'm wrong).
>     Say, for the patches here
>     http://marc.info/?l=3Dlinux-acpi&m=3D133681581305341&w=3D2

Sorry, forgot to cc Amit, the author of this patch set.

thanks,
rui
>     They just want to slow down the processor when current temperatur=
e
>     is higher than the trip point and speed up the processor when the
>     temperature is lower than the trip point.
>=20
>     According to Matthew, the platform drivers are responsible to
>     provide proper tc1 and tc2 values to use kernel passive cooling.
>     But I'm just wondering if we can use something instead.
>     Say, introduce .get_trend() in thermal_zone_device_ops.
>     And we set cur_state++ or cur_state-- based on the value returned
>     by .get_trend(), instead of using tc1 and tc2.
>=20
> G4. Multiple passive trip points
>=20
>     I get this idea also from the patches at
>     http://marc.info/?l=3Dlinux-acpi&m=3D133681581305341&w=3D2
>=20
>     IMO, they want to get an acceptable performance at a tolerable
>     temperature.
>     Say, a platform with four P-states. P3 is really low.
>     And I'm okay with the temperature at 60C, but 80C? No.
>     With G2 resolved, we can use processor P0~P2 for Passive trip poi=
nt
>     0 (50C), and P3 for Passive trip point 1 (70C). And then the
>     temperature may be jumping at around 60C or even 65C, without
>     entering P3.
>=20
>     Further more, IMO, this also works for ACPI platforms.
>     Say, we can easily change p-state to cool the system, but using
>     t-state is definitely what we do not want to see. The current
>     implementation does not expose this difference to the generic
>     thermal layer, but if we can have two passive trip points, and us=
e
>     p-state for the first one only... (this works if we start polling
>     after entering passive cooling mode, without hardware notificatio=
n)
>=20
> G5. unify active cooling and passive cooling code
>=20
>     If G4 and G5 are resolved, a new problem to me is that there is n=
o
>     difference between passive cooling and active cooling except the
>     cooling policy.
>     Then we can share the same code for both active and passive cooli=
ng.
>     maybe something like:
>=20
>     case THERMAL_TRIP_ACTIVE:
>     case THERMAL_TRIP_PASSIVE:
>          ...
>          tz->ops->get_trend();
>          if (trend =3D=3D HEATING)
>                  cdev->ops->set_cur_state(cdev, cur_state++);
>          else if (trend =3D=3D COOLING)
>                  cdev->ops->set_cur_state(cdev, cur_state--);
>          break;
>=20
> Here are the gaps in my point of view, I'd like to get your ideas abo=
ut
> which are reasonable and which are not.
>=20
> Any comments are appreciated! Thanks!
>=20
> -rui
>=20
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/linux-pm


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
