From: Amit Kachhap <amit.kachhap@linaro.org>
Subject: Re: [RFC] the generic thermal layer enhancement
Date: Thu, 31 May 2012 12:59:24 +0800
Message-ID: <CAK44p20hLTC5oLHtUizrrNDajp674UKUatxiH2bQJUnYNsM10w@mail.gmail.com>
References: <1338367742.1472.128.camel@rui.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1338367742.1472.128.camel@rui.sh.intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Jean Delvare <jdelvare@suse.com>, "Brown, Len" <len.brown@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi Rui,

Thanks for starting a discussion on further finetuning the thermal layer.

On 30 May 2012 16:49, Zhang Rui <rui.zhang@intel.com> wrote:
> Hi, all,
>
> It is great to see more and more users of the generic thermal layer.
> But as we know, the original design of the generic thermal layer comes
> from ACPI thermal management, and some of its implementation seems to be
> too ACPI specific nowadays.
Totally agreed :)
>
> Recently I'm thinking of enhance the generic thermal layer so that it
> works well for more platforms.
>
> Below are some thoughts of mine, after reading the patches from Amit
> Daniel Kachhap, and ACPI 3.0 thermal model. Actually, I have started
> coding some RFC patches. But I do really want to get feedback from you
> before going on.
>
> G1. supporting multiple cooling states for active cooling devices.
>
> =A0 =A0The current active cooling device supports two cooling states only,
> =A0 =A0please refer to the code below, in driver/thermal/thermal_sys.c
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case THERMAL_TRIP_ACTIVE:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0...
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (temp >=3D trip_temp)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cdev->ops-=
>set_cur_state(cdev, 1);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cdev->ops-=
>set_cur_state(cdev, 0);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>
> =A0 =A0This is an ACPI specific thing, as our ACPI FAN used to support
> =A0 =A0ON/OFF only.
> =A0 =A0I think it is reasonable to support multiple active cooling states
> =A0 =A0as they are common on many platforms, and note that this is also
> =A0 =A0true for ACPI 3.0 FAN device (_FPS).
Yes I agree that ACTIVE trip type should support more than 1(ON)
state. and which state the the set_cur_state should call depends on
how the state is binded on the trip point. But again in doing these
there is so much logic put in handling this that the I dropped the
patch for new trip type ACTIVE_INSTANCE.
>
> G2. introduce cooling states range for a certain trip point
>
> =A0 =A0This problem comes with the first one.
> =A0 =A0If the cooling devices support multiple cooling states, and surely
> =A0 =A0we may want only several cooling states for a certain trip point,
> =A0 =A0and other cooling states for other active trip points.
> =A0 =A0To do this, we should be able to describe the cooling device
> =A0 =A0behavior for a certain trip point, rather than for the entire
> =A0 =A0thermal zone.
Agreed
>
> G3. kernel thermal passive cooling algorithm
>
> =A0 =A0Currently, tc1 and tc2 are hard requirements for kernel passive
> =A0 =A0cooling. But non-ACPI platforms do not have this information
> =A0 =A0(please correct me if I'm wrong).
> =A0 =A0Say, for the patches here
> =A0 =A0http://marc.info/?l=3Dlinux-acpi&m=3D133681581305341&w=3D2
> =A0 =A0They just want to slow down the processor when current temperature
> =A0 =A0is higher than the trip point and speed up the processor when the
> =A0 =A0temperature is lower than the trip point.
>
> =A0 =A0According to Matthew, the platform drivers are responsible to
> =A0 =A0provide proper tc1 and tc2 values to use kernel passive cooling.
> =A0 =A0But I'm just wondering if we can use something instead.
> =A0 =A0Say, introduce .get_trend() in thermal_zone_device_ops.
> =A0 =A0And we set cur_state++ or cur_state-- based on the value returned
> =A0 =A0by .get_trend(), instead of using tc1 and tc2.
OK this seems fine. But for exynos platform(also some other platforms)
this may be simply cur_temp - last_temp which is fine.
>
> G4. Multiple passive trip points
>
> =A0 =A0I get this idea also from the patches at
> =A0 =A0http://marc.info/?l=3Dlinux-acpi&m=3D133681581305341&w=3D2
>
> =A0 =A0IMO, they want to get an acceptable performance at a tolerable
> =A0 =A0temperature.
> =A0 =A0Say, a platform with four P-states. P3 is really low.
> =A0 =A0And I'm okay with the temperature at 60C, but 80C? No.
> =A0 =A0With G2 resolved, we can use processor P0~P2 for Passive trip point
> =A0 =A00 (50C), and P3 for Passive trip point 1 (70C). And then the
> =A0 =A0temperature may be jumping at around 60C or even 65C, without
> =A0 =A0entering P3.
>
> =A0 =A0Further more, IMO, this also works for ACPI platforms.
> =A0 =A0Say, we can easily change p-state to cool the system, but using
> =A0 =A0t-state is definitely what we do not want to see. The current
> =A0 =A0implementation does not expose this difference to the generic
> =A0 =A0thermal layer, but if we can have two passive trip points, and use
> =A0 =A0p-state for the first one only... (this works if we start polling
> =A0 =A0after entering passive cooling mode, without hardware notification)
This seems cool and to answer Mathew doubt this is needed because in
the not so critical thermal envelop the platforms may not want to go
to the lowest opp level and some intermediate level is fine.

>
> G5. unify active cooling and passive cooling code
>
> =A0 =A0If G4 and G5 are resolved, a new problem to me is that there is no
> =A0 =A0difference between passive cooling and active cooling except the
> =A0 =A0cooling policy.
> =A0 =A0Then we can share the same code for both active and passive coolin=
g.
> =A0 =A0maybe something like:
>
> =A0 =A0case THERMAL_TRIP_ACTIVE:
> =A0 =A0case THERMAL_TRIP_PASSIVE:
> =A0 =A0 =A0 =A0 ...
> =A0 =A0 =A0 =A0 tz->ops->get_trend();
> =A0 =A0 =A0 =A0 if (trend =3D=3D HEATING)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cdev->ops->set_cur_state(cdev, cur_state+=
+);
> =A0 =A0 =A0 =A0 else if (trend =3D=3D COOLING)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cdev->ops->set_cur_state(cdev, cur_state-=
-);
> =A0 =A0 =A0 =A0 break;
Actually I still feels that ACTIVE and PASSIVE are needed because they
have different way of calling the set_cur_rate. ACTIVE trip type is
associated with 1 trip point so on reaching a trip point a specific
state is called in set_cur_state. But PASSIVE basically
increments/decrements the state depending on thermal trend.
>
> Here are the gaps in my point of view, I'd like to get your ideas about
> which are reasonable and which are not.
>
> Any comments are appreciated! Thanks!
>
> -rui
>
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/linux-pm
