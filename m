From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: [PATCH] swsusp: do not use pm_ops (was: Re:
	suspend2 merge (was: Re: CFS and suspend2: hang in atomic copy))
Date: Sat, 5 May 2007 00:21:28 +0200
Message-ID: <200705050021.29481.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0705041054520.3417-100000@iolanthe.rowland.org>
	<200705042355.19145.rjw@sisk.pl>
	<1178315667.7408.47.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1178315667.7408.47.camel@johannes.berg>
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
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-pm@lists.linux-foundation.org, Pekka Enberg <penberg@cs.helsinki.fi>, Nigel Cunningham <nigel@nigel.suspend2.net>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Friday, 4 May 2007 23:54, Johannes Berg wrote:
> On Fri, 2007-05-04 at 23:55 +0200, Rafael J. Wysocki wrote:
> > On Friday, 4 May 2007 23:23, Johannes Berg wrote:
> > > On Fri, 2007-05-04 at 23:11 +0200, Rafael J. Wysocki wrote:
> > > 
> > > > Actually, prethaw is to prevent drivers loaded before the image is restored
> > > > from doing unreasonable things.  It doesn't have any effect on the drivers'
> > > > .resume() routines.
> > > 
> > > Oh, but it can, you could have a flag in your driver saying "the next
> > > resume is after restore" and you set that flag in prethaw.
> > 
> > No, you should have set that flag in .suspend(), really. :-)
> 
> Yeah, whatever. You can fix the problem but it's ugly. Let's come up
> with a good way to do the 6 callbacks mentioned in some other thread
> earlier.

This is the plan, but we need to do some preparations.

For example, I think, we should introduce some consistent terminology, so that
we *always* know what we're talking about.

Greetings,
Rafael
