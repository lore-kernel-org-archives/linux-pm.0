From: Pavel Machek <pavel@ucw.cz>
Subject: Re: suspend blockers & Android integration
Date: Thu, 10 Jun 2010 15:58:45 +0200
Message-ID: <20100610135844.GH4514__38971.3675286204$1276178737$gmane$org@ucw.cz>
References: <20100603193045.GA7188@elte.hu>
	<AANLkTinsOF3wnxsruR0TvjBAQcHks4tf0ay_sM2xB_p4@mail.gmail.com>
	<20100604075722.GA15181@elte.hu>
	<AANLkTiksGnpL8tkcc5eScWHrGoijyZNUwZik5lXmU_TS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <AANLkTiksGnpL8tkcc5eScWHrGoijyZNUwZik5lXmU_TS@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Brian Swetland <swetland@google.com>
Cc: tytso@mit.edu, Peter Zijlstra <a.p.zijlstra@chello.nl>, Florian Mickler <florian@mickler.org>, Neil Brown <neilb@suse.de>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, James Bottomley <James.Bottomley@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux PM <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Felipe Balbi <felipe.balbi@nokia.com>
List-Id: linux-pm@vger.kernel.org

Hi!

> >> We started here because it's possibly the only api level change we have --
> >> almost everything else is driver or subarch type work or controversial but
> >> entirely self-contained (like the binder, which I would be shocked to see
> >> ever hit mainline). [...]
> >
> > So why arent those bits mainline? It's a 1000 times easier to get drivers and
> > small improvements and non-ABI changes upstream.
> >
> > After basically two years of growing your fork (and some attempts to get your
> > drivers into drivers/staging/ - from where they have meanwhile dropped out
> > again) you re-started with the worst possible thing to merge: a big and
> > difficult kernel feature affecting many subsystems. Why?
> 
> Because a large number of our drivers depend on it.

The dependencies are trivial. Last time I checked, you had about
150KLoC drivers, with about 100 lines depending on wakelock support --
I know, I cleaned it up from staging.

The changes required for merging 150KLoC will be definitely much
bigger than 100 lines...

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
