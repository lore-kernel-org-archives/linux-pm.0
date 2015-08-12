From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: linux-next: build failure after merge of the clk tree
Date: Wed, 12 Aug 2015 09:45:25 +0200
Message-ID: <CAMuHMdUQEVbyhnOBBgjKqBoFNc9FSCU68uoLg0XNWMFFxWAOdQ@mail.gmail.com>
References: <20150812171912.03110efc@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20150812171912.03110efc@canb.auug.org.au>
Sender: linux-next-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Mike Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Linux-Next <linux-next@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Aug 12, 2015 at 9:19 AM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> After merging the clk tree, today's linux-next build (x86_64 allmodconfig)
> failed like this:
>
> ERROR: "pm_genpd_init" [drivers/clk/qcom/clk-qcom.ko] undefined!
>
> Caused by commit
>
>   0c4172846b0b ("clk: qcom: Add support for GDSCs")
>
> I have used the clk tree from next-20150810 for today.

Missing EXPORT_SYMBOL_GPL(pm_genpd_init)?

However, having modular PM Domain drivers may cause unpleasant surprises...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
