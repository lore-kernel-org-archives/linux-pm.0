From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH 0/7] ARM: shmobile: Add IRQC clock to device tree
Date: Mon, 27 Apr 2015 16:15:14 +0200
Message-ID: <CAMuHMdXOBPZe6JDccvq88asPJ4D-hA_HPOv0pnUhk9rVwuF6cg@mail.gmail.com>
References: <1426704961-27322-1-git-send-email-geert+renesas@glider.be>
	<20150319014328.GJ14051@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150319014328.GJ14051-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Cc: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi Simon,

On Thu, Mar 19, 2015 at 2:43 AM, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org> wrote:
> On Wed, Mar 18, 2015 at 07:55:54PM +0100, Geert Uytterhoeven wrote:
>> This patch series adds the IRQC clock to the device tree on SoCs that
>> have such a clock (r8a73a4 and r8a779x), and adds mininal runtime PM
>> support to the renesas-irqc driver, to make sure the clock is enabled
>> when needed by the external IRQ controller(s).
>> Before, the clock was assumed enabled by the bootloader or reset state.
>>
>> As usual when involving clocks, the DTS changes depend stricly on the
>> driver changes. Else the clock will be disabled as assumed unused,
>> breaking the boot.
>>
>> This was tested on r8a73a4/ape6evm and r8a7791/koelsch.
>
> I will defer the DTS changes until the irqchip changes, which I
> have reviewed, are accepted.

The irqchip changes are upstream. Do you want me to resend the DTS
changes, or will you apply the original patches?

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
