From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: PM / wakeirq: Convert to SRCU
Date: Sat, 24 Jun 2017 14:02:56 +0200
Message-ID: <CAJZ5v0iU86mmcpm_U3u8Ee0c+F3Ym9wumezY8Mr7JZFi78Hkrg@mail.gmail.com>
References: <alpine.DEB.2.20.1706241153260.1941@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.20.1706241153260.1941@nanos>
Sender: linux-gpio-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Brian Norris <briannorris@chromium.org>, Heiko Stuebner <heiko@sntech.de>, Linus Walleij <linus.walleij@linaro.org>, linux-rockchip@lists.infradead.org, Julia Cartwright <julia@ni.com>, LKML <linux-kernel@vger.kernel.org>, linux-gpio@vger.kernel.org, John Keeping <john@metanate.com>, Linux PM <linux-pm@vger.kernel.org>, Doug Anderson <dianders@chromium.org>, Peter Zijlstra <peterz@infradead.org>, Tony Lindgren <tony@atomide.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org

On Sat, Jun 24, 2017 at 11:56 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> The wakeirq infrastructure uses RCU to protect the list of wakeirqs. That
> breaks the irq bus locking infrastructure, which allows sleeping functions
> to be called so interrupt controllers behind slow busses, e.g. i2c, can be
> handled.
>
> The wakeirq functions hold rcu_read_lock and call into irq functions, which
> in case of interrupts using the irq bus locking will trigger a
> might_sleep() splat.
>
> Convert the wakeirq infrastructure to Sleepable RCU and unbreak it.
>
> Fixes: 4990d4fe327b ("PM / Wakeirq: Add automated device wake IRQ handling")
> Reported-by: Brian Norris <briannorris@chromium.org>
> Suggested-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: stable@vger.kernel.org

OK

I guess it would be good to get this into 4.12?

Thanks,
Rafael
