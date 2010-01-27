From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: syncing the disks when entering sleep
Date: Wed, 27 Jan 2010 01:51:03 +0100
Message-ID: <201001270151.03241.rjw@sisk.pl>
References: <76FA3B279DD9DA48896E2B404944957204E0B241@USA7061MS02.na.xerox.net>
	<201001261917.37194.rjw@sisk.pl> <20100126145113.GA11130@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100126145113.GA11130@ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@lists.linux-foundation.org, "Leisner,
	Martin" <Martin.Leisner@xerox.com>
List-Id: linux-pm@vger.kernel.org

On Tuesday 26 January 2010, Pavel Machek wrote:
> 
> > > > > The ideal behavior would be:
> > > > > 
> > > > >     if(disk is spun up)
> > > > >         then let the sync happen
> > > > 
> > > > I'm not against that.  Patch welcome. :-)
> > > 
> > > I'd say such knob would be ugly.
> > 
> > Define "ugly", please.
> 
> Per-system property, which should better be
> per-program-that-requires-suspend. You request suspend without syncing
> (you want it quick, battery is 90%), then the battery runs low, and
> system daeomn requests s2ram, not realizing that someone disabled sync
> from under him.

I really prefer a per-system setting.  The program that wants to sync anyway
can easily do that by itself.

> > > But maybe acceptable way would be echo mem-nosync > power, or maybe it can
> > > already be done using s2disk ioctl interface...?
> > 
> > Nope.
> 
> Nope what?
> 
> AFAICT no new interface is needed. Just do SNAPSHOT_FREEZE, then
> _S2RAM then _UNFREEZE.

That's not quite straightforward and I wouldn't seriously suggest that to
anyone.

Rafael
