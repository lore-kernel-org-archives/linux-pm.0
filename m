From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PM/domains: add delayed power off capability
Date: Thu, 14 Mar 2013 10:59:12 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1303141053570.1983-100000@iolanthe.rowland.org>
References: <20130314085916.GC18519@tbergstrom-lnx.Nvidia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:52446 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757745Ab3CNO7N (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 14 Mar 2013 10:59:13 -0400
In-Reply-To: <20130314085916.GC18519@tbergstrom-lnx.Nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter De Schrijver <pdeschrijver@nvidia.com>
Cc: Kevin Hilman <khilman@linaro.org>, Mayuresh Kulkarni <mkulkarni@nvidia.com>, Greg KH <gregkh@linuxfoundation.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "len.brown@intel.com" <len.brown@intel.com>, "pavel@ucw.cz" <pavel@ucw.cz>, "rjw@sisk.pl" <rjw@sisk.pl>

On Thu, 14 Mar 2013, Peter De Schrijver wrote:

> > Your drivers should be using runtime PM, which has an autosuspend
> > timeout feature.  Using autosuspend on any device in the power domain
> > will have the same effect as this proposed patch.  
> > 
> > Using runtime PM to target specific devices that have expensive
> > save/restore paths is also more understandable and maintainable IMO,
> > because the "fix" is targetted.
> > 
> 
> No. The goal of this patch is to introduce something similar to autosuspend
> for turning off domains. Even if all peripherals in a domain are idle, you
> might not want to turn off the domain immediately, but wait a little in case
> a new request comes in. We are using this scheme today in our GPU driver and
> it works quite well, but that's done entirely without PM domains.

The real question here is whether it would be better to implement 
delayed suspend for PM domains or to use autosuspend for all the 
devices in those domains.

The implications of doing it one way rather than the other aren't 
entirely clear.  One thing: PM domains aren't exposed in sysfs, are 
theY?  If not, there is no way for userspace to adjust the length of 
the delay.  That's a definite disadvantage.

Alan Stern

