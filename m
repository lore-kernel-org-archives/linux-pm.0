From: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH for 4.12] Revert "pinctrl: rockchip: avoid hardirq-unsafe
 functions in irq_chip"
Date: Tue, 27 Jun 2017 00:07:33 -0700
Message-ID: <20170627070731.GA23083@google.com>
References: <20170517225634.GA11404@google.com>
 <20170527021900.GA119873@google.com>
 <20170623205911.GA143883@google.com>
 <alpine.DEB.2.20.1706232353220.2234@nanos>
 <20170627000622.GA63039@google.com>
 <20170627062409.GX3730@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:36836 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751658AbdF0HHh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Jun 2017 03:07:37 -0400
Received: by mail-pf0-f175.google.com with SMTP id q86so12030056pfl.3
        for <linux-pm@vger.kernel.org>; Tue, 27 Jun 2017 00:07:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170627062409.GX3730@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Heiko Stuebner <heiko@sntech.de>, Linus Walleij <linus.walleij@linaro.org>, linux-rockchip@lists.infradead.org, Julia Cartwright <julia@ni.com>, LKML <linux-kernel@vger.kernel.org>, linux-gpio@vger.kernel.org, John Keeping <john@metanate.com>, linux-pm@vger.kernel.org, Doug Anderson <dianders@chromium.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>, "David.Wu" <david.wu@rock-chips.com>, =?utf-8?B?J+m7hOa2myc=?= <huangtao@rock-chips.com>

On Mon, Jun 26, 2017 at 11:24:09PM -0700, Tony Lindgren wrote:
> Hmm so how come drivers/bluetooth/btusb.c can't use the generic
> dev_pm_set_dedicated_wake_irq()? Can you please take a look?

I took a look previously, and last time I did, there were too many bugs
for it to be useful. You may have fixed the ones I reported w.r.t.
assumptions about runtime PM.

I also recall there being some difficulty with supporting
level-triggered interrupts that way. (This signal has no device-level
mask, and it triggers for all sorts of BT activity. There may not be a
relevant "edge".)

> If there are issues remaining let's rather fix them so we can get rid
> of the custom tinkering of wake-up events in the drivers.

That's nice, but that doesn't answer my questions. Perhaps that's a side
project. The point is that we're clearly violating the documented APIs.

Brian
