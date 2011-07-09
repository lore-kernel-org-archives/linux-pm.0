From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Runtime PM discussion notes
Date: Sat, 9 Jul 2011 05:06:22 +0100
Message-ID: <20110709040622.GH26900__22539.0871674337$1310184471$gmane$org@sirena.org.uk>
References: <Pine.LNX.4.44L0.1106231113170.2033-100000@iolanthe.rowland.org>
	<201106232234.21930.rjw@sisk.pl>
	<alpine.DEB.2.00.1106241239340.25533@utopia.booyaka.com>
	<BANLkTinaa2W0mTUGCzfLAgBsgC5nP57x9ZXC0PfOvqa7x16kvw@mail.gmail.com>
	<alpine.DEB.2.00.1106281346160.2874@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1106281346160.2874@utopia.booyaka.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Jun 28, 2011 at 01:47:47PM -0600, Paul Walmsley wrote:
> On Fri, 24 Jun 2011, Arve Hj?nnev?g wrote:
> > On Fri, Jun 24, 2011 at 12:53 PM, Paul Walmsley <paul@pwsan.com> wrote:

> > > "On the hardware that shipped we enter the same power state from idle
> > > and suspend, so the only power savings we get from suspend that we
> > > don't get in idle is from not respecting the scheduler and timers."

> > This is no longer the case. Both the Nexus-S and Xoom enter lower
> > power states from suspend than idle.

> Just out of curiosity, is that due to some kind of hardware limitation on 
> those platforms, or is it because the software infrastructure for dynamic 
> deep idle hasn't been fully implemented in that subarchitecture code?

At least the Nexus S doesn't implmeent any of the deep idle
infrastructure.  However, I'd expect that you can achieve some power
saving from entering system suspend as if *everything* is off then the
PMIC can be suspended which can enable additional power savings.  Unless
I'm missing something that'd be hard to hit with cpuidle only stuff.
