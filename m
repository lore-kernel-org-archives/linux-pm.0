From: Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH v9 1/4] gadget: Introduce the usb charger framework
Date: Thu, 07 Apr 2016 07:56:50 +0300
Message-ID: <87bn5m10fh.fsf@intel.com>
References: <cover.1459494743.git.baolin.wang@linaro.org> <6c594cc66fd06b575b04cc8bb0fe0374d0501d4d.1459494744.git.baolin.wang@linaro.org> <20160406072513.GB21101@shlinux2.ap.freescale.net> <87vb3v2nm8.fsf@intel.com> <20160406074310.GC21101@shlinux2.ap.freescale.net> <87shyz2md5.fsf@intel.com> <20160406081006.GD21101@shlinux2.ap.freescale.net> <87k2kb2fwd.fsf@intel.com> <20160407023925.GA10672@shlinux2.ap.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160407023925.GA10672@shlinux2.ap.freescale.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Chen <hzpeterchen@gmail.com>
Cc: Baolin Wang <baolin.wang@linaro.org>, gregkh@linuxfoundation.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, peter.chen@freescale.com, stern@rowland.harvard.edu, r.baldyga@samsung.com, yoshihiro.shimoda.uh@renesas.com, lee.jones@linaro.org, broonie@kernel.org, ckeepax@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, device-mainlining@lists.linuxfoundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Peter Chen <hzpeterchen@gmail.com> writes:
> On Wed, Apr 06, 2016 at 01:25:06PM +0300, Felipe Balbi wrote:
>>=20
>> Hi,
>>=20
>> Peter Chen <hzpeterchen@gmail.com> writes:
>> > On Wed, Apr 06, 2016 at 11:05:26AM +0300, Felipe Balbi wrote:
>> >> Peter Chen <hzpeterchen@gmail.com> writes:
>> >> > On Wed, Apr 06, 2016 at 10:38:23AM +0300, Felipe Balbi wrote:
>> >> >> Peter Chen <hzpeterchen@gmail.com> writes:
>> >> >> > On Fri, Apr 01, 2016 at 03:21:49PM +0800, Baolin Wang wrote:
>> >> >> >  +
>> >> >> >> +static struct attribute *usb_charger_attrs[] =3D {
>> >> >> >> +	&dev_attr_sdp_current.attr,
>> >> >> >> +	&dev_attr_dcp_current.attr,
>> >> >> >> +	&dev_attr_cdp_current.attr,
>> >> >> >> +	&dev_attr_aca_current.attr,
>> >> >> >> +	&dev_attr_charger_type.attr,
>> >> >> >> +	&dev_attr_charger_state.attr,
>> >> >> >> +	NULL
>> >> >> >> +};
>> >> >> >
>> >> >> > The user may only care about current limit, type and state, why =
they
>> >> >> > need to care what type's current limit, it is the usb charger
>> >> >> > framework handles, the framework judge the current according to
>> >> >> > charger type and USB state (connect/configured/suspended).
>> >> >>=20
>> >> >> it might be useful if we want to know that $this charger doesn't r=
eally
>> >> >> give us as much current as it advertises.
>> >> >>=20
>> >> >
>> >> > As my understanding, the current limit is dynamic value, it should
>> >> > report the value the charger supports now, eg, it connects SDP, but
>> >> > the host is suspended now, then the value should be 2mA.
>> >>=20
>> >> yes, and that's the limit. Now consider we connect to DCP or CDP and
>> >> limit is 2000mA but we're charging at 1000mA ;-)
>> >>=20
>> >
>> > Does the user need to know the $this charger limit? Don't they only
>> > care about the current charging value? I have a USB cable which can
>>=20
>> Why not ? UI might want to change the color of the battery charging icon
>> if we're charging @ 2000mA or @ 1000mA to give some visual feedback as
>> to "how fast" battery is supposed to be charged.
>>=20
>> > show charging current value, it changes from time to time, when it
>> > connects to host pc, it shows 430mA; when it connects to dedicated
>> > charger, it shows 1000mA.
>>=20
>> good for you, now what does that have to do with $subject ?
>>=20
>
> +static struct attribute *usb_charger_attrs[] =3D {
> +	&dev_attr_sdp_current.attr,
> +	&dev_attr_dcp_current.attr,
> +	&dev_attr_cdp_current.attr,
> +	&dev_attr_aca_current.attr,
> +	&dev_attr_charger_type.attr,
> +	&dev_attr_charger_state.attr,
> +	NULL
> +};
>
> Ok, even the users are interesting in current limit, we still have no
> necessary to know all kinds of chargers limit and current value, since
> we already have charger type user interface, the framework can show
> limit according to charger type.

Oh, now I get your comment and I totally agree. We already *know* the
detected charger type, there's no point in showing them all.

> I think below user interfaces are enough, who do you think?
>
> +static struct attribute *usb_charger_attrs[] =3D {
> +	&dev_attr_current.attr,
> +	&dev_attr_current_limit.attr,
> +	&dev_attr_charger_type.attr,
> +	&dev_attr_charger_state.attr,
> +	NULL
> +};

agreed, const though.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXBeiSAAoJEIaOsuA1yqREj4wQAJ7s7Oug+m81rKnb86KBQJhP
alL80VSMp5PXc7nVjiE+ugmcX0Q6AofaFh2PlOK+fljSNZO/IT796JXm+gSJUZ7v
+bbDcuKN9ujQuNI9N5z2tTx/3y8+kDYf/iyO6jRED+sZdmQMH9I9f8ZRXCp30gH6
QXyR22oS6fgJn2Hm05b3q6TSu1tTLss7cnYa6ldtOg+nJh6lKa5BZNRnzcImx/Mn
NcAKITAgFC4luF508DDNJkiPEnU2H4WjLGzUPuxqiCAonZ9/TyVSMgsbPHSnJrS4
qcpWoCAjYImojtYnuTANcaBsvljT7pw5xO/d2IK8YQw/TBIED3XVwzf7lozFD/MA
naoZpKgKCp2DI0/vt1fisH+QnpQO5qG8s4S4g0MAJE1ZzgxfAGkEJsxa9I0XnbNZ
ole2UtKqtbLhvio1J5cz5frVNbzD/UrYidGltMhVX/vIVh+DkcLsSzdMGAzCvehw
y5gtrlmhVY0G08FGcO/Ruf/EaiirzM7VVYY2y5FRr8sYUMyUesqyn+zbCh545G4H
VYD6ja7TN2pp401BAHQ/FzCJuvrTrQmrbBnNUgYRZdVFHPQTp+CnsDyZWFZGVomz
7Hz+q8u0FSZvJZ5hmz9WObnY/69Cav8f3HnBiSKx3UePRciT24IozI+MicrBNTrK
CTLhoVAwGSgkZu0hWN7e
=WK8K
-----END PGP SIGNATURE-----
--=-=-=--
