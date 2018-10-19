From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 05/15] Platform: OLPC: Move OLPC config symbol out of x86 tree
Date: Fri, 19 Oct 2018 16:09:17 +0300
Message-ID: <CAHp75VdNJwWbKfbsMQ2ZVmC=H3yPaLgxnE4Kstff9CYeopZJ7A@mail.gmail.com>
References: <20181010172300.317643-1-lkundrak@v3.sk> <20181010172300.317643-6-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181010172300.317643-6-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
To: Lubomir Rintel <lkundrak@v3.sk>
Cc: Mark Brown <broonie@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, quozl@laptop.org, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Daniel Mack <daniel@zonque.org>, Robert Jarzmik <robert.jarzmik@free.fr>, linux-spi <linux-spi@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, devel@driverdev.osuosl.or
List-Id: linux-pm@vger.kernel.org

On Wed, Oct 10, 2018 at 8:23 PM Lubomir Rintel <lkundrak@v3.sk> wrote:
>
> There are ARM OLPC machines that use mostly the same drivers, including
> EC infrastructure, DCON and Battery.
>
> While at that, fix Kconfig to allow building this as a module.


> -       depends on MOUSE_PS2 && OLPC
> +       depends on MOUSE_PS2 && X86 && OLPC


> -       depends on OLPC && FB
> +       depends on X86 && OLPC && FB

Looking to this I would rather introduce an idiom

depends on OLPC && X86

on the opposite you may do similar for ARM

depends on OLPC && ARM // or ARM64 or whatever it's called

thus, above would look like

depends on MOUSE_PS2
depends on OLPC && X86

and

depends on FB
depends on OLPC && X86

respectively.

-- 
With Best Regards,
Andy Shevchenko
