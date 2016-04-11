From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH/RFC v2] gpio: rcar: Add Runtime PM handling for interrupts
Date: Mon, 11 Apr 2016 17:55:13 +0100
Message-ID: <570BD6F1.90709@arm.com>
References: <1455811590-15836-1-git-send-email-geert+renesas@glider.be>
 <CACRpkdZ2zzP5u4uJDzsnks7ywrp3ddBt+YfxthJ+5mT-ECYLpg@mail.gmail.com>
 <56C703AC.4040803@arm.com> <8178382.Z7YODHSRMC@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <8178382.Z7YODHSRMC@avalon>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Linus Walleij <linus.walleij@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Ulf Hansson <ulf.hansson@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Jon Hunter <jonathanh@nvidia.com>, Wolfram Sang <wsa@the-dreams.de>, Grygorii Strashko <grygorii.strashko@ti.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-renesas-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 11/04/16 17:26, Laurent Pinchart wrote:
> On Friday 19 Feb 2016 11:59:40 Marc Zyngier wrote:
>> On 19/02/16 09:18, Linus Walleij wrote:
>>> Top-quoting so everyone on the new To:-line gets the context.
>>>
>>> I definately need an indication from an irqchip maintainer like tglx or
>>> Marc Z before I merge this. Also, as in reply to the previous letter,
>>> coordinate efforts with Jon Hunters similar problem space.
>>
>> Seems pretty straightforward to me.
>>
>> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> 
> Too straightforward to be correct :-/
> 
> [    6.232681] BUG: sleeping function called from invalid context at /home/laurent/src/iob/renesas/linux/drivers/base/power/runtime.c:955
> [    6.244795] in_atomic(): 1, irqs_disabled(): 128, pid: 658, name: udevd
> [    6.251429] CPU: 3 PID: 658 Comm: udevd Tainted: P                4.6.0-rc3 #756
> [    6.258844] Hardware name: Generic R8A7790 (Flattened Device Tree)

[...]

Ah! That will teach me a lesson.

> The .irq_request_resources() handler is called with a spinlock held, it thus
> can't call the synchronous version of the PM runtime functions.

OK, so we're back to square one. Is that just a matter of calling the
non-synchronous version? My hunch is that it is not that simple...

Geert?

	M.
-- 
Jazz is not dead. It just smells funny...
