From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: Re: [PATCH v4 2/2] thermal: uniphier: add UniPhier thermal driver
Date: Fri, 21 Jul 2017 20:15:03 +0900
Message-ID: <20170721201503.BC76.4A936039@socionext.com>
References: <CAK7LNATDxacQXyJr=4b7zaWkX1Y6S8DMHEkQxECvmETemfGRfA@mail.gmail.com> <CAK7LNATDY4SdGHH1_K2GhFcsXMuG_9vGECWNtNfBJ_D=AO785w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK7LNATDY4SdGHH1_K2GhFcsXMuG_9vGECWNtNfBJ_D=AO785w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: rui.zhang@intel.com, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Masami Hiramatsu <masami.hiramatsu@linaro.org>, Jassi Brar <jaswinder.singh@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 21 Jul 2017 02:09:18 +0900 <yamada.masahiro@socionext.com> wrote:

> 2017-07-21 1:53 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> > 2017-07-21 1:08 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> >> 2017-07-07 10:54 GMT+09:00 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>:
> >>> Add a thermal driver for on-chip PVT (Process, Voltage and Temperature)
> >>> monitoring unit implemented on UniPhier SoCs. This driver supports
> >>> temperature monitoring and alert function.
> >>>
> >>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> >>
> >>
> >> Sparse reports several warnings.
> >>
> >>
> >>   CHECK   drivers/thermal/uniphier_thermal.c
> >> drivers/thermal/uniphier_thermal.c:276:52: warning: incorrect type in
> >> argument 1 (different base types)
> >> drivers/thermal/uniphier_thermal.c:276:52:    expected restricted
> >> __be32 const [usertype] *cell
> >> drivers/thermal/uniphier_thermal.c:276:52:    got unsigned int const
> >> [usertype] *[assigned] calib
> >> drivers/thermal/uniphier_thermal.c:277:58: warning: incorrect type in
> >> argument 1 (different base types)
> >> drivers/thermal/uniphier_thermal.c:277:58:    expected restricted
> >> __be32 const [usertype] *cell
> >> drivers/thermal/uniphier_thermal.c:277:58:    got unsigned int const
> >> [usertype] *
> >> drivers/thermal/uniphier_thermal.c:136:9: warning: cast truncates bits
> >> from constant value (fffffffff becomes ffffffff)
> >> drivers/thermal/uniphier_thermal.c:141:9: warning: cast truncates bits
> >> from constant value (7ffffffff becomes ffffffff)
> >> drivers/thermal/uniphier_thermal.c:153:9: warning: cast truncates bits
> >> from constant value (ffffffffff0001 becomes ffff0001)
> >> drivers/thermal/uniphier_thermal.c:170:9: warning: cast truncates bits
> >> from constant value (7ffffffffff becomes ffffffff)
> >> drivers/thermal/uniphier_thermal.c:185:9: warning: cast truncates bits
> >> from constant value (7ffffffffff becomes ffffffff)
> >>
> >
> > Hmm.
> > The endian mismatch can be fixed by replacing u32 with __be32.
> >
> > I can not get the truncates bits warnings.
> > Why sparse complains about this...
> 
> My bad - I was cross-compiling with ARCH=arm, so I think that's why.
> 
> I think the incorrect type should be fixed.  (u32 -> __be32)

Thanks for your pointing out.
I'll fix it next.

Best Regards,
Kunihiko Hayashi
