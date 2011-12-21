From: Amit Kachhap <amit.kachhap@linaro.org>
Subject: Re: [RFC PATCH 1/2] thermal: Add a new trip type to use
 cooling device instance number
Date: Wed, 21 Dec 2011 10:38:43 +0530
Message-ID: <CAK44p232PbvGRXKB7_3TYn0Q3iqgRJg6Qv81W_EwXCHL+79baA@mail.gmail.com>
References: <1323789196-4942-1-git-send-email-amit.kachhap@linaro.org>
	<1323789196-4942-2-git-send-email-amit.kachhap@linaro.org>
	<CAKfTPtCVtWfdUpW=Up6eWTsceBCfER5NcvjF1KRTNcqys2YArQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1015661466215579248=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <CAKfTPtCVtWfdUpW=Up6eWTsceBCfER5NcvjF1KRTNcqys2YArQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, linaro-dev@lists.linaro.org, linux-kernel@vger.kernel.org, patches@linaro.org
List-Id: linux-pm@vger.kernel.org

--===============1015661466215579248==
Content-Type: multipart/alternative; boundary=00248c768f6a83ef0c04b4932d73

--00248c768f6a83ef0c04b4932d73
Content-Type: text/plain; charset=ISO-8859-1

Hi Vincent,

Thanks for the review.
Well actually your are correct that current temperature and last
temperature can be used to increase or decrease the cufreq. But this has to
be done again in cooling devices so to make the cooling devices generic and
to avoid the temperature comparision again this new trip type passes the
cooling device instance id.
Also about your queries that this may add dependency between trip index and
cooling state. This is actually needed and this dependency is created when
the cooling device is binded with trip points(For cpufreq type cooling
device just the instance of cooling device is associated with trip points).
More over the existing PASSIVE cooling trip type does the same thing and
iterates across all the cooling state.

Thanks,
Amit Daniel

On 20 December 2011 18:07, Vincent Guittot <vincent.guittot@linaro.org>wrote:

> Hi Amit,
>
> I'm not sure that using the trip index for setting the state of a
> cooling device is a generic solution because you are adding a
> dependency between the trip index and the cooling device state that
> might be difficult to handle. This dependency implies that a cooling
> device like cpufreq_cooling_device must be registered in the 1st trips
> of a thermal_zone which is not possible when we want to register 2
> cpufreq_cooling_devices in the same thermal_zone.
> You should only rely on the current and last temperatures to detect if
> a trip_temp has been crossed and you should increase or decrease the
> current state of the cooling device accordingly.
>
> something like below should work with cpufreq_cooling_device and will
> not add any constraint on the trip index. The state of a cooling
> device is increased/decreased once for each trip
>
> +               case THERMAL_TRIP_STATE_ACTIVE:
> +                       list_for_each_entry(instance, &tz->cooling_devices,
> +                                           node) {
> +                               if (instance->trip != count)
> +                                       continue;
> +
> +                               cdev = instance->cdev;
> +
> +                               if ((temp >= trip_temp)
> +                                       && (trip_temp >
> tz->last_temperature)) {
> +                                       cdev->ops->get_max_state(cdev,
> +                                                       &max_state);
> +                                       cdev->ops->get_cur_state(cdev,
> +                                                       &current_state);
> +                                       if (++current_state <= max_state)
> +
> cdev->ops->set_cur_state(cdev,
> +
> current_state);
> +                               }
> +                               else if ((temp < trip_temp)
> +                                       && (trip_temp <=
> tz->last_temperature)) {
> +                                       cdev->ops->get_cur_state(cdev,
> +                                                       &current_state);
> +                                       if (current_state > 0)
> +
> cdev->ops->set_cur_state(cdev,
> +
> --current_state);
> +                       }
> +                       break;
>
> Regards,
> Vincent
>
> On 13 December 2011 16:13, Amit Daniel Kachhap <amit.kachhap@linaro.org>
> wrote:
> > This patch adds a new trip type THERMAL_TRIP_STATE_ACTIVE. This
> > trip behaves same as THERMAL_TRIP_ACTIVE but also passes the cooling
> > device instance number. This helps the cooling device registered as
> > different instances to perform appropriate cooling action decision in
> > the set_cur_state call back function.
> >
> > Also since the trip temperature's are in ascending order so some logic
> > is put in place to skip the un-necessary checks.
> >
> > Signed-off-by: Amit Daniel Kachhap <amit.kachhap@linaro.org>
> > ---
> >  Documentation/thermal/sysfs-api.txt |    4 ++--
> >  drivers/thermal/thermal_sys.c       |   27 ++++++++++++++++++++++++++-
> >  include/linux/thermal.h             |    1 +
> >  3 files changed, 29 insertions(+), 3 deletions(-)
> >
> > diff --git a/Documentation/thermal/sysfs-api.txt
> b/Documentation/thermal/sysfs-api.txt
> > index b61e46f..5c1d44e 100644
> > --- a/Documentation/thermal/sysfs-api.txt
> > +++ b/Documentation/thermal/sysfs-api.txt
> > @@ -184,8 +184,8 @@ trip_point_[0-*]_temp
> >
> >  trip_point_[0-*]_type
> >        Strings which indicate the type of the trip point.
> > -       E.g. it can be one of critical, hot, passive, active[0-*] for
> ACPI
> > -       thermal zone.
> > +       E.g. it can be one of critical, hot, passive, active[0-1],
> > +       state-active[0-*] for ACPI thermal zone.
> >        RO, Optional
> >
> >  cdev[0-*]
> > diff --git a/drivers/thermal/thermal_sys.c
> b/drivers/thermal/thermal_sys.c
> > index dd9a574..72b1ab3 100644
> > --- a/drivers/thermal/thermal_sys.c
> > +++ b/drivers/thermal/thermal_sys.c
> > @@ -192,6 +192,8 @@ trip_point_type_show(struct device *dev, struct
> device_attribute *attr,
> >                return sprintf(buf, "passive\n");
> >        case THERMAL_TRIP_ACTIVE:
> >                return sprintf(buf, "active\n");
> > +       case THERMAL_TRIP_STATE_ACTIVE:
> > +               return sprintf(buf, "state-active\n");
> >        default:
> >                return sprintf(buf, "unknown\n");
> >        }
> > @@ -1035,7 +1037,7 @@ EXPORT_SYMBOL(thermal_cooling_device_unregister);
> >  void thermal_zone_device_update(struct thermal_zone_device *tz)
> >  {
> >        int count, ret = 0;
> > -       long temp, trip_temp;
> > +       long temp, trip_temp, max_state, last_trip_change = 0;
> >        enum thermal_trip_type trip_type;
> >        struct thermal_cooling_device_instance *instance;
> >        struct thermal_cooling_device *cdev;
> > @@ -1086,6 +1088,29 @@ void thermal_zone_device_update(struct
> thermal_zone_device *tz)
> >                                        cdev->ops->set_cur_state(cdev, 0);
> >                        }
> >                        break;
> > +               case THERMAL_TRIP_STATE_ACTIVE:
> > +                       list_for_each_entry(instance,
> &tz->cooling_devices,
> > +                                           node) {
> > +                               if (instance->trip != count)
> > +                                       continue;
> > +
> > +                               if (temp <= last_trip_change)
> > +                                       continue;
> > +
> > +                               cdev = instance->cdev;
> > +                               cdev->ops->get_max_state(cdev,
> &max_state);
> > +
> > +                               if ((temp >= trip_temp) &&
> > +                                               ((count + 1) <=
> max_state))
> > +                                       cdev->ops->set_cur_state(cdev,
> > +                                                               count +
> 1);
> > +                               else if ((temp < trip_temp) &&
> > +                                                       (count <=
> max_state))
> > +                                       cdev->ops->set_cur_state(cdev,
> count);
> > +
> > +                               last_trip_change = trip_temp;
> > +                       }
> > +                       break;
> >                case THERMAL_TRIP_PASSIVE:
> >                        if (temp >= trip_temp || tz->passive)
> >                                thermal_zone_device_passive(tz, temp,
> > diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> > index 47b4a27..d7d0a27 100644
> > --- a/include/linux/thermal.h
> > +++ b/include/linux/thermal.h
> > @@ -42,6 +42,7 @@ enum thermal_trip_type {
> >        THERMAL_TRIP_PASSIVE,
> >        THERMAL_TRIP_HOT,
> >        THERMAL_TRIP_CRITICAL,
> > +       THERMAL_TRIP_STATE_ACTIVE,
> >  };
> >
> >  struct thermal_zone_device_ops {
> > --
> > 1.7.1
> >
> > _______________________________________________
> > linux-pm mailing list
> > linux-pm@lists.linux-foundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/linux-pm
>

--00248c768f6a83ef0c04b4932d73
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Vincent,<br><br>Thanks for the review.<br>Well actually your are correct=
 that current temperature and last temperature can be used to increase or d=
ecrease the cufreq. But this has to be done again in cooling devices so to =
make the cooling devices generic and to avoid the temperature comparision a=
gain this new trip type passes the cooling device instance id.<br>
Also about your queries that this may add dependency between trip index and=
 cooling state. This is actually needed and this dependency is created when=
 the cooling device is binded with trip points(For cpufreq type cooling dev=
ice just the instance of cooling device is associated with trip points). Mo=
re over the existing PASSIVE cooling trip type does the same thing and iter=
ates across all the cooling state.<br>
<br>Thanks,<br>Amit Daniel<br><br><div class=3D"gmail_quote">On 20 December=
 2011 18:07, Vincent Guittot <span dir=3D"ltr">&lt;<a href=3D"mailto:vincen=
t.guittot@linaro.org">vincent.guittot@linaro.org</a>&gt;</span> wrote:<br><=
blockquote class=3D"gmail_quote" style=3D"margin:0pt 0pt 0pt 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">
Hi Amit,<br>
<br>
I&#39;m not sure that using the trip index for setting the state of a<br>
cooling device is a generic solution because you are adding a<br>
dependency between the trip index and the cooling device state that<br>
might be difficult to handle. This dependency implies that a cooling<br>
device like cpufreq_cooling_device must be registered in the 1st trips<br>
of a thermal_zone which is not possible when we want to register 2<br>
cpufreq_cooling_devices in the same thermal_zone.<br>
You should only rely on the current and last temperatures to detect if<br>
a trip_temp has been crossed and you should increase or decrease the<br>
current state of the cooling device accordingly.<br>
<br>
something like below should work with cpufreq_cooling_device and will<br>
not add any constraint on the trip index. The state of a cooling<br>
device is increased/decreased once for each trip<br>
<div class=3D"im"><br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 case THERMAL_TRIP_STATE_ACTIVE:<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_for_each_entry(instance,=
 &amp;tz-&gt;cooling_devices,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 node) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (instance-=
&gt;trip !=3D count)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 continue;<br>
+<br>
</div><div class=3D"im">+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 cdev =3D instance-&gt;cdev;<br>
+<br>
</div><div class=3D"im">+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 if ((temp &gt;=3D trip_temp)<br>
</div>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 &amp;&amp; (trip_temp &gt; tz-&gt;last_temperature)) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 cdev-&gt;ops-&gt;get_max_state(cdev,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &amp;max_state);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 cdev-&gt;ops-&gt;get_cur_state(cdev,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &amp;current_state);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 if (++current_state &lt;=3D max_state)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 cdev-&gt;ops-&gt;set_cur_state(cdev,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 current_state);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
<div class=3D"im">+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 else if ((temp &lt; trip_temp)<br>
</div>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 &amp;&amp; (trip_temp &lt;=3D tz-&gt;last_temperature)) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 cdev-&gt;ops-&gt;get_cur_state(cdev,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &amp;current_state);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 if (current_state &gt; 0)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 cdev-&gt;ops-&gt;set_cur_state(cdev,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 --current_state);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
<br>
Regards,<br>
Vincent<br>
<div><div class=3D"h5"><br>
On 13 December 2011 16:13, Amit Daniel Kachhap &lt;<a href=3D"mailto:amit.k=
achhap@linaro.org">amit.kachhap@linaro.org</a>&gt; wrote:<br>
&gt; This patch adds a new trip type THERMAL_TRIP_STATE_ACTIVE. This<br>
&gt; trip behaves same as THERMAL_TRIP_ACTIVE but also passes the cooling<b=
r>
&gt; device instance number. This helps the cooling device registered as<br=
>
&gt; different instances to perform appropriate cooling action decision in<=
br>
&gt; the set_cur_state call back function.<br>
&gt;<br>
&gt; Also since the trip temperature&#39;s are in ascending order so some l=
ogic<br>
&gt; is put in place to skip the un-necessary checks.<br>
&gt;<br>
&gt; Signed-off-by: Amit Daniel Kachhap &lt;<a href=3D"mailto:amit.kachhap@=
linaro.org">amit.kachhap@linaro.org</a>&gt;<br>
&gt; ---<br>
&gt; =A0Documentation/thermal/sysfs-api.txt | =A0 =A04 ++--<br>
&gt; =A0drivers/thermal/thermal_sys.c =A0 =A0 =A0 | =A0 27 ++++++++++++++++=
++++++++++-<br>
&gt; =A0include/linux/thermal.h =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A01 +<br>
&gt; =A03 files changed, 29 insertions(+), 3 deletions(-)<br>
&gt;<br>
&gt; diff --git a/Documentation/thermal/sysfs-api.txt b/Documentation/therm=
al/sysfs-api.txt<br>
&gt; index b61e46f..5c1d44e 100644<br>
&gt; --- a/Documentation/thermal/sysfs-api.txt<br>
&gt; +++ b/Documentation/thermal/sysfs-api.txt<br>
&gt; @@ -184,8 +184,8 @@ trip_point_[0-*]_temp<br>
&gt;<br>
&gt; =A0trip_point_[0-*]_type<br>
&gt; =A0 =A0 =A0 =A0Strings which indicate the type of the trip point.<br>
&gt; - =A0 =A0 =A0 E.g. it can be one of critical, hot, passive, active[0-*=
] for ACPI<br>
&gt; - =A0 =A0 =A0 thermal zone.<br>
&gt; + =A0 =A0 =A0 E.g. it can be one of critical, hot, passive, active[0-1=
],<br>
&gt; + =A0 =A0 =A0 state-active[0-*] for ACPI thermal zone.<br>
&gt; =A0 =A0 =A0 =A0RO, Optional<br>
&gt;<br>
&gt; =A0cdev[0-*]<br>
&gt; diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_s=
ys.c<br>
&gt; index dd9a574..72b1ab3 100644<br>
&gt; --- a/drivers/thermal/thermal_sys.c<br>
&gt; +++ b/drivers/thermal/thermal_sys.c<br>
&gt; @@ -192,6 +192,8 @@ trip_point_type_show(struct device *dev, struct de=
vice_attribute *attr,<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return sprintf(buf, &quot;passive\n&quo=
t;);<br>
&gt; =A0 =A0 =A0 =A0case THERMAL_TRIP_ACTIVE:<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return sprintf(buf, &quot;active\n&quot=
;);<br>
&gt; + =A0 =A0 =A0 case THERMAL_TRIP_STATE_ACTIVE:<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return sprintf(buf, &quot;state-active\n=
&quot;);<br>
&gt; =A0 =A0 =A0 =A0default:<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return sprintf(buf, &quot;unknown\n&quo=
t;);<br>
&gt; =A0 =A0 =A0 =A0}<br>
&gt; @@ -1035,7 +1037,7 @@ EXPORT_SYMBOL(thermal_cooling_device_unregister)=
;<br>
&gt; =A0void thermal_zone_device_update(struct thermal_zone_device *tz)<br>
&gt; =A0{<br>
&gt; =A0 =A0 =A0 =A0int count, ret =3D 0;<br>
&gt; - =A0 =A0 =A0 long temp, trip_temp;<br>
&gt; + =A0 =A0 =A0 long temp, trip_temp, max_state, last_trip_change =3D 0;=
<br>
&gt; =A0 =A0 =A0 =A0enum thermal_trip_type trip_type;<br>
&gt; =A0 =A0 =A0 =A0struct thermal_cooling_device_instance *instance;<br>
&gt; =A0 =A0 =A0 =A0struct thermal_cooling_device *cdev;<br>
&gt; @@ -1086,6 +1088,29 @@ void thermal_zone_device_update(struct thermal_=
zone_device *tz)<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0cdev-&gt;ops-&gt;set_cur_state(cdev, 0);<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case THERMAL_TRIP_STATE_ACTIVE:<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_for_each_entry(inst=
ance, &amp;tz-&gt;cooling_devices,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 node) {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (inst=
ance-&gt;trip !=3D count)<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 continue;<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (temp=
 &lt;=3D last_trip_change)<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 continue;<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cdev =3D=
 instance-&gt;cdev;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cdev-&gt=
;ops-&gt;get_max_state(cdev, &amp;max_state);<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((tem=
p &gt;=3D trip_temp) &amp;&amp;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 ((count + 1) &lt;=3D max_state))<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 cdev-&gt;ops-&gt;set_cur_state(cdev,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 count + 1);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if =
((temp &lt; trip_temp) &amp;&amp;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (count &lt;=3D max_state))<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 cdev-&gt;ops-&gt;set_cur_state(cdev, count);<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 last_tri=
p_change =3D trip_temp;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case THERMAL_TRIP_PASSIVE:<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (temp &gt;=3D trip_t=
emp || tz-&gt;passive)<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0thermal=
_zone_device_passive(tz, temp,<br>
&gt; diff --git a/include/linux/thermal.h b/include/linux/thermal.h<br>
&gt; index 47b4a27..d7d0a27 100644<br>
&gt; --- a/include/linux/thermal.h<br>
&gt; +++ b/include/linux/thermal.h<br>
&gt; @@ -42,6 +42,7 @@ enum thermal_trip_type {<br>
&gt; =A0 =A0 =A0 =A0THERMAL_TRIP_PASSIVE,<br>
&gt; =A0 =A0 =A0 =A0THERMAL_TRIP_HOT,<br>
&gt; =A0 =A0 =A0 =A0THERMAL_TRIP_CRITICAL,<br>
&gt; + =A0 =A0 =A0 THERMAL_TRIP_STATE_ACTIVE,<br>
&gt; =A0};<br>
&gt;<br>
&gt; =A0struct thermal_zone_device_ops {<br>
&gt; --<br>
&gt; 1.7.1<br>
&gt;<br>
</div></div>&gt; _______________________________________________<br>
&gt; linux-pm mailing list<br>
&gt; <a href=3D"mailto:linux-pm@lists.linux-foundation.org">linux-pm@lists.=
linux-foundation.org</a><br>
&gt; <a href=3D"https://lists.linuxfoundation.org/mailman/listinfo/linux-pm=
" target=3D"_blank">https://lists.linuxfoundation.org/mailman/listinfo/linu=
x-pm</a><br>
</blockquote></div><br>

--00248c768f6a83ef0c04b4932d73--

--===============1015661466215579248==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1015661466215579248==--
