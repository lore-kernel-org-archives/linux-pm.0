From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] PM / OPP: fix debugfs files for 64-bit
Date: Wed, 7 Oct 2015 16:29:11 +0530
Message-ID: <20151007105911.GC9892@linux>
References: <5706174.BUsqiXljxZ@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:34164 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751049AbbJGK7R (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 7 Oct 2015 06:59:17 -0400
Received: by padhy16 with SMTP id hy16so18555669pad.1
        for <linux-pm@vger.kernel.org>; Wed, 07 Oct 2015 03:59:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5706174.BUsqiXljxZ@wuerfel>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Stephen Boyd <sboyd@codeaurora.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Nishanth Menon <nm@ti.com>, Dmitry Torokhov <dtor@chromium.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Arnd,

On 07-10-15, 09:35, Arnd Bergmann wrote:
> The recently added debugfs support for OPP creates files using the
> debugfs_create_bool() and debugfs_create_u32() interfaces, but
> casts the data argument to u32*, which is broken on some architectures.
> 
> In case of debugfs_create_bool(), the API has changed as of 621a5f7ad9cd
> ("debugfs: Pass bool pointer to debugfs_create_bool()"), so we now get
> a warning about the new interface in linux-next, which contains both
> patches. Removing the cast makes it work in linux-next, and makes it
> warn in cases where it does not work.
> 
> For debugfs_create_u32(), the current usage is broken on 64-bit
> architectures when the values exceed the range of 32-bit variables
> (which should not happen), or when the kernel is built for as
> big-endian. This patch removes the casts and changes the types
> to u32 to make them match and print the correct value on all
> architectures.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 5cb5fdbf38770 ("PM / OPP: Add debugfs support")
> ---
> Found while building ARM allmodconfig

Thanks. I just got back from vacations and this was the first thing I
was going to look at. :)

So, there are two problems here and I feel they should be fixed
separately.

The bool thing is simple to fix, just remove the cast as you did.
Though it will keep warning if we use pm/linux-next branch directly,
but will work well with linux-next.

The second problem isn't that trivial. Just making unsigned longs as
u32 doesn't look like the right solution to me (at least). They are
unsigned long, to match the expected types with other frameworks like
clock and regulator.

What about adding something like debugfs_create_unsigned_long() for
such cases?

@Greg ??

-- 
viresh
