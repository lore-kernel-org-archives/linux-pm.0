From: Pavel Machek <pavel@ucw.cz>
Subject: Re: syncing the disks when entering sleep
Date: Wed, 27 Jan 2010 10:55:33 +0100
Message-ID: <20100127095532.GA12752@atrey.karlin.mff.cuni.cz>
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


> > Per-system property, which should better be
> > per-program-that-requires-suspend. You request suspend without syncing
> > (you want it quick, battery is 90%), then the battery runs low, and
> > system daeomn requests s2ram, not realizing that someone disabled sync
> > from under him.
> 
> I really prefer a per-system setting.  The program that wants to sync anyway
> can easily do that by itself.

Yes, but existing apps do not know they have to sync. You are
essentially adding "break back compatibility" system wide option, when
better alternative exists... See above for concrete example where it
may hurt.

> > Nope what?
> > 
> > AFAICT no new interface is needed. Just do SNAPSHOT_FREEZE, then
> > _S2RAM then _UNFREEZE.
> 
> That's not quite straightforward and I wouldn't seriously suggest that to
> anyone.

Well, seems more straightforward than running around and adding sync
to all the scripts/programs just to keep existing behaviour.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
