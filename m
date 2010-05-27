From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/8] PM: Add suspend block api.
Date: Thu, 27 May 2010 17:41:52 +0200
Message-ID: <20100527154152.GF1957__24885.6283295483$1274974983$gmane$org@elf.ucw.cz>
References: <1273810273-3039-1-git-send-email-arve@android.com>
	<20100520111111.333beb73@schatten.dmk.lab>
	<20100520112642.74d93d26@schatten.dmk.lab>
	<201005210018.43576.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201005210018.43576.rjw@sisk.pl>
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
Cc: Len Brown <len.brown@intel.com>, Andi Kleen <ak@linux.intel.com>, linux-doc@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, linux-kernel@vger.kernel.org, Florian Mickler <florian@mickler.org>, Magnus Damm <damm@igel.co.jp>, Tejun Heo <tj@kernel.org>, linux-pm@lists.linux-foundation.org, Wu Fengguang <fengguang.wu@intel.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > > > Yeah, one file selects behavior of another file, and to read available
> > > > states for opportunistic, you have to write to file first.
> > > > 
> > > > I still don't like the interface.
> > > > 
> > > 
> > > Actually, what would be a better interface? 
> > > 
> > > I wonder why it is not like this:
> 
> Because I think the "forced" and "opportunistic" suspend "modes" are mutually
> exclusive in practice and the interface as proposed reflects that quite well.

Why should they be? Forced disk while opportunistic mem is active
makes a lot of sense. If code can't support it now, just return
-EINVAL, but please don't cripple the interface just because of that.

> > > /sys/power/state 
> > > 	no change, works with and without opportunistic suspend the
> > > 	same. Ignores suspend blockers. Really no change. (From user
> > > 	perspective)
> > > 
> > > /sys/power/opportunistic
> > > 	On / Off
> > > 	While Off the opportunistic suspend is off.
> > > 	While On, the opportunistic suspend is on and if there are no
> > > 	suspend blockers the system goes to suspend. 
> > > 
> > 
> > I forgot, of course there needs to be another knob to implement the
> > "on" behaviour  in the opportunistic mode
> > 
> >  /sys/power/block_opportunistic_suspend
> > 
> > There you have it. One file, one purpose. 
> 
> That's getting messy IMHO.
> 
> In addition to that you get a nice race when the user writes "mem"
> to /sys/power/state and opportunistic suspend happens at the same
> time.

It should not opportunistically suspend when it has work to do (like
entering forced suspend).
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
