From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Update x3][PATCH 7/9] PM / Runtime: Generic clock
	manipulation rountines for runtime PM (v6)
Date: Tue, 3 May 2011 19:38:14 +0200
Message-ID: <201105031938.14953.rjw__47877.4677416824$1304444545$gmane$org@sisk.pl>
References: <201104130205.26988.rjw@sisk.pl> <201104300004.02601.rjw@sisk.pl>
	<4DC034CA.6000505@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4DC034CA.6000505@codeaurora.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-sh@vger.kernel.org, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, May 03, 2011, Stephen Boyd wrote:
> On 04/29/2011 03:04 PM, Rafael J. Wysocki wrote:
> > +
> > +/**
> > + * enable_clock - Enable a device clock.
> > + * @dev: Device whose clock is to be enabled.
> > + * @con_id: Connection ID of the clock.
> > + */
> > +static void enable_clock(struct device *dev, const char *con_id)
> > +{
> > +	struct clk *clk;
> > +
> > +	clk = clk_get(dev, con_id);
> > +	if (!IS_ERR(clk)) {
> > +		clk_enable(clk);
> > +		clk_put(clk);
> > +		dev_info(dev, "Runtime PM disabled, clock forced on.\n");
> > +	}
> > +}
> 
> This doesn't make much sense to me. You're getting a clock and then
> enabling it and then putting the clock? How can you be so sure that
> clk_put() won't one day do some kind of lower power mode on the clock
> when clk_put() is called on it? I don't think anyone does anything
> today, but I don't think its safe to assume that clk_put() won't try to
> forcibly shut off the clock once all clk_get() callers have clk_put().
> 
> Perhaps we should document the meaning of clk_enable() followed by
> clk_put() somewhere instead?

That's coming from some existing ARM shmobile code.

There are two alternatives, one not to do any clock management at all
when CONFIG_PM_RUNTIME is unset, the other to remove the "put" from
enable_clock(), but then disable_clock() would need to do "put" twice.
I didn't think any of them was better than the current code.

> > +
> > +/**
> > + * disable_clock - Disable a device clock.
> > + * @dev: Device whose clock is to be disabled.
> > + * @con_id: Connection ID of the clock.
> > + */
> > +static void disable_clock(struct device *dev, const char *con_id)
> > +{
> > +	struct clk *clk;
> > +
> > +	clk = clk_get(dev, con_id);
> > +	if (!IS_ERR(clk)) {
> > +		clk_disable(clk);
> > +		clk_put(clk);
> > +		dev_info(dev, "Runtime PM disabled, clock forced off.\n");
> > +	}
> > +}
> 
> This might not be as bad, but it looks like a similar problem.
> 
> > -
> > -static int platform_bus_notify(struct notifier_block *nb,
> > -			       unsigned long action, void *data)
> > -{
> > -	struct device *dev = data;
> > -	struct clk *clk;
> > -
> > -	dev_dbg(dev, "platform_bus_notify() %ld !\n", action);
> > -
> > -	switch (action) {
> > -	case BUS_NOTIFY_BIND_DRIVER:
> > -		clk = clk_get(dev, NULL);
> > -		if (!IS_ERR(clk)) {
> > -			clk_enable(clk);
> > -			clk_put(clk);
> > -			dev_info(dev, "runtime pm disabled, clock forced on\n");
> > -		}
> > -		break;
> > -	case BUS_NOTIFY_UNBOUND_DRIVER:
> > -		clk = clk_get(dev, NULL);
> > -		if (!IS_ERR(clk)) {
> > -			clk_disable(clk);
> > -			clk_put(clk);
> > -			dev_info(dev, "runtime pm disabled, clock forced off\n");
> > -		}
> 
> Ah ok I see that it's coming from here.

Yes, it is.

> BTW, whatever is in linux-next is failing to compile:
> 
> drivers/base/power/clock_ops.c:391: error: 'con_id' undeclared (first
> use in this function)
> drivers/base/power/clock_ops.c:391: error: (Each undeclared identifier
> is reported only once
> drivers/base/power/clock_ops.c:391: error: for each function it appears in.)

I guess that's with CONFIG_PM_RUNTIME unset, right?

Sorry about that, the appended patch should fix the issue.

Thanks,
Rafael


---
From: Rafael J. Wysocki <rjw@sisk.pl>
Subject: PM: Fix build issue in clock_ops.c for CONFIG_PM_RUNTIME unset

Fix a build issue in drivers/base/power/clock_ops.c occuring when
CONFIG_PM_RUNTIME is not set.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/base/power/clock_ops.c |    1 +
 1 file changed, 1 insertion(+)

Index: linux-2.6/drivers/base/power/clock_ops.c
===================================================================
--- linux-2.6.orig/drivers/base/power/clock_ops.c
+++ linux-2.6/drivers/base/power/clock_ops.c
@@ -380,6 +380,7 @@ static int pm_runtime_clk_notify(struct
 {
 	struct pm_clk_notifier_block *clknb;
 	struct device *dev = data;
+	char *con_id;
 
 	dev_dbg(dev, "%s() %ld\n", __func__, action);
 
