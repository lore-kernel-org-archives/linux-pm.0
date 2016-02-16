From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH/RFC v2 05/11] soc: renesas: rcar: Handle clock domain
 devices in SYSC PM domains
Date: Tue, 16 Feb 2016 08:30:03 +0100
Message-ID: <CAMuHMdUs1cJMZaO8-UkOcBYTy1nd9oR3kLo4q3Z4wxU_t4SDbw@mail.gmail.com>
References: <1455571020-18968-1-git-send-email-geert+renesas@glider.be>
	<1455571020-18968-6-git-send-email-geert+renesas@glider.be>
	<2087210.c20JsV3rp3@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <2087210.c20JsV3rp3@avalon>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-renesas-soc@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux PM list <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Laurent,

On Mon, Feb 15, 2016 at 11:08 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Monday 15 February 2016 22:16:54 Geert Uytterhoeven wrote:
>> R-Car H3 contains some hardware modules (e.g. VSP and FCP_V) that are
>> not only located in a power area controlled by the SYSC system
>> controller, but that are also part of the generic CPG/MSSR clock domain.
>> Make sure both are handled by enabling module clock PM when the device
>> for such a hardware module is attached to the SYSC PM Domain.
>
> Can't we specify both power domains in the DT power-domains attribute instead
> ?

While the DT property is called "power-domains" (plural), only the first entry
is parsed by genpd_dev_pm_attach(). Which makes sense for power areas
(if there are multiple, they are nested), but indeed can cause problems when
mixed with clock domains.

For R-Mobile, I fixed it in a similar way.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
