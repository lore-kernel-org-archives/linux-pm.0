From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH v3 0/9] lib/string: introduce match_string() helper
Date: Fri, 8 Jan 2016 13:19:08 +0000
Message-ID: <20160108131908.GB17997@ZenIV.linux.org.uk>
References: <1452258558-119552-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:41340 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751940AbcAHNTQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 8 Jan 2016 08:19:16 -0500
Content-Disposition: inline
In-Reply-To: <1452258558-119552-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Tejun Heo <tj@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, David Airlie <airlied@linux.ie>, Andrew Morton <akpm@linux-foundation.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>

On Fri, Jan 08, 2016 at 03:09:09PM +0200, Andy Shevchenko wrote:
> There are users of a simple string matching in the array. Let's do a common
> helper for that.
 
What's the reason for making it return -ENODATA when no match is found?
That one of the callers wants to return that as error in such case?
At least one other is returning -EINVAL in the same situation...
