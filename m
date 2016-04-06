From: Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH v9 1/4] gadget: Introduce the usb charger framework
Date: Wed, 06 Apr 2016 10:38:23 +0300
Message-ID: <87vb3v2nm8.fsf@intel.com>
References: <cover.1459494743.git.baolin.wang@linaro.org> <6c594cc66fd06b575b04cc8bb0fe0374d0501d4d.1459494744.git.baolin.wang@linaro.org> <20160406072513.GB21101@shlinux2.ap.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:23819 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751601AbcDFHkb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 6 Apr 2016 03:40:31 -0400
In-Reply-To: <20160406072513.GB21101@shlinux2.ap.freescale.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Chen <hzpeterchen@gmail.com>, Baolin Wang <baolin.wang@linaro.org>
Cc: gregkh@linuxfoundation.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, peter.chen@freescale.com, stern@rowland.harvard.edu, r.baldyga@samsung.com, yoshihiro.shimoda.uh@renesas.com, lee.jones@linaro.org, broonie@kernel.org, ckeepax@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, device-mainlining@lists.linuxfoundation.org, linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Peter Chen <hzpeterchen@gmail.com> writes:
> On Fri, Apr 01, 2016 at 03:21:49PM +0800, Baolin Wang wrote:
>  +
>> +static struct attribute *usb_charger_attrs[] =3D {
>> +	&dev_attr_sdp_current.attr,
>> +	&dev_attr_dcp_current.attr,
>> +	&dev_attr_cdp_current.attr,
>> +	&dev_attr_aca_current.attr,
>> +	&dev_attr_charger_type.attr,
>> +	&dev_attr_charger_state.attr,
>> +	NULL
>> +};
>
> The user may only care about current limit, type and state, why they
> need to care what type's current limit, it is the usb charger
> framework handles, the framework judge the current according to
> charger type and USB state (connect/configured/suspended).

it might be useful if we want to know that $this charger doesn't really
give us as much current as it advertises.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXBLzwAAoJEIaOsuA1yqRE8TAP/jKPFimNCFxj8FPUADsmhyOK
9iB39wSvkiFY/KcNfBzlY5BXuaxeCSOHUlj9wUfuCNwFRPZSIbGpwoTgeuiPtIBS
baQxj63AGltVWC7QXc4arZqR2KqKxuRE+73RBjaTbUmexa7HNUUSc2BEQ3K9HTUR
htukrOaE1DgFPNnAAfjpZcH5Hf6yRqFcn9ZeCs/Kj3RYYcbGiMB5nrHFrqYLTE5M
gtpC4yEY8In2Xq5rbw+Htq4+NfokJ7NF3qAb3g7gJGVVB0kvtyDwPQabUNfdBu5n
AuIFnpKmOZ5bYc41XKJx8Ge7t/PIied5Tk/yi2Md90j3kI0kV2rI/EbINsoB+vgW
4XhYL5RU0rKWTbQAr1O0Qf1LsWFK0B7dMW7G7JVjGTEoDLPBionIWrGQIe4Pqk0h
iD1ycD3X0Botuuqdt4mzNq2tX+vkmk7j2W5CbMmi2kGEISZgZfLJFp1Q6+fOdxj3
EVaeDwxe72wrC33/XNwqJsn0unm2WdqihRlegQOtoewixO17HU2XMTkz9+NNCI00
E2qPi0MNKLTtikwxA3FQL65k1Bqxg93N5XMnlefY5OGwdM6iimiLFHdfb1h5EA+1
XrYeWO90gPo/3q1KScgNKZ7mzqpfDec9Z7UEnrW4NM6n3JbtOuZ80+FmmKOlBl9K
IYgSfdCIZN7NkWajLx+R
=ticS
-----END PGP SIGNATURE-----
--=-=-=--
