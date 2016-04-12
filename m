From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH/RFC v2] gpio: rcar: Add Runtime PM handling for interrupts
Date: Tue, 12 Apr 2016 10:06:25 +0200
Message-ID: <CACRpkdaSrWnX4Ze-xgY+s1vNx9gD9DPPOz+Dnb_1RfrHFrJPEQ@mail.gmail.com>
References: <1455811590-15836-1-git-send-email-geert+renesas@glider.be>
	<CACRpkdZ2zzP5u4uJDzsnks7ywrp3ddBt+YfxthJ+5mT-ECYLpg@mail.gmail.com>
	<56C703AC.4040803@arm.com>
	<8178382.Z7YODHSRMC@avalon>
	<570BD6F1.90709@arm.com>
	<CAMuHMdXym9YXaDP+-xEU7o+NcKPUz5mgXnVkpk_QnQQppuab-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdXym9YXaDP+-xEU7o+NcKPUz5mgXnVkpk_QnQQppuab-A@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Thomas Gleixner <tglx@linutronix.de>, Ulf Hansson <ulf.hansson@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Jon Hunter <jonathanh@nvidia.com>, Wolfram Sang <wsa@the-dreams.de>, Grygorii Strashko <grygorii.strashko@ti.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-renesas-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, Apr 11, 2016 at 7:18 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:

> I'm afraid we'll have to keep gpio-rcar runtime-resumed all the time,
> i.e. revert both of
> b26a719bdb ("gpio: rcar: Add Runtime PM handling for interrupts")

I have reverted this for fixes.

> 65194cb174 ("gpio: rcar: Fine-grained Runtime PM support")

I reverted this too, with some manual intervention.

> until Jon Hunter's "genirq: Add runtime power management support for IRQ chips"
> (and perhaps a few more patches from his series) is applied.

Yup let's try to solve the big picture problem with Jon.

Yours,
Linus Walleij
