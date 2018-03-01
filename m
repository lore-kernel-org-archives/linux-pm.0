From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH v3 0/3] renesas: irqchip: Use wakeup_path i.s.o. explicit
 clock handling
Date: Thu, 1 Mar 2018 16:12:31 +0000
Message-ID: <70c3eaa7-f103-33b0-26a0-c0c1b1b9608a@arm.com>
References: <1518443713-1835-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1518443713-1835-1-git-send-email-geert+renesas@glider.be>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Linus Walleij <linus.walleij@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 12/02/18 13:55, Geert Uytterhoeven wrote:
> 	Hi all,
> 
> If an interrupt controller in a Renesas ARM SoC is part of a Clock
> Domain, and it is part of the wakeup path, it must be kept active during
> system suspend.
> 
> Currently this is handled in all interrupt controller drivers by
> explicitly increasing the use count of the module clock when the device
> is part of the wakeup path.  However, this explicit clock handling is
> merely a workaround for a failure to properly communicate wakeup
> information to the device core.
> 
> Hence this series fixes the affected drivers by setting the devices'
> power.wakeup_path fields instead, to indicate they are part of the
> wakeup path.  Depending on the PM Domain's active_wakeup configuration,
> the genpd core code will keep the device enabled (and the clock running)
> during system suspend when needed.
> 
> Target trees:
>   - Patches 1 and 2 are meant for the irqchip tree,
Patches queued for 4.17.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
