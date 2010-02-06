From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: runtime PM: common hooks for static and runtime PM
Date: Fri, 5 Feb 2010 21:57:46 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1002052148340.6076-100000@netrider.rowland.org>
References: <20100205224421.GA5466@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100205224421.GA5466@sirena.org.uk>
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

> On Fri, Feb 05, 2010 at 04:40:11PM -0500, Alan Stern wrote:
> > On Fri, 5 Feb 2010, Mark Brown wrote:
> 
> > > I wonder if it's worth the PM core providing an off the shelf suspend
> > > and resume via runtime PM implementation so drivers only need to assign
> > > function pointers?  As Kevin says this is going to be *very* common for
> > > embedded drivers.
> 
> > What's so hard about doing this?
> > 
> > 	int my_suspend(struct device *dev)
> > 	{
> > 		if (dev->power.runtime_status == RPM_SUSPENDED)
> > 			return 0;
> > 		return my_runtime_suspend(dev);
> > 	}
> 
> > Or if you prefer, stick the "if" statement at the beginning of your 
> > suspend method and then set both function pointers to the same method.
> 
> It's not that it's hard per se, it's that it feels like it's peering
> inside the implementation of the API.  Having the PM core provide
> something would make it clear that this is the expected approach and
> ensure that there aren't any silly mistakes, in much the same way that
> having SIMPLE_DEV_PM_OPS makes the handling of drivers that use the same
> suspend path for both suspend to disk and suspend to RAM clear.

You mean like providing an is_runtime_suspended() test?  Then you could 
write:

	int my_suspend(struct device *dev)
	{
		if (is_runtime_suspended(dev))
			return 0;
		return my_runtime_suspend(dev);
	}

Or maybe you'd prefer to see a convenient pm_use_runtime_suspend() 
function that you could use for your dev_pm_ops.suspend pointer, which 
would do essentially the same as the above?  (Along with a 
corresponding pm_use_runtime_resume() function, of course.)

Alan Stern
