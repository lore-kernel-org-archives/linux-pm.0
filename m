From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: runtime PM: common hooks for static and runtime PM
Date: Fri, 5 Feb 2010 22:44:22 +0000
Message-ID: <20100205224421.GA5466@sirena.org.uk>
References: <20100205161122.GE2600@sirena.org.uk>
	<Pine.LNX.4.44L0.1002051630340.784-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1002051630340.784-100000@netrider.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Fri, Feb 05, 2010 at 04:40:11PM -0500, Alan Stern wrote:
> On Fri, 5 Feb 2010, Mark Brown wrote:

> > I wonder if it's worth the PM core providing an off the shelf suspend
> > and resume via runtime PM implementation so drivers only need to assign
> > function pointers?  As Kevin says this is going to be *very* common for
> > embedded drivers.

> What's so hard about doing this?
> 
> 	int my_suspend(struct device *dev)
> 	{
> 		if (dev->power.runtime_status == RPM_SUSPENDED)
> 			return 0;
> 		return my_runtime_suspend(dev);
> 	}

> Or if you prefer, stick the "if" statement at the beginning of your 
> suspend method and then set both function pointers to the same method.

It's not that it's hard per se, it's that it feels like it's peering
inside the implementation of the API.  Having the PM core provide
something would make it clear that this is the expected approach and
ensure that there aren't any silly mistakes, in much the same way that
having SIMPLE_DEV_PM_OPS makes the handling of drivers that use the same
suspend path for both suspend to disk and suspend to RAM clear.
