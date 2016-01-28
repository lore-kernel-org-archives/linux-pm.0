From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 2/9] device property: convert to use match_string()
 helper
Date: Thu, 28 Jan 2016 14:40:36 +0200
Message-ID: <1453984836.2521.295.camel@linux.intel.com>
References: <1452258558-119552-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <1452258558-119552-3-git-send-email-andriy.shevchenko@linux.intel.com>
	 <9839952.QQZMlEqdiM@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:25801 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934588AbcA1MkE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 28 Jan 2016 07:40:04 -0500
In-Reply-To: <9839952.QQZMlEqdiM@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Tejun Heo <tj@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, David Airlie <airlied@linux.ie>, Andrew Morton <akpm@linux-foundation.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>

On Sat, 2016-01-09 at 00:33 +0100, Rafael J. Wysocki wrote:
> On Friday, January 08, 2016 03:09:11 PM Andy Shevchenko wrote:
> > The new helper returns index of the mathing string in an array. We
> > would use it
> > here.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> in case you need that.

Thanks!

> 
> I think though that it might be more efficient to simply push [1/9]
> first
> maybe with one user and then send the other patches to the relevant
> maintainers
> when that has been applied.

I tried to do such with the first version, there was a comment besides
others that there is not enough '-' lines in the statistics ;-)


-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy

