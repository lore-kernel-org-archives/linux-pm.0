From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.23-rc2 1/2] define clk_must_disable()
Date: Tue, 7 Aug 2007 14:04:41 -0700
Message-ID: <200708071404.41476.david-b@pacbell.net>
References: <200708061111.03407.david-b@pacbell.net>
	<20070806222351.090dc035.akpm@linux-foundation.org>
	<20070807125054.GC2833@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070807125054.GC2833@flint.arm.linux.org.uk>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: Andrew Victor <andrew@sanpeople.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tuesday 07 August 2007, Russell King wrote:

> 3. due to the negative semantics, code such as the following is difficult
>    to interpret and work out whether it's correct due to the double
>    negative:

In terms of pure patch review, the "-" bit you omitted sure helps me
to see that it's an "obviously" correct transformation:

  -       if (device_may_wakeup(&pdev->dev) && !at91_suspend_entering_slow_clock())
>   +     if (device_may_wakeup(&pdev->dev)
>   +                     && !clk_must_disable(atmel_port->clk))
>                 enable_irq_wake(port->irq);

In the case of nutball configurations like clocking UART from 32KiHz,
it's more correct.  Likewise, it can work with AVR32 platforms, once
they support PM.


There are numerous idioms that one could allege are confusing -- especially
when looking at them without any context! -- but which in practice are not.
The whole "if" statement is:

        if (device_may_wakeup(&pdev->dev) 
                        && !clk_must_disable(atmel_port->clk))
                enable_irq_wake(port->irq);
        else {
                uart_suspend_port(&atmel_uart, port);
                atmel_port->suspended = 1;
        }

That's a lot more clear then the fragment you showed -- suspend, or
keep it active with wakeup enabled -- with the main confusion coming
from the serial stack itself:  the way clk_disable() gets hidden
deep inside uart_suspend_port().
 
If you're saying that should be rewritten, something like:

	if (!device_may_wakeup(...) || clk_must_disable(...)) {
		suspend port
	} else
		leave it active, with wakeup enabled

That might be true, but it's not a new issue or attributable to
this patch.  Likewise with (potentially) adding comments.

- Dave
