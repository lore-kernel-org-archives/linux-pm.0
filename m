From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] PM / OPP: fix debugfs files for 64-bit
Date: Wed, 7 Oct 2015 12:07:55 +0100
Message-ID: <20151007110755.GA6601@kroah.com>
References: <5706174.BUsqiXljxZ@wuerfel>
 <20151007105911.GC9892@linux>
 <20151007110302.GD9892@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:38706 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751026AbbJGLIA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 7 Oct 2015 07:08:00 -0400
Content-Disposition: inline
In-Reply-To: <20151007110302.GD9892@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Stephen Boyd <sboyd@codeaurora.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Nishanth Menon <nm@ti.com>, Dmitry Torokhov <dtor@chromium.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, Oct 07, 2015 at 04:33:02PM +0530, Viresh Kumar wrote:
> On 07-10-15, 16:29, Viresh Kumar wrote:
> > What about adding something like debugfs_create_unsigned_long() for
> > such cases?
> 
> And that can be as simple (or ugly, not sure if its buggy) as:
> 
> debugfs_create_unsigned_long()
> {
>         if (sizeof(unsigned long) == sizeof(u32))
>                 return debugfs_create_u32();
>         if (sizeof(unsigned long) == sizeof(u64))
>                 return debugfs_create_u64();
> 
>         return -EINVAL;
> }

Why would you be wanting to create a "unsigned long" as an api anyway?
Just force it to be u64 all the time, can't you do that?

thanks,

greg k-h
