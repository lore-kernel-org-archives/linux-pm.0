From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH/RFC] gpio: rcar: Add Runtime PM handling for interrupts
Date: Tue, 16 Feb 2016 09:28:05 +0000
Message-ID: <56C2EBA5.4040903@nvidia.com>
References: <1455031183-18294-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1455031183-18294-1-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Geert,

On 09/02/16 15:19, Geert Uytterhoeven wrote:
> The R-Car GPIO driver handles Runtime PM for requested GPIOs only.
> 
> When using a GPIO purely as an interrupt source, no Runtime PM handling
> is done, and the GPIO module's clock may not be enabled.
> 
> To fix this:
>   - Add .irq_request_resources() and .irq_release_resources() callbacks
>     to handle Runtime PM when an interrupt is requested,

I know that when I was looking at runtime-pm support for IRQ chips
(which I have been meaning to get back too), the problem with
irq_request_resources() is that it is called from the context of a
spinlock (in __setup_irq()). You mentioned that you have not seen any
reports of might_sleep_if(), but have you ensured that it is actually
runtime resuming in your testing and you are not getting lucky?

An alternative for you might be to use the
irq_bus_lock/irq_bus_sync_unlock callbacks. See what Grygorii
implemented for OMAP in commit aca82d1cbb49 ("gpio: omap: move pm
runtime in irq_chip.irq_bus_lock/sync_unlock").

As I mentioned I do plan to get back to the series for adding runtime-pm
support for IRQ chips, in the next week or two.

Cheers
Jon

-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
