From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] thermal: rcar: Use ARCH_RENESAS
Date: Wed, 2 Mar 2016 10:32:03 +0100
Message-ID: <CAMuHMdWzuUH_cyzZ=kvJPGmbZ-cUWvUy6MPvkDLfDc3x=ReDMg@mail.gmail.com>
References: <1456884266-25522-1-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1456884266-25522-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Magnus Damm <magnus.damm@gmail.com>, Linux PM list <linux-pm@vger.kernel.org>, linux-renesas-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, Mar 2, 2016 at 3:04 AM, Simon Horman <horms+renesas@verge.net.au> wrote:
> Make use of ARCH_RENESAS in place of ARCH_SHMOBILE.
>
> This is part of an ongoing process to migrate from ARCH_SHMOBILE to
> ARCH_RENESAS the motivation for which being that RENESAS seems to be a more
> appropriate name than SHMOBILE for the majority of Renesas ARM based SoCs.
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
