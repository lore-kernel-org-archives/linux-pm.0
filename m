From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH for 4.12] Revert "pinctrl: rockchip: avoid hardirq-unsafe
 functions in irq_chip"
Date: Tue, 27 Jun 2017 00:32:50 -0700
Message-ID: <20170627073249.GY3730@atomide.com>
References: <20170517225634.GA11404@google.com>
 <20170527021900.GA119873@google.com>
 <20170623205911.GA143883@google.com>
 <alpine.DEB.2.20.1706232353220.2234@nanos>
 <20170627000622.GA63039@google.com>
 <20170627062409.GX3730@atomide.com>
 <20170627070731.GA23083@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:59170 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751492AbdF0Hcz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 27 Jun 2017 03:32:55 -0400
Content-Disposition: inline
In-Reply-To: <20170627070731.GA23083@google.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Heiko Stuebner <heiko@sntech.de>, Linus Walleij <linus.walleij@linaro.org>, linux-rockchip@lists.infradead.org, Julia Cartwright <julia@ni.com>, LKML <linux-kernel@vger.kernel.org>, linux-gpio@vger.kernel.org, John Keeping <john@metanate.com>, linux-pm@vger.kernel.org, Doug Anderson <dianders@chromium.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>, "David.Wu" <david.wu@rock-chips.com>, =?utf-8?B?J+m7hOa2myc=?= <huangtao@rock-chips.com>

* Brian Norris <briannorris@chromium.org> [170627 00:07]:
> On Mon, Jun 26, 2017 at 11:24:09PM -0700, Tony Lindgren wrote:
> > Hmm so how come drivers/bluetooth/btusb.c can't use the generic
> > dev_pm_set_dedicated_wake_irq()? Can you please take a look?
> 
> I took a look previously, and last time I did, there were too many bugs
> for it to be useful. You may have fixed the ones I reported w.r.t.
> assumptions about runtime PM.

Yes several issues got fixed over past few years. If you find issues
please let me know, otherwise I can't help.

> I also recall there being some difficulty with supporting
> level-triggered interrupts that way. (This signal has no device-level
> mask, and it triggers for all sorts of BT activity. There may not be a
> relevant "edge".)

Well typically the wakeirq needs to be disabled during runtime like we
do for the generic wakeirqs. It might be connected to the RX line for
example so it's just noise during runtime. If you actually need it during
runtime then it's a separate story but I doubt that's the case here.

Talking of GPIO interrupt triggering, I wonder if something like below
might help? It seems we're missing the setting of triggering, see below.

> > If there are issues remaining let's rather fix them so we can get rid
> > of the custom tinkering of wake-up events in the drivers.
> 
> That's nice, but that doesn't answer my questions. Perhaps that's a side
> project. The point is that we're clearly violating the documented APIs.

Certainly all these issues need to be fixed if we intent to use it. Funny
how I have not run into these with my test cases. Do you have a GPIO
irqchip on I2C for handling the wake-up interrupts?

Regards,

Tony

8< -------
diff --git a/drivers/base/power/wakeirq.c b/drivers/base/power/wakeirq.c
--- a/drivers/base/power/wakeirq.c
+++ b/drivers/base/power/wakeirq.c
@@ -198,7 +198,8 @@ int dev_pm_set_dedicated_wake_irq(struct device *dev, int irq)
 	 * so we use a threaded irq.
 	 */
 	err = request_threaded_irq(irq, NULL, handle_threaded_wake_irq,
-				   IRQF_ONESHOT, dev_name(dev), wirq);
+				   irq_get_trigger_type(irq) | IRQF_ONESHOT,
+				   dev_name(dev), wirq);
 	if (err)
 		goto err_free;
 
