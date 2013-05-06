From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] PM: Fix dev_pm_put_subsys_data() to not call kfree()
 while holding device power lock
Date: Mon, 6 May 2013 13:33:30 -0700
Message-ID: <20130506203330.GA11756@kroah.com>
References: <1367614010.8452.2.camel@lorien>
 <1367867093.2953.49.camel@lorien>
 <20130506194119.GA15886@kroah.com>
 <455957427.Z7qXDbUWjg@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:58377 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755971Ab3EFUdb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 6 May 2013 16:33:31 -0400
Content-Disposition: inline
In-Reply-To: <455957427.Z7qXDbUWjg@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Shuah Khan <shuah.kh@samsung.com>, "len.brown@intel.com" <len.brown@intel.com>, "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "shuahkhan@gmail.com" <shuahkhan@gmail.com>

On Mon, May 06, 2013 at 09:56:56PM +0200, Rafael J. Wysocki wrote:
> On Monday, May 06, 2013 12:41:19 PM gregkh@linuxfoundation.org wrote:
> > On Mon, May 06, 2013 at 07:04:53PM +0000, Shuah Khan wrote:
> > > dev_pm_put_subsys_data() calls kfree() while holding device power lock, when
> > > the reference count is 0. Fix it to call kfree() after releasing the lock.
> > > 
> > > Signed-off-by: Shuah Khan <shuah.kh@samsung.com>
> > > Reviewed-by: Pavel Machek <pavel@ucw.cz>
> > > Reviewed-by: Rafael Wysocki <rafael.j.wysocki@intel.com>
> > > ---
> > >  drivers/base/power/common.c |    8 +++++---
> > >  1 file changed, 5 insertions(+), 3 deletions(-)
> > 
> > Is this causing a problem now, and it should go into 3.10 and earlier
> > kernels (if so, which ones?), or can it just wait until 3.11 as it's
> > just a cleanup fix?
> 
> I think it's OK to push the fix for 3.10, but I'll take care of this (I have
> a bunch of fixes for 3.10 anyway, but I'll send a pull request after -rc1,
> because people are sending me fixes pretty much continuously ATM).

Ok, feel free to add:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

