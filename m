From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: runtime PM: common hooks for static and runtime PM
Date: Fri, 5 Feb 2010 16:40:11 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1002051630340.784-100000@netrider.rowland.org>
References: <20100205161122.GE2600@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100205161122.GE2600@sirena.org.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Fri, 5 Feb 2010, Mark Brown wrote:

> > As you have found out, that approach doesn't work.  You need to figure
> > out some way of your own to avoid double disabling.  The PM core can't
> > do it for you, because there may be devices that enter _different_
> > power states for runtime suspend and system suspend.  For the sake of 
> > such devices the core _has_ to do double suspends.
> 
> Right, but my point is that one reason for wanting to call into the
> runtime PM API during vanilla suspend is that the indirection buys you
> the reference counting.

It's not reference counting; it's just a state variable.  (There _is_ a
reference counter involved, but you don't want to use it.)

> I wonder if it's worth the PM core providing an off the shelf suspend
> and resume via runtime PM implementation so drivers only need to assign
> function pointers?  As Kevin says this is going to be *very* common for
> embedded drivers.

What's so hard about doing this?

	int my_suspend(struct device *dev)
	{
		if (dev->power.runtime_status == RPM_SUSPENDED)
			return 0;
		return my_runtime_suspend(dev);
	}

Or if you prefer, stick the "if" statement at the beginning of your 
suspend method and then set both function pointers to the same method.

Alan Stern
