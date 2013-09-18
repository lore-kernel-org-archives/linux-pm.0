From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [Suspend-devel] [BUG] 3.7-rc regression bisected: s2disk fails
 to resume image: Processes could not be frozen, cannot continue resuming
Date: Wed, 18 Sep 2013 15:02:19 +0200
Message-ID: <20130918130219.GC2467@amd.pavel.ucw.cz>
References: <20130812234415.7db639bb0d664e56b6ab2ab2@gmail.com>
 <20130827074843.ba1b6f62cc0a6dca8e47c06c@gmail.com>
 <20130905120811.GC15161@amd.pavel.ucw.cz>
 <2662480.5erkm9ACQI@vostro.rjw.lan>
 <20130912123217.e1764291616cf8e59f0f92b8@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:54972 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752137Ab3IRNCU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 Sep 2013 09:02:20 -0400
Content-Disposition: inline
In-Reply-To: <20130912123217.e1764291616cf8e59f0f92b8@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andrew Savchenko <bircoph@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org, suspend-devel@lists.sourceforge.net, viro@zeniv.linux.org.uk, linux-pm@vger.kernel.org

On Thu 2013-09-12 12:32:17, Andrew Savchenko wrote:
> Hello,
> 
> On Thu, 05 Sep 2013 14:23:25 +0200 Rafael J. Wysocki wrote:
> > On Thursday, September 05, 2013 02:08:11 PM Pavel Machek wrote:
> > > Hi!
> > > 
> > > Rafael, Al: apparently we have a regression caused by
> > > ba4df2808a86f8b103c4db0b8807649383e9bd13 .
> > 
> > I noticed that, but I'm not sure how to deal with it.
> > 
> > Also, s2disk still works on my test machines, so that seems to be
> > specific to this particular configuration.
> 
> Is there any way to debug this issue further than just bisecting
> commit? Perhaps suspend ioctl should be traced to see why it fails,
> but I don't know what exactly inside the kernel should be debugged
> and how.

If revert of ba4df2808a86f8b103c4db0b8807649383e9bd13 fixes it, then I
guess it should be just reverted...
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
