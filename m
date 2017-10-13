From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH/RFC 3/5] mfd: bd9571mwv: Allow DDR Backup Power register access
Date: Fri, 13 Oct 2017 11:06:13 +0200
Message-ID: <CAMuHMdVZiaq40r0Su01n9C7oXR7i_QWmNhZtY7Udhy9gdYHVRA@mail.gmail.com>
References: <1507649178-31473-1-git-send-email-geert+renesas@glider.be>
 <1507649178-31473-4-git-send-email-geert+renesas@glider.be> <20171013085851.ljvgmyd6ei2tv5fw@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171013085851.ljvgmyd6ei2tv5fw@dell>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Marek Vasut <marek.vasut+renesas@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Lee,

On Fri, Oct 13, 2017 at 10:58 AM, Lee Jones <lee.jones@linaro.org> wrote:
> On Tue, 10 Oct 2017, Geert Uytterhoeven wrote:
>
>> Enable read/write access to the BD9571MWV_BKUP_MODE_CNT register, which
>> is a.o. used to configure DDR Backup Power.
>
> a.o.?  That's a new one on me.

among(st) others

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
