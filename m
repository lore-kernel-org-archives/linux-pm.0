From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: runtime PM: common hooks for static and runtime PM
Date: Fri, 5 Feb 2010 10:41:40 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1002051038001.23817-100000@netrider.rowland.org>
References: <20100205104356.GB2600@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100205104356.GB2600@sirena.org.uk>
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

> On Thu, Feb 04, 2010 at 10:24:48AM -0500, Alan Stern wrote:
> > On Wed, 3 Feb 2010, Kevin Hilman wrote:
> 
> > > I understand the motivation for this is probably to prevent runtime PM
> > > transitions during static suspend, and that makes sense.  However, I'm
> > > wondering if there's some other way to handle my problem without
> > > having to have the driver have different paths for static and runtime
> > > PM.
> 
> > The system PM methods could directly call the runtime_suspend and
> > runtime_resume methods (which presumably is where you actually disable
> > or enable the clocks etc.), instead of going indirectly through
> > pm_runtime_put_sync() and pm_runtime_get_sync().
> 
> > Or alternatively, both sets of PM methods could call a single pair of
> > routines to handle the clocks etc.
> 
> One issue with avoiding the indirection is that they'll need to remember
> if the device is already suspended in order to avoid doing things like
> double disabling of clocks or regulators.  Using the runtime PM calls
> would mean that the core would keep track of that for the driver.

As you have found out, that approach doesn't work.  You need to figure
out some way of your own to avoid double disabling.  The PM core can't
do it for you, because there may be devices that enter _different_
power states for runtime suspend and system suspend.  For the sake of 
such devices the core _has_ to do double suspends.

Alan Stern
