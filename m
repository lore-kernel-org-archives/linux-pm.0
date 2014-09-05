From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: error returns of pm_runtime_get()
Date: Sat, 06 Sep 2014 01:42:55 +0200
Message-ID: <3017868.AFCp3kOadE@vostro.rjw.lan>
References: <1409921016.9532.15.camel@linux-fkkt.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:53133 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751702AbaIEXXe (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 5 Sep 2014 19:23:34 -0400
In-Reply-To: <1409921016.9532.15.camel@linux-fkkt.site>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Alan Stern <stern@rowland.harvard.edu>

On Friday, September 05, 2014 02:43:36 PM Oliver Neukum wrote:
> 
> Hi,
> 
> looking through multiple drivers it seems to me that a great majority
> is returning the error returns of pm_runtime_get() to user space.
> They come quite directly from rpm_resume(). So we are led to return
> things like -EACCESS or -EINVAL from system calls like open()
> where they have no place.

Aren't those driver bugs?

> So it seems to me like we should filter more or less like this:
> 
> -EBUSY		-> -EBUSY
> -ENOMEM 	-> -ENOMEM
> -EINPROGRES	-> -EAGAIN
> any other error	-> -EIO
> 
> And it would be best to retain the current name of pm_runtime_get()
> and introduce a version with unfiltered error codes.
> What do you think?

It doesn't sound right to me.  I may be tired at the moment, but I'm not sure
what the point would be.

Rafael

