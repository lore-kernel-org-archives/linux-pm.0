From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/8] lib/string: introduce match_string() helper
Date: Fri, 08 Jan 2016 10:40:51 +0200
Message-ID: <1452242451.30729.422.camel@linux.intel.com>
References: <1452168368-75630-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <874mepnizu.fsf@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:46726 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750794AbcAHIk2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 8 Jan 2016 03:40:28 -0500
In-Reply-To: <874mepnizu.fsf@rasmusvillemoes.dk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Tejun Heo <tj@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, David Airlie <airlied@linux.ie>, Andrew Morton <akpm@linux-foundation.org>

On Thu, 2016-01-07 at 23:05 +0100, Rasmus Villemoes wrote:
> On Thu, Jan 07 2016, Andy Shevchenko <andriy.shevchenko@linux.intel.c
> om> wrote:
>=20
> > From time to time we have to match a string in an array. Make a
> > simple helper
> > for that purpose.

> > =C2=A0/**
> > + * match_string - matches given string in an array
> > + * @array:	array of strings
> > + * @len:	number of strings in the array or 0 for NULL
> > terminated arrays
> > + * @string:	string to match with
> > + *
> > + * Return:
> > + * index of a @string in the @array if matches, or %-ENODATA
> > otherwise.
> > + */
> > +int match_string(const char * const *array, size_t len, const char
> > *string)
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
> > +EXPORT_SYMBOL(match_string);
> > +
>=20
> I'd suggest making it -1 (which, since len is a size_t, is
> effectively
> infinity) having the meaning "the array is terminated by a NULL
> entry". match_string(..., ARRAY_SIZE(my_array), ...) will break if
> the
> array happens to be empty, which could e.g. happen in a case like
>=20
> const char *my_array[] =3D {
> #ifdef CONFIG_THIS
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"this",
> #endif
> #ifdef CONFIG_THAT
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"that",
> #endif
> };

It might make sense, though I don't remember current users with such
conditions.


> I also think the condition/loop above is unreadable.

Hmm=E2=80=A6 For me looks straightforward.

>=20
> for (index =3D 0; index < len; index++) {
> =C2=A0=C2=A0=C2=A0=C2=A0...
> }
>=20
> is much clearer.

If we switch to -1, it will look indeed simpler.

>=20
> Why -ENODATA and not just -1? It is rather unlikely that anyone would
> pass on that particular -Exxx value. Not a biggie, just curious.

There are few of users already that would like to return error code to
upper level. In some cases better to have

return match_string();

than

ret =3D match_string();
if (ret < 0)
=C2=A0return -EFOO;

return 0;

And returning -ENODATA doesn't prevent to have latter, but allows
former.

>=20
> Would there be more potential users if we had a flag argument
> allowing
> case-insensitive matching? Would there be more potential users if a
> flag
> allowed to ask whether the given string is a _prefix_ of one of the
> strings in the array, or vice versa? Something like
>=20
> #define MATCH_STRING_CASE 0x01
> #define MATCH_STRING_PREFIX_OF_ARRAY_ELEM 0x02 /* yeah, that name
> sucks */
> #define MATCH_ARRAY_ELEM_PREFIX_OF_STRING 0x04 /* this too */
>=20
> int match_string(const char * const *array, size_t len, const char
> *string, unsigned flags)
> {
> #define MATCH_PREFIX (MATCH_... | MATCH_...)
> =C2=A0=C2=A0=C2=A0=C2=A0int index;
> =C2=A0=C2=A0=C2=A0=C2=A0const char *item;
> =C2=A0=C2=A0=C2=A0=C2=A0int (*match_func)(const char *, const char *)=
 =3D
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0flags & MATCH_STRING_=
CASE ? strcasecmp : strcmp;
> =C2=A0=C2=A0=C2=A0=C2=A0int (*prefix_func)(const char *, const char *=
, size_t) =3D
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0flags & MATCH_STRING_=
CASE ? strncasecmp : strncmp;
> =C2=A0=20
> =C2=A0=C2=A0=C2=A0=C2=A0for (index =3D 0; index < len; ++index) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0item =3D array[index]=
;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!item)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0break;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (flags & MATCH_PRE=
=46IX) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0size_t len =3D strlen(flags &
> MATCH_STRING_PREFIX_OF_ARRAY_ELEM ?
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0string : item);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0if (!prefix_func(item, string, len))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0return index;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0} else if (!match_fun=
c(item, string)) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0return index;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> =C2=A0=C2=A0=C2=A0=C2=A0}
> =C2=A0=C2=A0=C2=A0=C2=A0return -1;
> }
>=20
> (Ok, it's not that pretty; maybe it'd be better to use
> switch(flags&MATCH_PREFIX) {}. Or maybe just the case-insensitive
> part
> is worth keeping; in that case the above isn't that bad.)

I won't overcomplicate it until we have enough users to consider. Any
examples where we need this?

And I prefer way to have different prototypes for them instead of net
of conditions.

Thanks for review. I will send v3 (yeah, this is actually v2) with
change you proposed in the first part. For the second one I would like
to have real examples before doing anything.

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy

