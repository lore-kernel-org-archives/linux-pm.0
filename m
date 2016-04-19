From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Build regressions/improvements in v4.6-rc4
Date: Tue, 19 Apr 2016 08:57:37 +0200
Message-ID: <CAMuHMdUqJ0dj25oXhC4MgqSk0SaOHvT262ew+sBs7eV2SCwyUA@mail.gmail.com>
References: <1461048813-28712-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <1461048813-28712-1-git-send-email-geert@linux-m68k.org>
Sender: linux-parisc-owner@vger.kernel.org
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Parisc List <linux-parisc@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Apr 19, 2016 at 8:53 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Below is the list of build error/warning regressions/improvements in
> v4.6-rc4[1] compared to v4.5[2].
>
> Summarized:
>   - build errors: +11/-7
>   - build warnings: +16376/-165

Sorry for the delay, initially I didn't realize why my first report didn't make
it to the list. It was too big, due to 16211 warnings in parisc-allmodconfig
about "-ffunction-sections disabled; it makes profiling impossible [enabled by
default]".

> JFYI, when comparing v4.6-rc4[1] to v4.6-rc3[3], the summaries are:
>   - build errors: +9/-9

  + /home/kisskb/slave/src/arch/powerpc/kernel/pci_dn.c: error:
'struct pci_dn' has no member named 'edev':  => 272:8
  + /home/kisskb/slave/src/arch/powerpc/kernel/pci_dn.c: error:
dereferencing pointer to incomplete type:  => 215:7
  + /home/kisskb/slave/src/arch/powerpc/kernel/pci_dn.c: error:
implicit declaration of function 'eeh_dev_init'
[-Werror=implicit-function-declaration]:  => 212:3

powerpc-randconfig

  + /home/kisskb/slave/src/drivers/thermal/mtk_thermal.c: error:
implicit declaration of function 'device_reset'
[-Werror=implicit-function-declaration]:  => 560:2

x86_64-randconfig (patch available)

> [1] http://kisskb.ellerman.id.au/kisskb/head/10194/ (all 262 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/10162/ (all 262 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
