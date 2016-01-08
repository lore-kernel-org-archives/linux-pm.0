From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/8] lib/string: introduce match_string() helper
Date: Fri, 08 Jan 2016 10:43:16 +0200
Message-ID: <1452242596.30729.425.camel@linux.intel.com>
References: <1452168368-75630-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <20160108000915.GA2551@swordfish>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160108000915.GA2551@swordfish>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, David Airlie <airlied@linux.ie>, Andrew Morton <akpm@linux-foundation.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>
List-Id: linux-pm@vger.kernel.org

On Fri, 2016-01-08 at 09:13 +0900, Sergey Senozhatsky wrote:
> On (01/07/16 14:06), Andy Shevchenko wrote:
> >=20
> > From time to time we have to match a string in an array. Make a
> > simple helper
> > for that purpose.
> >=20
>=20
> Hello,
>=20
> strncmp() case seems to be quite common.

Like I answered to Rasmus, please, provide real examples.

>=20
> > +int match_string(const char * const *array, size_t len, const char
> > *string)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0^^^^^^^
> a nitpick, [to me] `len' looks a bit confusing, usually it's array
> 'size'.

Agreed. I would change it to plain 'n'.

>=20
> > +{
> > +	int index =3D 0;
> > +	const char *item;
> > +
> > +	do {
> > +		item =3D array[index];
> > +		if (!item)
> > +			break;
> > +		if (!strcmp(item, string))
> > +			return index;
> > +	} while (++index < len || !len);
> > +
> > +	return -ENODATA;
> > +}
>=20
>=20
> do you want to do something like this:
>=20
> /*
> =C2=A0* hm, how to name this thing... nmatch_string() or
> match_nstring()...
> =C2=A0* nmatch_string() _probably_ better, match_nstring() is totally
> cryptic.
> =C2=A0*/
> int nmatch_string(array, array_size, string, string_len)
> {
> 	do {
> 		strncmp();
> 	} while ();
> }
>=20
> int match_string(array, array_size, string)
> {
> 	return nmatch_string(array, array_size, string,
> strlen(string));
> }

See above.

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
