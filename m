From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Fri, 7 Jul 2006 10:35:21 +0200
Message-ID: <20060707083521.GF4818@elf.ucw.cz>
References: <Pine.LNX.4.64.0606221210350.5498@g5.osdl.org>
	<20060629030923.GA18968@kroah.com>
	<Pine.LNX.4.64.0606282016220.12404@g5.osdl.org>
	<200607061527.29421.david-b@pacbell.net>
	<20060706232710.GG30500@redhat.com>
	<Pine.LNX.4.64.0607061642290.3869@g5.osdl.org>
	<20060706235952.GK30500@redhat.com>
	<Pine.LNX.4.64.0607062144530.3869@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0607062144530.3869@g5.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Brownell <david-b@pacbell.net>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hi!

> > No, that's something else.  I used to get text on the console, then
> > it went away[1]. some time later, you came along and did the fixes you
> > refer to.
> =

> Ahh.
> =

> > [1] I think it was commit 94c188d32996beac00426740974310e32f162c14
> > which implies userspace can make it come back. That's great, but
> > what if userspace has crashed?
> =

> Ok, that's a different thing, not the normal kernel suspend path, but the =

> user snapshotting thing.
> =

> It seems to expect the user-land tools to do the pm_prepare_console() and =

> pm_restore_console() for you..

Yes, it expects userland tools to do console switching for you.

									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
