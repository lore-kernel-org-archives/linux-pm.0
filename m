From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/3] perf: add calls to suspend trace point
Date: Wed, 5 Jan 2011 12:23:13 +0100
Message-ID: <20110105112313.GA18546__1224.15339942581$1294226688$gmane$org@atrey.karlin.mff.cuni.cz>
References: <1294136263-24020-1-git-send-email-j-pihet@ti.com>
	<201101050001.23979.rjw@sisk.pl>
	<AANLkTimRvZs2QBZ4y+AEO7CWUudwBSM6-K0ZQxFTF+Fm@mail.gmail.com>
	<201101051115.55528.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201101051115.55528.rjw@sisk.pl>
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
Cc: Len Brown <len.brown@intel.com>, Jean Pihet <j-pihet@ti.com>, Jean Pihet <jean.pihet@newoldbits.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, mingo@elte.hu, linux-omap@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi!

> > >> I am in favor of 3) of 4).
> > >> What do you think?
> > >
> > > Why don't we keep the tracepoints as proposed _and_ add two additional
> > > tracepoints around device suspend-resume?
> > I like the idea but that requires to extend the current API with
> > additional suspend tracepoints or device state change tracepoints.
> > That can be done once the current API is firmly in place.
> > Today the only trace API for suspend is machine_suspend(unsigned int
> > state), so I think the best option is 3) here above.
> > 
> > Unless there is an objection I am pushing 3) asap.
> 
> Fine by me.

Why not...

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
