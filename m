From: Nishanth Menon <nm@ti.com>
Subject: Re: [linux-next PATCH 6/7] PM / devfreq: allow sysfs governor node
 to switch governor
Date: Tue, 6 Nov 2012 15:28:25 -0600
Message-ID: <20121106212825.GA21925@kahuna>
References: <31153640.425391352192535931.JavaMail.weblogic@epml11>
 <CAJ0PZbSe7Orhww-amHNRkbvUvJr6x9CtisHw2hoLpcJdyBSKCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36521 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751412Ab2KFV2f (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 6 Nov 2012 16:28:35 -0500
Content-Disposition: inline
In-Reply-To: <CAJ0PZbSe7Orhww-amHNRkbvUvJr6x9CtisHw2hoLpcJdyBSKCA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: MyungJoo Ham <myungjoo.ham@gmail.com>
Cc: myungjoo.ham@samsung.com, LKML <linux-kernel@vger.kernel.org>, Kevin Hilman <khilman@ti.com>, linux-pm <linux-pm@vger.kernel.org>, Rajagopal Venkat <rajagopal.venkat@linaro.org>, =?utf-8?B?67CV6rK966+8?= <kyungmin.park@samsung.com>, "Rafael J. Wysocki" <rjw@sisk.pl>

On 18:18-20121106, MyungJoo Ham wrote:
> 2012. 11. 6. =EC=98=A4=ED=9B=84 6:02=EC=97=90 "MyungJoo Ham" <myungjo=
o.ham@samsung.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> >
> > > --- a/drivers/devfreq/devfreq.c
> > > +++ b/drivers/devfreq/devfreq.c
> > > @@ -629,6 +629,44 @@ static ssize_t show_governor(struct device *=
dev,
> > >       return sprintf(buf, "%s\n", to_devfreq(dev)->governor->name=
);
> > >  }
> > >
> > > +static ssize_t store_governor(struct device *dev, struct
> device_attribute *attr,
> > > +                           const char *buf, size_t count)
> > > +{
> > > +     struct devfreq *df =3D to_devfreq(dev);
> > > +     int ret =3D 0;
> > > +     struct devfreq_governor *governor;
> > > +
> > > +     mutex_lock(&devfreq_list_lock);
> >
> > Please remove the trailing \n from buf here.
> > When user enters "userspace", buf gets "userspace\n".
> >
> > With some printks in find_devfreq_governor (printing the buf and go=
vernor
> names):
> >
> > # echo userspace > /sys/class/devfreq/exynos4210-busfreq.0/governor
> > [   65.975000] [userspace
> > [   65.975000] ].[userspace]
> > [   65.980000] [userspace
> > [   65.980000] ].[powersave]
> > [   65.985000] [userspace
> > [   65.985000] ].[performance]
> > [   65.990000] [userspace
> > [   65.990000] ].[simple_ondemand]
> > [   65.995000] err no =3D -19
> > #
> >
>=20
> Anyway this seems quite wierd. I will look more into this one in my t=
arget
> system.
Thanks for catching this.
:( I missed the \n (been using echo -n toooo often now grr..)
What do you think of the following change to the patch?

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 586b6fd..9a4e898 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -614,11 +614,16 @@ static ssize_t store_governor(struct device *dev,=
 struct device_attribute *attr,
 			      const char *buf, size_t count)
 {
 	struct devfreq *df =3D to_devfreq(dev);
-	int ret =3D 0;
+	int ret;
+	char str_governor[DEVFREQ_NAME_LEN + 1];
 	struct devfreq_governor *governor;
=20
+	ret =3D sscanf(buf, "%" __stringify(DEVFREQ_NAME_LEN) "s", str_govern=
or);
+	if (ret !=3D 1)
+	        return -EINVAL;
+
 	mutex_lock(&devfreq_list_lock);
-	governor =3D find_devfreq_governor(buf);
+	governor =3D find_devfreq_governor(str_governor);
 	if (IS_ERR(governor)) {
 		ret =3D PTR_ERR(governor);
 		goto out;
--=20
Regards,
Nishanth Menon

output:
/sys/devices/platform/iva.0/devfreq/iva.0 # cat governor=20
simple_ondemand
/sys/devices/platform/iva.0/devfreq/iva.0 # echo -n "userspace">governo=
r=20
/sys/devices/platform/iva.0/devfreq/iva.0 # echo -n "simple_ondeman">go=
vernor=20
sh: write error: No such device
/sys/devices/platform/iva.0/devfreq/iva.0 # cat governor=20
userspace
/sys/devices/platform/iva.0/devfreq/iva.0 # echo -n "simple_ondemand">g=
overnor=20
/sys/devices/platform/iva.0/devfreq/iva.0 # cat governor=20
simple_ondemand
/sys/devices/platform/iva.0/devfreq/iva.0 # echo "userspace">governor=20
/sys/devices/platform/iva.0/devfreq/iva.0 # cat governor=20
userspace
/sys/devices/platform/iva.0/devfreq/iva.0 # echo  "simple_ondemand">gov=
ernor=20
/sys/devices/platform/iva.0/devfreq/iva.0 # echo "userspace123123213123=
213123212
3123123131231">governor=20
sh: write error: No such device
/sys/devices/platform/iva.0/devfreq/iva.0 # cat governor=20
simple_ondemand

