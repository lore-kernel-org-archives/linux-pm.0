From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 1/2] thermal: rcar: fix ENR register value
Date: Wed, 7 Jan 2015 09:26:31 +0100
Message-ID: <CAMuHMdX=cGJjqf79pQ_Snd6Oz1=WOXkHwka6EKQnxEvztDzyqw@mail.gmail.com>
References: <1420593191-3736-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<1420593191-3736-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1420593191-3736-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: linux-sh-owner@vger.kernel.org
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Linux PM list <linux-pm@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Jan 7, 2015 at 2:13 AM, Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> On R-Mobile APE6, since it has 3 thermal zones, ENR register
> has enable bits in bit 19-16, bit 11-8 and bit 3-0.
>
> However, on R-Car gen2, since it has 1 thermal zone, ENR register has
> enable bits in bit 3-0. (In other words, the write value should always
> be 0 for bit 31-4 of ENR register.)
>
> So, this patch fixes the ENR register value using I/O resource sets.
>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Thanks for the update!

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
