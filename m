From: Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH v9 1/4] gadget: Introduce the usb charger framework
Date: Wed, 06 Apr 2016 13:25:06 +0300
Message-ID: <87k2kb2fwd.fsf@intel.com>
References: <cover.1459494743.git.baolin.wang@linaro.org> <6c594cc66fd06b575b04cc8bb0fe0374d0501d4d.1459494744.git.baolin.wang@linaro.org> <20160406072513.GB21101@shlinux2.ap.freescale.net> <87vb3v2nm8.fsf@intel.com> <20160406074310.GC21101@shlinux2.ap.freescale.net> <87shyz2md5.fsf@intel.com> <20160406081006.GD21101@shlinux2.ap.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160406081006.GD21101@shlinux2.ap.freescale.net>
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
> Does the user need to know the $this charger limit? Don't they only
> care about the current charging value? I have a USB cable which can

Why not ? UI might want to change the color of the battery charging icon
if we're charging @ 2000mA or @ 1000mA to give some visual feedback as
to "how fast" battery is supposed to be charged.

> show charging current value, it changes from time to time, when it
> connects to host pc, it shows 430mA; when it connects to dedicated
> charger, it shows 1000mA.

good for you, now what does that have to do with $subject ?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXBOQDAAoJEIaOsuA1yqREVj4P/j7dJPMSfQzinWl12/zTjPi6
wTWMK/IXG97jd+QNSJdr+A7ZpaVjrrxbnA/w9K/Hm3Dsjs/6D7x8jj+7O9V5Dxji
NrQroVwqiTBYrHVDUngtNGXRfBOLhv2UIvPPzJ18EURzHn9YRo08R/S3FchPRFoY
1Z0pwmC0HA+npBk9BFgGHGE90tgs7yhCfDhY0v0SxAX5wxMhrTieGD6mGGgEwIHK
55Sw2VEA4MazrDr9WHHaEvDfxa/Ro7H5JGopVVlkEHfq0UZALysTauqmI4Sei8ls
kxzM0br0dZ5O2HHOxdn+RXsPNlmF37vcqNF+WmpAlAq+n0mgRmYh79YbBy+bidj1
YZ5SVjXmmVBARUnparJdRFDJvRuABxoc7dM4Hn+zcMy62XHjfCjoW2FuGNWo22vZ
LwD2wmxTH/wWEB2DVbMQc/qqUxqD8z4DnPR998cAs/guwig51nnKcd50ACFMvgNy
1nEb5bfUovd2UzqHkDVIi7Z9OFgm/+ucCXob1oCVIwwspHfd8JXjLiWL92/7+FfK
vzL4126olI8h/99u2y76pDNUW1IoaMlHjVV/UBUWLt4DoXIoaoDscJRWbGKnajzp
UtTwqTAHt11ca2I0BBmOjtnaz28Eqtr+PpxG9ZWj15Un+cE/6FZ5wW0tElC2F5fy
GEVwKzwut7B7jToBpuvw
=zE9s
-----END PGP SIGNATURE-----
--=-=-=--
