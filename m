From: Li Yang <leoyang.li@nxp.com>
Subject: Re: [PATCH v5 2/6] soc/fsl/guts: Add definition for LX2160A
Date: Wed, 24 Oct 2018 16:39:35 -0500
Message-ID: <CADRPPNTwpQRu9fxt8PTVb6VoNJEFFrMHpCrRa5T7YEddSVnq-w@mail.gmail.com>
References: <1539536883-1928-1-git-send-email-vabhav.sharma@nxp.com> <1539536883-1928-3-git-send-email-vabhav.sharma@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1539536883-1928-3-git-send-email-vabhav.sharma@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vabhav Sharma <vabhav.sharma@nxp.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Scott Wood <oss@buserror.net>, lkml <linux-kernel@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, Michael Turquette <mturquette@baylibre.com>, sboyd@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-clk <linux-clk@vger.kernel.org>, linux-pm@vger.kernel.org, linux-kernel-owner@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundati>
List-Id: linux-pm@vger.kernel.org

On Mon, Oct 15, 2018 at 12:14 AM Vabhav Sharma <vabhav.sharma@nxp.com> wrote:
>
> Adding compatible string "lx2160a-dcfg" to
> initialize guts driver for lx2160 and SoC die
> attribute definition for LX2160A
>
> Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
> Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>

Acked-by: Li Yang <leoyang.li@nxp.com>

> ---
>  drivers/soc/fsl/guts.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/soc/fsl/guts.c b/drivers/soc/fsl/guts.c
> index 302e0c8..bcab1ee 100644
> --- a/drivers/soc/fsl/guts.c
> +++ b/drivers/soc/fsl/guts.c
> @@ -100,6 +100,11 @@ static const struct fsl_soc_die_attr fsl_soc_die[] = {
>           .svr          = 0x87000000,
>           .mask         = 0xfff70000,
>         },
> +       /* Die: LX2160A, SoC: LX2160A/LX2120A/LX2080A */
> +       { .die          = "LX2160A",
> +         .svr          = 0x87360000,
> +         .mask         = 0xff3f0000,
> +       },
>         { },
>  };
>
> @@ -222,6 +227,7 @@ static const struct of_device_id fsl_guts_of_match[] = {
>         { .compatible = "fsl,ls1088a-dcfg", },
>         { .compatible = "fsl,ls1012a-dcfg", },
>         { .compatible = "fsl,ls1046a-dcfg", },
> +       { .compatible = "fsl,lx2160a-dcfg", },
>         {}
>  };
>  MODULE_DEVICE_TABLE(of, fsl_guts_of_match);
> --
> 2.7.4
>
