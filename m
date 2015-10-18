From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH V3] debugfs: Add debugfs_create_ulong()
Date: Sun, 18 Oct 2015 10:10:18 -0700
Message-ID: <20151018171018.GB31988@kroah.com>
References: <6d786424835b514b92f847e6f9af21b01244de85.1445159433.git.viresh.kumar@linaro.org>
 <20151018162140.GA30196@kroah.com>
 <20151018164409.GE19018@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:50346 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932103AbbJRRKV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 18 Oct 2015 13:10:21 -0400
Content-Disposition: inline
In-Reply-To: <20151018164409.GE19018@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, Rafael Wysocki <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, arnd@arndb.de, sboyd@codeaurora.org, linux-pm@vger.kernel.org, linux@arm.linux.org.uk, stern@rowland.harvard.edu

On Sun, Oct 18, 2015 at 10:14:09PM +0530, Viresh Kumar wrote:
> On 18-10-15, 09:21, Greg Kroah-Hartman wrote:
> > On Sun, Oct 18, 2015 at 02:45:27PM +0530, Viresh Kumar wrote:
> > > Add debugfs_create_ulong() for the users of type 'unsigned long'. These
> > > will be 32 bits long on a 32 bit machine and 64 bits long on a 64 bit
> > > machine.
> > 
> > Do you really need a debugfs_create_xlong()?  You don't mention it here
> > in your changelog comment yet the patch contains it.  I'd hold off for
> > it for now as I doubt anyone needs it...
> 
> At least my use case doesn't need it, but I thought it will be better
> to implement the ulong series in the same way other interfaces are
> implemented.
> 
> I can drop that part if you want.

Please do, I don't like adding apis that no one uses.

thanks,

greg k-h
