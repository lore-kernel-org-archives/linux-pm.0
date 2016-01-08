From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 0/9] lib/string: introduce match_string() helper
Date: Fri, 08 Jan 2016 16:13:18 +0200
Message-ID: <1452262398.1342.4.camel@linux.intel.com>
References: <1452258558-119552-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <20160108131908.GB17997@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160108131908.GB17997@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Tejun Heo <tj@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, David Airlie <airlied@linux.ie>, Andrew Morton <akpm@linux-foundation.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>
List-Id: linux-pm@vger.kernel.org

On Fri, 2016-01-08 at 13:19 +0000, Al Viro wrote:
> On Fri, Jan 08, 2016 at 03:09:09PM +0200, Andy Shevchenko wrote:
> > There are users of a simple string matching in the array. Let's do
> > a common
> > helper for that.
> =C2=A0
> What's the reason for making it return -ENODATA when no match is
> found?

What else can be suitable?

> That one of the callers wants to return that as error in such case?
> At least one other is returning -EINVAL in the same situation...

Linus Acked this, maybe he missed that one.

Linus, do we still need to return -EINVAL in pinmux?

In general our error reporting sucks, you know. So, any return value
will be not ideal and self-explanatory (see json approach in perf). But
I prefer return some return code instead of opaque -1, for example.
This at least helps some users.

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
