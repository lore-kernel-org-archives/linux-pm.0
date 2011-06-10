From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: calling runtime PM from system PM methods
Date: Fri, 10 Jun 2011 20:38:22 +0200
Message-ID: <201106102038.22725.rjw__7109.40698995746$1307731184$gmane$org@sisk.pl>
References: <20110610155707.GN26436@opensource.wolfsonmicro.com>
	<Pine.LNX.4.44L0.1106101317160.1921-100000@iolanthe.rowland.org>
	<20110610173154.GO26436@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110610173154.GO26436@opensource.wolfsonmicro.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: linux-omap@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: linux-pm@vger.kernel.org

On Friday, June 10, 2011, Mark Brown wrote:
> On Fri, Jun 10, 2011 at 01:17:56PM -0400, Alan Stern wrote:
> > On Fri, 10 Jun 2011, Mark Brown wrote:
> 
> > > ignores that), it's noticably harder to reason about what's going on
> > > when I go outside there and when I think about what I'm doing it always
> > > feels like it should be possible to factor it out of the drivers.
> 
> > What would make the common cases easier?
> 
> I think from an interface point of view it's something like
> UNIVERSAL_DEV_PM_OPS() and friends, probably with some additional ops
> that can do the glue bits like enabling wakeup and quiescing activity.
> I'd need to think harder about what exactly that'd look like - for my
> cases the fundamental thing I want to say is that there's one suspend
> routine and one resume routine and I'd like some framework code to work
> out when they're called.

Can your device generate wakeup signals?

Rafael
