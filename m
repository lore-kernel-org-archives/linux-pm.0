From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [Update x3][PATCH 7/9] PM / Runtime: Generic clock
 manipulation rountines for runtime PM (v6)
Date: Tue, 03 May 2011 10:00:58 -0700
Message-ID: <4DC034CA.6000505__37539.2416179695$1304442191$gmane$org@codeaurora.org>
References: <201104130205.26988.rjw@sisk.pl> <4DBB12EF.9030000@codeaurora.org>
	<201104292229.56518.rjw@sisk.pl> <201104300004.02601.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201104300004.02601.rjw@sisk.pl>
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
Cc: linux-sh@vger.kernel.org, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On 04/29/2011 03:04 PM, Rafael J. Wysocki wrote:
> +
> +/**
> + * enable_clock - Enable a device clock.
> + * @dev: Device whose clock is to be enabled.
> + * @con_id: Connection ID of the clock.
> + */
> +static void enable_clock(struct device *dev, const char *con_id)
> +{
> +	struct clk *clk;
> +
> +	clk = clk_get(dev, con_id);
> +	if (!IS_ERR(clk)) {
> +		clk_enable(clk);
> +		clk_put(clk);
> +		dev_info(dev, "Runtime PM disabled, clock forced on.\n");
> +	}
> +}

This doesn't make much sense to me. You're getting a clock and then
enabling it and then putting the clock? How can you be so sure that
clk_put() won't one day do some kind of lower power mode on the clock
when clk_put() is called on it? I don't think anyone does anything
today, but I don't think its safe to assume that clk_put() won't try to
forcibly shut off the clock once all clk_get() callers have clk_put().

Perhaps we should document the meaning of clk_enable() followed by
clk_put() somewhere instead?

> +
> +/**
> + * disable_clock - Disable a device clock.
> + * @dev: Device whose clock is to be disabled.
> + * @con_id: Connection ID of the clock.
> + */
> +static void disable_clock(struct device *dev, const char *con_id)
> +{
> +	struct clk *clk;
> +
> +	clk = clk_get(dev, con_id);
> +	if (!IS_ERR(clk)) {
> +		clk_disable(clk);
> +		clk_put(clk);
> +		dev_info(dev, "Runtime PM disabled, clock forced off.\n");
> +	}
> +}

This might not be as bad, but it looks like a similar problem.

> -
> -static int platform_bus_notify(struct notifier_block *nb,
> -			       unsigned long action, void *data)
> -{
> -	struct device *dev = data;
> -	struct clk *clk;
> -
> -	dev_dbg(dev, "platform_bus_notify() %ld !\n", action);
> -
> -	switch (action) {
> -	case BUS_NOTIFY_BIND_DRIVER:
> -		clk = clk_get(dev, NULL);
> -		if (!IS_ERR(clk)) {
> -			clk_enable(clk);
> -			clk_put(clk);
> -			dev_info(dev, "runtime pm disabled, clock forced on\n");
> -		}
> -		break;
> -	case BUS_NOTIFY_UNBOUND_DRIVER:
> -		clk = clk_get(dev, NULL);
> -		if (!IS_ERR(clk)) {
> -			clk_disable(clk);
> -			clk_put(clk);
> -			dev_info(dev, "runtime pm disabled, clock forced off\n");
> -		}

Ah ok I see that it's coming from here.

BTW, whatever is in linux-next is failing to compile:

drivers/base/power/clock_ops.c:391: error: 'con_id' undeclared (first
use in this function)
drivers/base/power/clock_ops.c:391: error: (Each undeclared identifier
is reported only once
drivers/base/power/clock_ops.c:391: error: for each function it appears in.)

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
