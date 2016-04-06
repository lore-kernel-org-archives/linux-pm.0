From: Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH v9 1/4] gadget: Introduce the usb charger framework
Date: Wed, 06 Apr 2016 13:25:35 +0300
Message-ID: <87h9ff2fvk.fsf@intel.com>
References: <cover.1459494743.git.baolin.wang@linaro.org> <6c594cc66fd06b575b04cc8bb0fe0374d0501d4d.1459494744.git.baolin.wang@linaro.org> <20160406072513.GB21101@shlinux2.ap.freescale.net> <87vb3v2nm8.fsf@intel.com> <20160406074310.GC21101@shlinux2.ap.freescale.net> <87shyz2md5.fsf@intel.com> <20160406081124.GE21101@shlinux2.ap.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160406081124.GE21101@shlinux2.ap.freescale.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Chen <hzpeterchen@gmail.com>
Cc: Baolin Wang <baolin.wang@linaro.org>, gregkh@linuxfoundation.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, peter.chen@freescale.com, stern@rowland.harvard.edu, r.baldyga@samsung.com, yoshihiro.shimoda.uh@renesas.com, lee.jones@linaro.org, broonie@kernel.org, ckeepax@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, device-mainlining@lists.linuxfoundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Peter Chen <hzpeterchen@gmail.com> writes:
> On Wed, Apr 06, 2016 at 11:05:26AM +0300, Felipe Balbi wrote:
>> Peter Chen <hzpeterchen@gmail.com> writes:
>> > On Wed, Apr 06, 2016 at 10:38:23AM +0300, Felipe Balbi wrote:
>> >> Peter Chen <hzpeterchen@gmail.com> writes:
>> >> > On Fri, Apr 01, 2016 at 03:21:49PM +0800, Baolin Wang wrote:
>> >> >  +
>> >> >> +static struct attribute *usb_charger_attrs[] =3D {
>> >> >> +	&dev_attr_sdp_current.attr,
>> >> >> +	&dev_attr_dcp_current.attr,
>> >> >> +	&dev_attr_cdp_current.attr,
>> >> >> +	&dev_attr_aca_current.attr,
>> >> >> +	&dev_attr_charger_type.attr,
>> >> >> +	&dev_attr_charger_state.attr,
>> >> >> +	NULL
>> >> >> +};
>> >> >
>> >> > The user may only care about current limit, type and state, why they
>> >> > need to care what type's current limit, it is the usb charger
>> >> > framework handles, the framework judge the current according to
>> >> > charger type and USB state (connect/configured/suspended).
>> >>=20
>> >> it might be useful if we want to know that $this charger doesn't real=
ly
>> >> give us as much current as it advertises.
>> >>=20
>> >
>> > As my understanding, the current limit is dynamic value, it should
>> > report the value the charger supports now, eg, it connects SDP, but
>> > the host is suspended now, then the value should be 2mA.
>>=20
>> yes, and that's the limit. Now consider we connect to DCP or CDP and
>> limit is 2000mA but we're charging at 1000mA ;-)
>>=20
>
> The user doesn't need to know the value which spec designs.

because... ?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXBOQgAAoJEIaOsuA1yqREUs0P/1q1/pxA2Y+sTFCucbhhCFg5
idIQXSle9osENE8yNXA8L517NkHPpyQRQ8bSHzOKc9g5leRyo+Ld80zJevBStG07
ii37yCus65O1Wz+Y9o57JFB4JJKNXWYrvyv3il7JE67XnSMJ0iOX8ueg7Yt5AN4p
E4LwkJaqy8J9a/JytaY/PWN8oyLnUUQ8k/XNbav0raZsdsxqjlzXcRBnbNs4LMI0
WG7ybza4R4VDjsZZV207lijzuiEIFngXEbHWj8WdlkK31f3NZkHgBGrudt4lyOix
e0hXscp23hoayuD8R+80BjGgS7H2y0IVVGu4oXDEKDfhBQosNCL6I0qgiVy4lbKe
nMGVFX4eVMtNXl1HoPoQomr4VAfabsEn9i7bFs0ihmWZYRvz3JKKhpsZZNJZYuDO
iSRzs5owPal6JkRh/gmUBEuk3por1X8Dkv+lqLM8tI+jA+c0Y6z8CmEskiZsdscQ
vCbgHj40qlXnbXL3fOeD0W8CUwS23mp1/q6b/pGhGk9349n0kfcLr2eNnjzQXlOG
AfyQuWEKuz6lsu5MRjsDZTZP1wonPy+GDZZk0aZO7ZPZvS01OmmP/SyvOag+hlCE
TbTuU/ACw7DyjZdk1prmuyCk8RJQLMBxY8QUsvKWRoJOZZfzOMRx4anEhWWgIXfv
PwM9QWfHvcbXbSfnxAd7
=e3I0
-----END PGP SIGNATURE-----
--=-=-=--
