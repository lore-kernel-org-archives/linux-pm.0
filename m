From: David Brownell <david-b@pacbell.net>
Subject: Re: Re: [PATCH] swsusp: do not use pm_ops (was: Re:
	suspend2 merge (was: Re: CFS and suspend2: hang in atomic copy))
Date: Fri, 4 May 2007 15:12:15 -0700
Message-ID: <200705041512.16087.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0705041054520.3417-100000@iolanthe.rowland.org>
	<1178313830.7408.43.camel@johannes.berg>
	<200705042355.19145.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200705042355.19145.rjw@sisk.pl>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: Johannes Berg <johannes@sipsolutions.net>, Pekka Enberg <penberg@cs.helsinki.fi>, Nigel Cunningham <nigel@nigel.suspend2.net>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Friday 04 May 2007, Rafael J. Wysocki wrote:
> On Friday, 4 May 2007 23:23, Johannes Berg wrote:
> > On Fri, 2007-05-04 at 23:11 +0200, Rafael J. Wysocki wrote:
> > 
> > > Actually, prethaw is to prevent drivers loaded before the image is restored
> > > from doing unreasonable things.  It doesn't have any effect on the drivers'
> > > .resume() routines.
> > 
> > Oh, but it can, you could have a flag in your driver saying "the next
> > resume is after restore" and you set that flag in prethaw.
> 
> No, you should have set that flag in .suspend(), really. :-)

That doesn't work very well.  Not only does suspend() not
know the target state, but you don't want to trash the
controller state if you're getting resumed after some kind
of fault in the suspend-to-disk path...

I'm hoping that explains the smiley!

- Dave
