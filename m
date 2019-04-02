From: Li Yang <leoyang.li@nxp.com>
Subject: Re: [PATCH v1 2/4] soc/fsl/guts: Add definition for LX2160A
Date: Tue, 2 Apr 2019 18:05:18 -0500
Message-ID: <CADRPPNTcY6fMJZDmsWzPzkn1hMzsoJh15-Gchepg_vJLxL=zcw@mail.gmail.com>
References: <1551132245-6089-1-git-send-email-vabhav.sharma@nxp.com> <1551132245-6089-3-git-send-email-vabhav.sharma@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1551132245-6089-3-git-send-email-vabhav.sharma@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vabhav Sharma <vabhav.sharma@nxp.com>
Cc: "sudeep.holla@arm.com" <sudeep.holla@arm.com>, "oss@buserror.net" <oss@buserror.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "mturquette@baylibre.com" <mturquette@baylibre.com>, "sboyd@kernel.org" <sboyd@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-kernel-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Feb 26, 2019 at 4:12 AM Vabhav Sharma <vabhav.sharma@nxp.com> wrote:
>
> Adding compatible string "lx2160a-dcfg" to
> initialize guts driver for lx2160 and SoC die
> attribute definition for LX2160A


Applied to branch next.  Thanks.

Regards,
Leo
>
> Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
> Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
> Acked-by: Li Yang <leoyang.li@nxp.com>
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
