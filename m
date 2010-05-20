From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/8] PM: Add suspend block api.
Date: Fri, 21 May 2010 00:18:43 +0200
Message-ID: <201005210018.43576.rjw__677.519691135053$1274394020$gmane$org@sisk.pl>
References: <1273810273-3039-1-git-send-email-arve@android.com>
	<20100520111111.333beb73@schatten.dmk.lab>
	<20100520112642.74d93d26@schatten.dmk.lab>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100520112642.74d93d26@schatten.dmk.lab>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Florian Mickler <florian@mickler.org>
Cc: Len Brown <len.brown@intel.com>, Andi Kleen <ak@linux.intel.com>, linux-doc@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>, Magnus Damm <damm@igel.co.jp>, linux-pm@lists.linux-foundation.org, Wu Fengguang <fengguang.wu@intel.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thursday 20 May 2010, Florian Mickler wrote:
> On Thu, 20 May 2010 11:11:11 +0200
> Florian Mickler <florian@mickler.org> wrote:
> 
> > On Tue, 18 May 2010 15:11:11 +0200
> > Pavel Machek <pavel@ucw.cz> wrote:
> > 
> > > On Thu 2010-05-13 21:11:06, Arve Hj??nnev??g wrote:
> > > > Adds /sys/power/policy that selects the behaviour of /sys/power/state.
> > > > After setting the policy to opportunistic, writes to /sys/power/state
> > > > become non-blocking requests that specify which suspend state to
> > > > enter
> > > 
> > > Yeah, one file selects behavior of another file, and to read available
> > > states for opportunistic, you have to write to file first.
> > > 
> > > I still don't like the interface.
> > > 
> > 
> > Actually, what would be a better interface? 
> > 
> > I wonder why it is not like this:

Because I think the "forced" and "opportunistic" suspend "modes" are mutually
exclusive in practice and the interface as proposed reflects that quite well.

> > /sys/power/state 
> > 	no change, works with and without opportunistic suspend the
> > 	same. Ignores suspend blockers. Really no change. (From user
> > 	perspective)
> > 
> > /sys/power/opportunistic
> > 	On / Off
> > 	While Off the opportunistic suspend is off.
> > 	While On, the opportunistic suspend is on and if there are no
> > 	suspend blockers the system goes to suspend. 
> > 
> 
> I forgot, of course there needs to be another knob to implement the
> "on" behaviour  in the opportunistic mode
> 
>  /sys/power/block_opportunistic_suspend
> 
> There you have it. One file, one purpose. 

That's getting messy IMHO.

In addition to that you get a nice race when the user writes "mem"
to /sys/power/state and opportunistic suspend happens at the same time.
If the latter wins the race, the system will suspend again immediately after
being woken up, which probably is not the result you'd like to get.

Thanks,
Rafael
