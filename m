From: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: Re: Hibernation considerations
Date: Sat, 21 Jul 2007 13:44:32 +0200
Message-ID: <E1ICDNw-0008HC-00__3341.80791765011$1185018496$gmane$org@dorka.pomaz.szeredi.hu>
References: <Pine.LNX.4.64.0707171319140.2467@asgard.lang.hm>
	<200707192228.05136.rjw@sisk.pl>
	<44037b3d409370919bddd8710e6064fc@bga.com>
	<200707202302.07116.rjw@sisk.pl>
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <200707202302.07116.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: rjw@sisk.pl
Cc: david@lang.hm, linux-kernel@vger.kernel.org, miltonm@bga.com, ying.huang@intel.com, linux-pm@lists.linux-foundation.org, jbms@cmu.edu
List-Id: linux-pm@vger.kernel.org

> The problem with FUSE is related to the fact that the freezer can't
> freeze uninterruptible tasks and we said that perhaps we might avoid
> it if FUSE was made freezing-aware.  Still, no one has gone in this
> direction and I don't know of any plans to do that.

I thought we have fully explored this direction.  Lots of emails, and
an IRC session with Pavel.  Conclusion:

 - It can't be done without VFS surgery + adding various hacks to fuse

 - VFS surgery for the sake of a working suspend is not realistic

Although removing the freezer seems the cleanest solution, I'm not
saying the freezer can't be fixed up in the mean time.

Allowing tasks to remain in uninterruptible sleep seemed a nice way to
get around the fuse issues.  What was the problem with that patch?  It
was something that was supposed to have been tested in suspend2,
wasn't it?

The other one (trying to wake up task, so that may make other tasks
freezable) didn't seem such a good approach to me.

The theory is quite simple: while and after suspending devices, no
tasks must be touching said devices.

The very cleanest way to do this is in the drivers.  The very simplest
way is the current freezer.  But may be there are possibilities
between these two extremes.

But I can almost guarantee you, that any attempt at fixing the issues
though fuse will just result in an even bigger mess than what we
currently have.

Miklos
