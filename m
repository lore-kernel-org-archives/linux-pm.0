From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v4 1/9] lib/string: introduce match_string() helper
Date: Tue, 02 Feb 2016 10:00:21 +0200
Message-ID: <1454400021.23271.4.camel@linux.intel.com>
References: <1453986865-133572-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <1453986865-133572-2-git-send-email-andriy.shevchenko@linux.intel.com>
	 <20160201220538.481cb8ee.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:4086 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753111AbcBBH7t (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 2 Feb 2016 02:59:49 -0500
In-Reply-To: <20160201220538.481cb8ee.akpm@linux-foundation.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Tejun Heo <tj@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, David Airlie <airlied@linux.ie>, Rasmus Villemoes <linux@rasmusvillemoes.dk>

On Mon, 2016-02-01 at 22:05 -0800, Andrew Morton wrote:
> On Thu, 28 Jan 2016 15:14:17 +0200 Andy Shevchenko <andriy.shevchenko
> @linux.intel.com> wrote:

> > + * @array:	array of strings
> > + * @n:		number of strings in the array or -1 for
> > NULL terminated arrays
> > + * @string:	string to match with
> > + *
> > + * Return:
> > + * index of a @string in the @array if matches, or %-ENODATA
> > otherwise.
> > + */
> > +int match_string(const char * const *array, size_t n, const char
> > *string)
> > +{
> > +	int index;
> > +	const char *item;
> > +
> > +	for (index =3D 0; index < n; index++) {
>=20
> So we're taking an int and comparing that with (size_t)-1, relying
> upon
> the compiler promoting the int to an unsigned type because size_t is
> unsigned.=C2=A0=C2=A0It works, but it isn't pretty - there wasn't rea=
lly much
> point in making size have type size_t.

It was Rasmus' idea [1], before that I used int and tristate branch. I
agreed that one of that branches wasn't a good idea, but the rest was
exactly about differentiating size to compare and infinite (till
terminator) loop.

[1]=C2=A0http://www.spinics.net/lists/kernel/msg2156925.html

>=20
>=20
> > +		item =3D array[index];
> > +		if (!item)
> > +			break;
> > +		if (!strcmp(item, string))
> > +			return index;
> > +	}
> > +
> > +	return -ENODATA;
> > +}
> > +EXPORT_SYMBOL(match_string);
>=20

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy

