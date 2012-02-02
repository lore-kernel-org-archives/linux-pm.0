From: Amit Kachhap <amit.kachhap@linaro.org>
Subject: Re: [RFC PATCH 1/2] thermal: Add a new trip type to use
 cooling device instance number
Date: Thu, 2 Feb 2012 12:44:14 +0530
Message-ID: <CAK44p23b0pw9k0w3r_eARh5E2g3KzZJgtMh9mKTfQBZsVYuKMg@mail.gmail.com>
References: <1323789196-4942-1-git-send-email-amit.kachhap@linaro.org>
	<1323789196-4942-2-git-send-email-amit.kachhap@linaro.org>
	<20120201144931.GC30184@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0483447856388600261=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20120201144931.GC30184@srcf.ucam.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg@redhat.com>
Cc: linaro-dev@lists.linaro.org, patches@linaro.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

--===============0483447856388600261==
Content-Type: multipart/alternative; boundary=0023544718949a35c904b7f5f124

--0023544718949a35c904b7f5f124
Content-Type: text/plain; charset=ISO-8859-1

On 1 February 2012 20:19, Matthew Garrett <mjg@redhat.com> wrote:

> I'm not really a fan of this as it stands - the name isn't very
> intuitive and the code's pretty difficult to read. Would the following
> (incomplete and obviously untested) not have the effect you want? Then
> you register multiple trip points with the same cooling device but
> different private values, and the state set does whatever you want it
> to. Or am I misunderstanding the problem you're trying to solve?
>

Thanks for the detailed review of the patch. Actually i tried to merge the
benefits of trip type ACTIVE and PASSIVE into one so this name. This new
trip type is just like ACTIVE but instead of OFF(0)/ON(1)  all values
greater then 0 is on. Anyways I looked at your implementation below but
this will not solve the purpose as   thermal_cooling_device_register() need
to be be called only once to register a cooling device such cpu frequency
based. However the same cooling device may be binded many times to
different trips.
Say,
1) thermal_zone_bind_cooling_device(tz_dev, 0, cdev);
2) thermal_zone_bind_cooling_device(tz_dev, 1, cdev);
3) thermal_zone_bind_cooling_device(tz_dev, 2, cdev);

0,1, 2 are nothing but trip points so the set_cur_state should be called
like
set_cur_state(cdev, 0)
set_cur_state(cdev, 1)
set_cur_state(cdev, 2) when the trip point threshold are crossed.

Yeah I agree that implementation logic looks complex but this to prevent
the lower temp trip points cooling handlers to be called. I will surely
make this better in next version.


> diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
> index 220ce7e..817f2ba 100644
> --- a/drivers/thermal/thermal_sys.c
> +++ b/drivers/thermal/thermal_sys.c
> @@ -50,6 +50,7 @@ struct thermal_cooling_device_instance {
>        char attr_name[THERMAL_NAME_LENGTH];
>        struct device_attribute attr;
>        struct list_head node;
> +       unsigned long private;
>  };
>
>  static DEFINE_IDR(thermal_tz_idr);
> @@ -909,7 +910,8 @@ static struct class thermal_class = {
>  * @ops:               standard thermal cooling devices callbacks.
>  */
>  struct thermal_cooling_device *thermal_cooling_device_register(
> -     char *type, void *devdata, const struct thermal_cooling_device_ops
> *ops)
> +       char *type, void *devdata, const struct thermal_cooling_device_ops
> *ops,
> +       unsigned long private)
>  {
>        struct thermal_cooling_device *cdev;
>        struct thermal_zone_device *pos;
> @@ -936,6 +938,7 @@ struct thermal_cooling_device
> *thermal_cooling_device_register(
>        cdev->ops = ops;
>        cdev->device.class = &thermal_class;
>        cdev->devdata = devdata;
> +       cdev->private = private;
>        dev_set_name(&cdev->device, "cooling_device%d", cdev->id);
>        result = device_register(&cdev->device);
>        if (result) {
> @@ -1079,11 +1082,14 @@ void thermal_zone_device_update(struct
> thermal_zone_device *tz)
>                                        continue;
>
>                                cdev = instance->cdev;
> -
> -                               if (temp >= trip_temp)
> -                                       cdev->ops->set_cur_state(cdev, 1);
> -                               else
> -                                       cdev->ops->set_cur_state(cdev, 0);
> +                               if (cdev->private) {
> +                                       cdev->ops->set_cur_state(cdev,
> cdev->private);
> +                               } else {
> +                                       if (temp >= trip_temp)
> +
> cdev->ops->set_cur_state(cdev, 1);
> +                                       else
> +
> cdev->ops->set_cur_state(cdev, 0);
> +                               }
>                        }
>                        break;
>                case THERMAL_TRIP_PASSIVE:
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 796f1ff..04aac09 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -148,7 +148,7 @@ int thermal_zone_unbind_cooling_device(struct
> thermal_zone_device *, int,
>                                       struct thermal_cooling_device *);
>  void thermal_zone_device_update(struct thermal_zone_device *);
>  struct thermal_cooling_device *thermal_cooling_device_register(char *,
> void *,
> -               const struct thermal_cooling_device_ops *);
> +                    const struct thermal_cooling_device_ops *, unsigned
> long private);
>  void thermal_cooling_device_unregister(struct thermal_cooling_device *);
>
>  #ifdef CONFIG_NET
>
>
> --
> Matthew Garrett | mjg59@srcf.ucam.org
>

--0023544718949a35c904b7f5f124
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On 1 February 2012 20:19, Matthew Garret=
t <span dir=3D"ltr">&lt;<a href=3D"mailto:mjg@redhat.com">mjg@redhat.com</a=
>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0p=
t 0pt 0pt 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
I&#39;m not really a fan of this as it stands - the name isn&#39;t very<br>
intuitive and the code&#39;s pretty difficult to read. Would the following<=
br>
(incomplete and obviously untested) not have the effect you want? Then<br>
you register multiple trip points with the same cooling device but<br>
different private values, and the state set does whatever you want it<br>
to. Or am I misunderstanding the problem you&#39;re trying to solve?<br></b=
lockquote><div><br>Thanks for the detailed review of the patch. Actually i =
tried to merge the benefits of trip type ACTIVE and PASSIVE into one so thi=
s name. This new trip type is just like ACTIVE but instead of OFF(0)/ON(1)=
=A0 all values greater then 0 is on. Anyways I looked at your implementatio=
n below but this will not solve the purpose as =A0 thermal_cooling_device_r=
egister() need to be be called only once to register a cooling device such =
cpu frequency based. However the same cooling device may be binded many tim=
es to different trips.<br>
Say,<br>1) thermal_zone_bind_cooling_device(tz_dev, 0, cdev);<br>2)  therma=
l_zone_bind_cooling_device(tz_dev, 1, cdev);<br>3) thermal_zone_bind_coolin=
g_device(tz_dev, 2, cdev);<br><br>0,1, 2 are nothing but trip points so the=
 set_cur_state should be called like <br>
set_cur_state(cdev, 0)<br>set_cur_state(cdev, 1)<br>set_cur_state(cdev, 2) =
when the trip point threshold are crossed.<br><br>Yeah I agree that impleme=
ntation logic looks complex but this to prevent the lower temp trip points =
cooling handlers to be called. I will surely make this better in next versi=
on. <br>
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0pt 0pt 0pt 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c<=
br>
index 220ce7e..817f2ba 100644<br>
--- a/drivers/thermal/thermal_sys.c<br>
+++ b/drivers/thermal/thermal_sys.c<br>
@@ -50,6 +50,7 @@ struct thermal_cooling_device_instance {<br>
 =A0 =A0 =A0 =A0char attr_name[THERMAL_NAME_LENGTH];<br>
 =A0 =A0 =A0 =A0struct device_attribute attr;<br>
 =A0 =A0 =A0 =A0struct list_head node;<br>
+ =A0 =A0 =A0 unsigned long private;<br>
=A0};<br>
<br>
=A0static DEFINE_IDR(thermal_tz_idr);<br>
@@ -909,7 +910,8 @@ static struct class thermal_class =3D {<br>
 =A0* @ops: =A0 =A0 =A0 =A0 =A0 =A0 =A0 standard thermal cooling devices ca=
llbacks.<br>
 =A0*/<br>
=A0struct thermal_cooling_device *thermal_cooling_device_register(<br>
- =A0 =A0 char *type, void *devdata, const struct thermal_cooling_device_op=
s *ops)<br>
+ =A0 =A0 =A0 char *type, void *devdata, const struct thermal_cooling_devic=
e_ops *ops,<br>
+ =A0 =A0 =A0 unsigned long private)<br>
=A0{<br>
 =A0 =A0 =A0 =A0struct thermal_cooling_device *cdev;<br>
 =A0 =A0 =A0 =A0struct thermal_zone_device *pos;<br>
@@ -936,6 +938,7 @@ struct thermal_cooling_device *thermal_cooling_device_r=
egister(<br>
 =A0 =A0 =A0 =A0cdev-&gt;ops =3D ops;<br>
 =A0 =A0 =A0 =A0cdev-&gt;device.class =3D &amp;thermal_class;<br>
 =A0 =A0 =A0 =A0cdev-&gt;devdata =3D devdata;<br>
+ =A0 =A0 =A0 cdev-&gt;private =3D private;<br>
 =A0 =A0 =A0 =A0dev_set_name(&amp;cdev-&gt;device, &quot;cooling_device%d&q=
uot;, cdev-&gt;id);<br>
 =A0 =A0 =A0 =A0result =3D device_register(&amp;cdev-&gt;device);<br>
 =A0 =A0 =A0 =A0if (result) {<br>
@@ -1079,11 +1082,14 @@ void thermal_zone_device_update(struct thermal_zone=
_device *tz)<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0continue;<br>
<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cdev =3D in=
stance-&gt;cdev;<br>
-<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (temp &gt;=
=3D trip_temp)<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 cdev-&gt;ops-&gt;set_cur_state(cdev, 1);<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 cdev-&gt;ops-&gt;set_cur_state(cdev, 0);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cdev-&gt;=
private) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 cdev-&gt;ops-&gt;set_cur_state(cdev, cdev-&gt;private);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 if (temp &gt;=3D trip_temp)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 cdev-&gt;ops-&gt;set_cur_state(cdev, 1);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 else<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 cdev-&gt;ops-&gt;set_cur_state(cdev, 0);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case THERMAL_TRIP_PASSIVE:<br>
diff --git a/include/linux/thermal.h b/include/linux/thermal.h<br>
index 796f1ff..04aac09 100644<br>
--- a/include/linux/thermal.h<br>
+++ b/include/linux/thermal.h<br>
@@ -148,7 +148,7 @@ int thermal_zone_unbind_cooling_device(struct thermal_z=
one_device *, int,<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 struct thermal_cooling_device *);<br>
=A0void thermal_zone_device_update(struct thermal_zone_device *);<br>
=A0struct thermal_cooling_device *thermal_cooling_device_register(char *, v=
oid *,<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 const struct thermal_cooling_device_ops *);<b=
r>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const struct thermal_cooling_devic=
e_ops *, unsigned long private);<br>
=A0void thermal_cooling_device_unregister(struct thermal_cooling_device *);=
<br>
<br>
=A0#ifdef CONFIG_NET<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
<br>
--<br>
Matthew Garrett | <a href=3D"mailto:mjg59@srcf.ucam.org">mjg59@srcf.ucam.or=
g</a><br>
</font></span></blockquote></div><br>

--0023544718949a35c904b7f5f124--

--===============0483447856388600261==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0483447856388600261==--
