From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH v1 1/8] lib/string: introduce match_string() helper
Date: Tue, 12 Jan 2016 17:26:49 +0900
Message-ID: <20160112082649.GA1821@swordfish>
References: <1452242596.30729.425.camel@linux.intel.com>
 <20160109011241.GB560@swordfish>
 <CAHp75Vf_dESyzvi5EN5KP8OCKtqKoD8YK7w5s0yHpBgt=-q7Uw@mail.gmail.com>
 <1452524400.26146.32.camel@linux.intel.com>
 <8760yzbwd5.fsf@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35525 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760402AbcALIZj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 Jan 2016 03:25:39 -0500
Content-Disposition: inline
In-Reply-To: <8760yzbwd5.fsf@rasmusvillemoes.dk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Tejun Heo <tj@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, David Airlie <airlied@linux.ie>, Andrew Morton <akpm@linux-foundation.org>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>

Hello,

On (01/11/16 23:10), Rasmus Villemoes wrote:
[..]
> > Thought more about those cases.
> >
> > If you would like you may introduce something like
> >
> > int nmatch_string(array, array_size, string, int len)
> > {
> >   if (len < 0)
> >     return match_string();
> >
> >   for (...) {
> >     size_t itemlen = (len > 0) ? len : strlen(array[index]);
> > ...
> >     if (!strncmp(array[index], string, itemlen))
> >       return index;
> >   }
> >   return -EINVAL;
> > }

may be later this week; I'm a bit out of spare time at the moment.


> Yeah, a separate function is probably better. But why not a more
> explicit name, match_prefix, match_string_prefix, match_string_starts?

Not married to nmatch_string(), but at the same time, IMHO, *_prefix or
*_starts naming is not really better. One can pass a string with offset,
e.g.
  FOO_starts(array, array_size, string + offset, strlen(string) - offset)
which will be equivalent to FOO_ends(), but not FOO_starts() or FOO_prefix().
Personally, I'd prefer to preserve strcmp/strncmp semantics, thus, forbidding
`len < 0' case, which looks cryptic to me.


> I like the idea of passing the string length if one wants the "is this a
> prefix of some array element" semantics, and a sentinel otherwise. But I
> don't see any case where one would want match_string() semantics (why
> not call match_string directly instead?),


> so why not let len < 0 mean "is some array element a prefix of this string"
> and "len >= 0" be the other case. I don't see why one shouldn't be able to
> ask "is the empty string a prefix of some array element" (that is, are there
> any elements in the array);

if this is a dynamic array, then there should be some function that
fills in that array, so having a simple bool flag in the code will
suffice; if this is a static array, then ARRAY_SIZE() should do the
trick. I would never expect a string matching function to have this
type of functionality, TBH.

But the question is

> is the empty string a prefix of some array element

do people really need this?

the way I see it, the idea is to have wrappers around
	while (array[..]) if strcmp()/strncmp() == 0 break ...

both of which [strcmp()/strncmp()] have a well known and expected
semantics, changing this can only confuse people.

	-ss

> both the array and the string might be run-time things,
> so this could occur. And it's not up to a generic library routine like
> this to impose restrictions like "the empty string makes no sense, go
> away".
> 
> Rasmus
> 
