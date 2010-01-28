From: Pavel Machek <pavel@ucw.cz>
Subject: Re: syncing the disks when entering sleep
Date: Thu, 28 Jan 2010 08:26:58 +0100
Message-ID: <20100128072658.GB25633@atrey.karlin.mff.cuni.cz>
References: <76FA3B279DD9DA48896E2B404944957204E0B241@USA7061MS02.na.xerox.net>
	<201001270151.03241.rjw@sisk.pl> <20100127064534.GA16672@ucw.cz>
	<201001272150.05846.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201001272150.05846.rjw@sisk.pl>
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

> On Wednesday 27 January 2010, Pavel Machek wrote:
> > On Wed 2010-01-27 01:51:03, Rafael J. Wysocki wrote:
> > > On Tuesday 26 January 2010, Pavel Machek wrote:
> ...
> > > > 
> > > > AFAICT no new interface is needed. Just do SNAPSHOT_FREEZE, then
> > > > _S2RAM then _UNFREEZE.
> > > 
> > > That's not quite straightforward and I wouldn't seriously suggest that to
> > > anyone.
> > 
> > Three ioctls, seems pretty much ok.
> 
> They are for something else.  Yes, you could use them for this purpose,
> incidentally.  No, you shouldn't do that.  OK?

Why not? It seems less ugly then the other solution.

> Please note that merely _opening_ /dev/snapshot has side effects, so that's
> not just "three ioctls".

I search Doc*/power/userland-swsusp.txt, and could not find mentions
of sideeffects. Perhaps that should be fixed?
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
