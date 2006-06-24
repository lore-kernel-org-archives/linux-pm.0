From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Sat, 24 Jun 2006 23:33:14 +0200
Message-ID: <20060624213313.GD2777@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0606211219170.6700-100000@iolanthe.rowland.org>
	<Pine.LNX.4.64.0606231216290.6483@g5.osdl.org>
	<1151106818.16946.19.camel@localhost.localdomain>
	<200606232028.22618.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <200606232028.22618.david-b@pacbell.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hi!

> > I've very rarely seen drivers trying to do _anything_ to work around STD
> > specific issues. I think Pavel and David are right there... suspend() is
> > mostly written for STR and that way happens to work with STD...
> =

> I don't think I've used those words ... :)
> =

> The PRETHAW patches (which I'll forward for MM after I retest against
> the latest GIT tree) are proof that the suspend-to-disk resume paths
> actually **DON'T** just happen to work in all cases.  Which does pretty
> much show that the STD stuff (FREEZE etc) was an afterthought.

Well... lets say that PRETHAW patches were only introduced _years_
after swsusp started working -- so it is not _that_ important.

Yes, you are right, in resume path, during s2ram you can assume
hardware was powered on, while in s2disk case hardware might have been
already initialized or not.

In practice, it is not a big deal.
								Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
