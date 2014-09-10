From: Oliver Neukum <oneukum@suse.de>
Subject: Re: error returns of pm_runtime_get()
Date: Wed, 10 Sep 2014 15:04:30 +0200
Message-ID: <1410354270.12706.22.camel@linux-fkkt.site>
References: <1409921016.9532.15.camel@linux-fkkt.site>
	 <3017868.AFCp3kOadE@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:41306 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751048AbaIJNEd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 10 Sep 2014 09:04:33 -0400
In-Reply-To: <3017868.AFCp3kOadE@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Alan Stern <stern@rowland.harvard.edu>

On Sat, 2014-09-06 at 01:42 +0200, Rafael J. Wysocki wrote:
> On Friday, September 05, 2014 02:43:36 PM Oliver Neukum wrote:
> > 
> > Hi,
> > 
> > looking through multiple drivers it seems to me that a great majority
> > is returning the error returns of pm_runtime_get() to user space.
> > They come quite directly from rpm_resume(). So we are led to return
> > things like -EACCESS or -EINVAL from system calls like open()
> > where they have no place.
> 
> Aren't those driver bugs?

Sure, but almost all drivers using runtime PM are affected.

> > So it seems to me like we should filter more or less like this:
> > 
> > -EBUSY		-> -EBUSY
> > -ENOMEM 	-> -ENOMEM
> > -EINPROGRES	-> -EAGAIN
> > any other error	-> -EIO
> > 
> > And it would be best to retain the current name of pm_runtime_get()
> > and introduce a version with unfiltered error codes.
> > What do you think?
> 
> It doesn't sound right to me.  I may be tired at the moment, but I'm not sure
> what the point would be.

The alternative is to make a conversion helper and to go through all
drivers. Not nice, but if necessary I'll do it.
But we cannot just return things like -EACCESS for internal reasons
while the file permissions are good.

	Regards
		Oliver




