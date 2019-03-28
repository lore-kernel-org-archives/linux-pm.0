From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RESEND PATCH] thermal: rcar_gen3_thermal: Fix init value of
 IRQCTL register
Date: Thu, 28 Mar 2019 09:05:27 +0100
Message-ID: <CAMuHMdW8cRARXmGbCeuAzuY4XPyqmrKTKO_NrRiWudK-kQ4M9A@mail.gmail.com>
References: <1553677398-7896-1-git-send-email-na-hoan@jinso.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1553677398-7896-1-git-send-email-na-hoan@jinso.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
To: Nguyen An Hoan <na-hoan@jinso.co.jp>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Zhang Rui <rui.zhang@intel.com>, Jiri Slaby <jslaby@suse.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Eduardo Valentin <edubezval@gmail.com>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, =?UTF-8?B?56iy5ZCJ?= <h-inayoshi@jinso.co.jp>, =?UTF-8?B?RHVuZ++8muS6uuOCvQ==?= <nv-dung@jinso.co.jp>, =?UTF-8?B?44Kr44Kq44O744O044Kh44Oz44O744OJ44Oz?= <cv-dong@jinso.co.jp>
List-Id: linux-pm@vger.kernel.org

On Wed, Mar 27, 2019 at 10:04 AM Nguyen An Hoan <na-hoan@jinso.co.jp> wrote:
> From: Hoan Nguyen An <na-hoan@jinso.co.jp>
>
> Fix setting value for IRQCTL register. We are setting the last 6 bits
> of (IRQCTL) to be 1 (0x3f), this is only suitable for H3ES1.*, according
> to Hardware manual values 1 are "setting prohibited" for Gen3.
>
> Signed-off-by: Hoan Nguyen An <na-hoan@jinso.co.jp>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
