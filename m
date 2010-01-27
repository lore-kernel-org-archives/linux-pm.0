From: Pavel Machek <pavel@ucw.cz>
Subject: Re: syncing the disks when entering sleep
Date: Wed, 27 Jan 2010 07:45:35 +0100
Message-ID: <20100127064534.GA16672@ucw.cz>
References: <76FA3B279DD9DA48896E2B404944957204E0B241@USA7061MS02.na.xerox.net>
	<201001261917.37194.rjw@sisk.pl> <20100126145113.GA11130@ucw.cz>
	<201001270151.03241.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201001270151.03241.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, "Leisner,
	Martin" <Martin.Leisner@xerox.com>
List-Id: linux-pm@vger.kernel.org

On Wed 2010-01-27 01:51:03, Rafael J. Wysocki wrote:
> On Tuesday 26 January 2010, Pavel Machek wrote:
> > 
> > > > > > The ideal behavior would be:
> > > > > > 
> > > > > >     if(disk is spun up)
> > > > > >         then let the sync happen
> > > > > 
> > > > > I'm not against that.  Patch welcome. :-)
> > > > 
> > > > I'd say such knob would be ugly.
> > > 
> > > Define "ugly", please.
> > 
> > Per-system property, which should better be
> > per-program-that-requires-suspend. You request suspend without syncing
> > (you want it quick, battery is 90%), then the battery runs low, and
> > system daeomn requests s2ram, not realizing that someone disabled sync
> > from under him.
> 
> I really prefer a per-system setting.  The program that wants to sync anyway
> can easily do that by itself.

Well, existing programs expect existing behaviour... Programs that do
not want to sync can easily do it themselves, too, without afecting
rest of system. 

> > > Nope.
> > 
> > Nope what?
> > 
> > AFAICT no new interface is needed. Just do SNAPSHOT_FREEZE, then
> > _S2RAM then _UNFREEZE.
> 
> That's not quite straightforward and I wouldn't seriously suggest that to
> anyone.

Three ioctls, seems pretty much ok.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
