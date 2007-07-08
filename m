From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Sun, 8 Jul 2007 23:07:29 +0200
Message-ID: <20070708210729.GC5401@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0707072224270.10912-100000@netrider.rowland.org>
	<1183871661.3388.282.camel@localhost.localdomain>
	<200707082115.27363.rjw@sisk.pl>
	<1183928612.3388.289.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1183928612.3388.289.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-kernel@vger.kernel.org, Kyle Moffett <mrmacman_g4@mac.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi!

> > > I just think that the freezer approach, as it is, is backward. We can't
> > > have a 3rd party try to discriminate what to freeze and what not, it
> > > will always get something wrong, and in some cases with the wrong timing
> > > or ordering.
> > 
> > Nice discussion, except for one thing: the freezer doesn't decide what to
> > freeze.  For example, even right now kernel threads decide if they want to be
> > frozen.
> 
> Somewhat... userspace doesn't and workqueues are a gray area.

But userspace must not be neccessary for kernel functioning, so that's
quite okay. And we do need to solve the workqueues.

> Also, I've been thinking this "icebox" idea a bit more and it seems in
> fact a bit racy in some areas, at least for use by things like drivers,
> unless we end up doing something aking to an RCU on suspend, waiting for
> all tasks to reach userland once, but that has the same annoyances as
> the current freezer.
> 
> Thus I'm tempted to go back to saying that driver can handle things
> locally :-)

:-). Or perhaps freezer is not _that_ evil after all?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
