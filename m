From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH/RFC 0/6] staging: board: armadillo800eva: Board staging
 for sh_mobile_lcdc_fb
Date: Fri, 3 Apr 2015 21:35:22 +0200
Message-ID: <CAMuHMdU0tPE7Qy7YX38mvXx5KkwBmM0PNKZxa3p57M384NCr2A@mail.gmail.com>
References: <1428064923-24950-1-git-send-email-geert+renesas@glider.be>
	<3984477.UtBUTfcozK@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <3984477.UtBUTfcozK@avalon>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, driverdevel <devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi Laurent,

On Fri, Apr 3, 2015 at 6:24 PM, Laurent Pinchart
<laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org> wrote:
> On Friday 03 April 2015 14:41:57 Geert Uytterhoeven wrote:
>> This RFC patch series adds board staging support for r8a7740/armadillo.
>> For now this supports only the frame buffer device for the on-board LCD.
>
> I've started adding DT support to the shmob-lcdc driver, but I have no board
> to test it on. My Armadillo is gone, and KZM9G is unusable with DT + LCDC at
> the moment as the LCDC interrupt is connected to the legacy interrupt
> controller only, not the GIC. Would you be able to test a patch set ? And if

Sure, I can test your patches on Armadillo.

> you want to implement support for the KZM9G legacy interrupt controller in DT,
> please go for it :-)

Do we need the LCDC interrupt? ;-)

Anyway, the display of my kzm9g is broken, so I never had the joy of
seeing its marvellous graphics.

>>       - sh-mobile-hdmi/sh_mobile_lcdc_fb.1 (this seems to be broken in
>>       -legacy?)
>
> HDMI is broken in legacy, we can thus drop it.

In addition, clk-r8a7740 lacks support for the non-standard register layout of
HDMICKCR.

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
