From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: calling runtime PM from system PM methods
Date: Fri, 10 Jun 2011 19:42:22 +0100
Message-ID: <20110610184222.GT26436__27655.2655421712$1307731503$gmane$org@opensource.wolfsonmicro.com>
References: <20110610155707.GN26436@opensource.wolfsonmicro.com>
	<Pine.LNX.4.44L0.1106101317160.1921-100000@iolanthe.rowland.org>
	<20110610173154.GO26436@opensource.wolfsonmicro.com>
	<201106102038.22725.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201106102038.22725.rjw@sisk.pl>
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
Cc: linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, Jun 10, 2011 at 08:38:22PM +0200, Rafael J. Wysocki wrote:
> On Friday, June 10, 2011, Mark Brown wrote:

> > I think from an interface point of view it's something like
> > UNIVERSAL_DEV_PM_OPS() and friends, probably with some additional ops
> > that can do the glue bits like enabling wakeup and quiescing activity.
> > I'd need to think harder about what exactly that'd look like - for my
> > cases the fundamental thing I want to say is that there's one suspend
> > routine and one resume routine and I'd like some framework code to work
> > out when they're called.

> Can your device generate wakeup signals?

I am interested in a fairly large selection of devices but broadly
speaking any off-SoC device can generate wakeups if it can generate
interrupts.
