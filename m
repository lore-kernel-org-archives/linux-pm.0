From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH RFC] introduce pm_call() macro to get rid
	of	most #ifdef CONFIG_PM
Date: Tue, 4 Mar 2008 00:16:43 +0100
Message-ID: <20080303231643.GL13869__3036.61958682842$1204586495$gmane$org@elf.ucw.cz>
References: <20080302234308.GA10116@zarina> <20080303141818.GE12606@elf.ucw.cz>
	<200803031456.38406.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200803031456.38406.david-b@pacbell.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Anton Vorontsov <cbouatmailru@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi!


> > > +/* avoid `defined but not used' warning */
> > > +#define pm_call(x) ((x) - 1 ? NULL : NULL)
> > > +#endif /* CONFIG_PM */
> > > +
> > 
> > This is evil.
> 
> Ugly, yes.  It might merit some casts too.
> 
> 
> > Maybe your gcc is smart enough to optimize this away, 
> > but I'm not sure mine is.
> 
> It'll be a constant expression; it certainly ought to be.

Well, we have just fooler compiler to think that x is used, and now we
want it to realize that x is unused and compile it out?

Maybe it is smart enough, but...
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
