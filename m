From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] Thermal: introduce INT3406 thermal driver
Date: Mon, 8 Dec 2014 12:20:41 +0100
Message-ID: <CAMuHMdW8Yap=VrHaEs-oKbVtRSUSb87qf9JJph7aG-MPuv4f_w@mail.gmail.com>
References: <CA+r1ZhhoskOXaRSmcrnbdgapi-FsaKf+dnPHTXGkDvkYbvwQ8Q@mail.gmail.com>
	<543F88BE.4090307@intel.com>
	<20141017070620.GA1538@aaronlu.sh.intel.com>
	<20141017072236.GA12504@aaronlu.sh.intel.com>
	<544F33AF.1000704@intel.com>
	<20141107191127.GB27438@developer>
	<1417350176.27484.10.camel@rzhang1-toshiba>
	<547D59D2.8010906@intel.com>
	<1418009702.19126.14.camel@rzhang1-toshiba>
	<CAMuHMdWHn+BcpPjr7x+Y1aRwUgBP54mH=4XpjB1VOd7T76-kjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdWHn+BcpPjr7x+Y1aRwUgBP54mH=4XpjB1VOd7T76-kjw@mail.gmail.com>
Sender: linux-next-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Aaron Lu <aaron.lu@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Jim Davis <jim.epost@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next <linux-next@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Dec 8, 2014 at 11:55 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Unfortunately drivers/thermal/int340x_thermal/Kconfig was missing
> from the patch, hence "make oldconfig" now fails miserably with
>
> drivers/thermal/Kconfig:265: can't open file
> "drivers/thermal/int340x_thermal/Kconfig"

I've lifted the missing file from "[PATCH v3] Thermal: int3406_thermal:
solve the dependency build error" (https://lkml.org/lkml/2014/10/17/38).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
