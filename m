From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Mon, 17 May 2010 22:22:22 +0200
Message-ID: <201005172222.22494.rjw__26908.1657090739$1274127970$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1005151716180.24645-100000@netrider.rowland.org>
	<20100517183904.GA14047@gandalf>
	<AANLkTillcFg_y-GeXJNBuIYiGvht-NBZPxwdb71qDui0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTillcFg_y-GeXJNBuIYiGvht-NBZPxwdb71qDui0@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Brian Swetland <swetland@google.com>
Cc: Matthew Garrett <mjg@redhat.com>, me@felipebalbi.com, Theodore Ts'o <tytso@mit.edu>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Geoff Smith <geoffx.smith@intel.com>, Kernel development list <linux-kernel@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Monday 17 May 2010, Brian Swetland wrote:
> On Mon, May 17, 2010 at 11:39 AM, Felipe Balbi <me@felipebalbi.com> wrote:
...
> > but can anyone write an app that holds a suspend_blocker ?? If so, then
> > your goal is already broken, right ? I mean, if anyone can keep a
> > suspend_blocker held forever, you'll never ever sleep, right ? While
> > with runtime, if you keep the keypad open, only the keypad and the paths
> > directly related to it (probably the i2c controller and the power domain
> > where the i2c controller sits) will be kept alive, no ?
> 
> No, you'll never suspend, which is different from never going to the
> lowest CPU power state.  On shipping Android devices we aggressively
> completely power down the CPU in idle whenever we can (based on
> latency requirements generally).  We power off peripherals whenever
> they're not in use.
> 
> This is why I've stated previously that I don't think runtime PM and
> opportunistic suspend are competitive features.

Agreed.

> Everyone who cares about minimizing power should want runtime pm or at least
> similar functionality (our drivers have always powered down peripherals when
> not in use, even while the device is open, etc, prior to the existence
> of runtime PM).

Yes.

> If your environment is such that going to full suspend will not gain
> you anything, then don't use opportunistic suspend.

Exactly.

> We find that there are savings to be had with this model in Android which is
> why we use it.  If you are going to use opportunistic suspend,
> suspend_blockers provide useful functionality.

And as I said, I regard this as a legitimate approach to power management.

Thanks,
Rafael
