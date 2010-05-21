From: Florian Mickler <florian@mickler.org>
Subject: Re: [PATCH 1/8] PM: Add suspend block api.
Date: Fri, 21 May 2010 08:04:17 +0200
Message-ID: <20100521080417.7c8561a5__12147.9149362587$1274422050$gmane$org@schatten.dmk.lab>
References: <1273810273-3039-1-git-send-email-arve@android.com>
	<20100520111111.333beb73@schatten.dmk.lab>
	<20100520112642.74d93d26@schatten.dmk.lab>
	<201005210018.43576.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
Cc: linux-doc@vger.kernel.org, Barnes <jbarnes@virtuousgeek.org>, Andi Kleen <ak@linux.intel.com>, Andrew@smtp1.linux-foundation.org, Len@smtp1.linux-foundation.org, linux-pm@lists.linux-foundation.org, Brown <len.brown@intel.com>, Magnus Damm <damm@igel.co.jp>, Nigel@smtp1.linux-foundation.org, linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>, Morton <akpm@linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>, Jesse@smtp1.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Fri, 21 May 2010 00:18:43 +0200
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> > > Actually, what would be a better interface? 
> > > 
> > > I wonder why it is not like this:
> 
> Because I think the "forced" and "opportunistic" suspend "modes" are mutually
> exclusive in practice and the interface as proposed reflects that quite well.
> 
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
> to /sys/power/state and opportunistic suspend happens at the same time.
> If the latter wins the race, the system will suspend again immediately after
> being woken up, which probably is not the result you'd like to get.

But I don't think there is a problem with that. If the system is
'awake' (suspend blocked) and you hit it with forced 'mem', the system
_has_ to suspend. as that is what forced "mem"  means. And if
opportunistic won the race you would _expect_ the machine to suspend
again after the wakeup (and this time for good).

But perhaps this only makes sense if you can specify different
wake-events for opportunistic and forced suspend.

This is probably some kind of bikeshed by now. I'm alright with the
status quo. For what it's worth (not much): You can add my Reviewed-By.

Cheers,
Flo
