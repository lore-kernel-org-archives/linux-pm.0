From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: Re: [PATCH v5 0/2] add UniPhier thermal support
Date: Tue, 25 Jul 2017 18:11:08 +0900
Message-ID: <20170725181108.7EA5.4A936039@socionext.com>
References: <CAK7LNARchNY8wA56+spLCUh99tsGpPQ9VuYc5ymnOL3cu0bd8g@mail.gmail.com> <CAA93ih2rYfMasZGzZ6K4nUWJx64KmmW8VWx8MZCscSag2z0-5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAA93ih2rYfMasZGzZ6K4nUWJx64KmmW8VWx8MZCscSag2z0-5w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masami Hiramatsu <masami.hiramatsu@linaro.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, rui.zhang@intel.com, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jassi Brar <jaswinder.singh@linaro.org>
List-Id: linux-pm@vger.kernel.org

Hello,

On Fri, 21 Jul 2017 22:34:49 +0900 <masami.hiramatsu@linaro.org> wrote:

> Hello,
> 
> 2017-07-21 22:24 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> > 2017-07-21 20:21 GMT+09:00 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>:
> >> This series adds support for CPU temperature monitor modules implemented
> >> on UniPhier LD20 and PXs2 SoCs. This driver supports temperature monitoring
> >> and alert function on the module.
> >>
> >> Changes in v4:
> >> - fix warnings from sparse by replacing u32 with __be32
> >
> > Nit.
> >
> > Your subject prefix indicates this patch is v5.
> >
> > Do you mean "Changes in v5" or "Changes since v4" ?
> 
> I've checked all previous series and it seems to mean "Changes from vN".

Surely my description is misleading.
I'll fix it next.

> Thanks,
> 
> >
> >
> >
> >
> >
> >
> >> Changes in v3:
> >> - remove TMOD_MASK and use TMOD_WIDTH representing the bit width of TMOD
> >>
> >> Changes in v2:
> >> - add nsleep after starting and stopping PVT
> >> - replace temperature calculation with sign_extend32()
> >>
> >> Changes in v1:
> >> - separate dts from this patchset as another patchset
> >> - remove 'reg' description on the dt-bindings document
> >> - fix the order of calling initialization functions
> >> - replace mask bits to use GENMASK
> >> - fix calculation of temperature because of not considering a negative value
> >> - use devm_request_threaded_irq() instead of devm_request_irq() and
> >>   separate a thread function from the interrupt handler
> >> - add dependency to Kconfig
> >> - set 120C to CRITICAL_TEMP_LIMIT as maximum temperature
> >> - shrink each line of parameters to save the number of lines
> >> - improve some comments and copyright description
> >>
> >> Kunihiko Hayashi (2):
> >>   dt-bindings: thermal: add binding documentation for UniPhier thermal
> >>     monitor
> >>   thermal: uniphier: add UniPhier thermal driver
> >>
> >>  .../bindings/thermal/uniphier-thermal.txt          |  64 ++++
> >>  drivers/thermal/Kconfig                            |   8 +
> >>  drivers/thermal/Makefile                           |   1 +
> >>  drivers/thermal/uniphier_thermal.c                 | 386 +++++++++++++++++++++
> >>  4 files changed, 459 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/thermal/uniphier-thermal.txt
> >>  create mode 100644 drivers/thermal/uniphier_thermal.c
> >>
> >> --
> >> 2.7.4
> >>
> >
> >
> >
> > --
> > Best Regards
> > Masahiro Yamada
> 
> 
> 
> -- 
> Masami Hiramatsu

--
Best Regards,
Kunihiko Hayashi
