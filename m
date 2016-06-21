From: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v12 2/4] gadget: Support for the usb charger framework
Date: Tue, 21 Jun 2016 15:36:54 +0300
Message-ID: <87d1nan2ft.fsf@linux.intel.com>
References: <cover.1466497505.git.baolin.wang@linaro.org> <f7bae2566824a5e1da14c1a19dee6af5f250262f.1466497506.git.baolin.wang@linaro.org> <87bn2uomzd.fsf@linux.intel.com> <CAMz4ku+t66t+E3dCysfE9yNkKRCYwv7mXpJs4ShGbZWSZO_B9g@mail.gmail.com> <87twgmn4m7.fsf@linux.intel.com> <CAMz4kuKtof=wret_JJVaxe3uXjtaSeCFWn8V6y2wzTjjmrQVLQ@mail.gmail.com> <87inx2n2vs.fsf@linux.intel.com> <CAMz4kuKnzjPOqEr9kJY6SCnq2rszsc55X5=7mWb+ZcbL6G_8DQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMz4kuKnzjPOqEr9kJY6SCnq2rszsc55X5=7mWb+ZcbL6G_8DQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Jun Li <jun.li-3arQi8VN3Tc@public.gmane.org>, Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Ruslan Bilovol <ruslan.bilovol-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Peter Chen <peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, USB <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, device-mainlining-cunTk1MwBs98uUxBSJOaYoYkZiVZrdSR2LY78lusg7I@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> writes:
>> Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> writes:
>>>> Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> writes:
>>>>>> Can't you just tie a charger to a UDC and avoid the charger class
>>>>>> completely?
>>>>>
>>>>> Yeah, I also hope so. But we really want something to manage the
>>>>> charger devices, do you have any good suggestion to avoid the 'class'
>>>>> but also can manage the charger devices?
>>>>
>>>> manage in what way? It seems to me that they don't need to be real
>>>> devices, just a handle as part of struct usb_gadget, no?
>>>
>>> Although charger device is not one real hardware device, we also use
>>> one 'struct device' to describe it in charger.c file. So we should
>>> manage the 'struct device' with one proper way.
>>
>> that's fine, but why do you think they need a struct device to start wit=
h?
>
> We can get/put usb charger and mange usb charger attributes with the
> device model if we use a struct device.

We already have that as part of struct usb_udc. Why don't you just
create a subdirectory called charger which will hold all your
charger-related attributes. That directory will only be created if a
valid ->charger pointer exists.

USB Charging is always tied to a peripheral side controller, anyway.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXaTTmAAoJEIaOsuA1yqRE2goP/19Jcq8xiFQauQxQ2rygQOPu
rc9Rcu0XG9b9XDkj7AB/0DIBK7m3la/ZxH3SsZALFGAFcAulK2Xs009ThPeo4CmF
Wxa6iuUx0fYGNF/S6T+3OflFa0HCEEZO02CRmlzcBbV71vXwoeNCgMR4DrxnYasd
+DFpxV3neZc+mdFNs489C9e1fCLKJdzc8ruty+UA3lcrELK3TIC3orXmYM2YvIUb
zZUxeUOUomeRj7399fE8LHDwkwYvX1eYSQTiaXWh7oPZ5MHxg8ewXSTxNoYhvhqn
C8DJiRqDbxsGS7de+c0YsHy3tnA35QmkBuO7p6ZQzVoSWyRXx1MRlXpHI67BuFNo
jqVGpatW4nr9UQxRtqTnLutTX0hSmHnARTQFXA9v/qtLk+rLUdi1178uA/gY+H5R
xgV8SzOMEuBDarsqjSCGCp2RKjsx9GQe/cGlM1lRlFjB8Drmvhx9/cJlTsBwHFTt
ShrZZz4s8W1PTM6rEfkCRB0RE8tbKYDWXx157aFYdrHUzVkyl611rCOmNd5kFA2R
ce6vrS3zB6riGYNze/tpitHbYF4d47p55nmwZ2p/2RiV8//BkLt2nJ1B7MopgWww
P2pZQ8s0iVj6qkxebWFT3WMZkWzeTEezfHDYC5QAJWV8Xsj6nwLwl748I5KzegOx
YmcicTon6GNBCR7bVmv8
=deYk
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
