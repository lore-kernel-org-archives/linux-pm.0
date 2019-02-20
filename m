From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [PATCH 2/3] PM / devfreq: rockchip-dfi: remove unneeded semicolon
Date: Wed, 20 Feb 2019 22:57:49 +0900
Message-ID: <CAJ0PZbQORXei7y2RkSTF8SQJCya=d13x9n0DBYpNby-rSccUMg@mail.gmail.com>
References: <20190216151826.11584-1-tiny.windzz@gmail.com> <CGME20190216152000epcas1p216810769e13852c4b92896348657b6d6@epcas1p2.samsung.com>
 <20190216151826.11584-3-tiny.windzz@gmail.com> <47edbfaa-2c2d-04d3-cf24-8368f723c6fa@samsung.com>
Reply-To: myungjoo.ham@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <47edbfaa-2c2d-04d3-cf24-8368f723c6fa@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Yangtao Li <tiny.windzz@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Linux PM list <linux-pm@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-rockchip@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, linux-tegra@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, Feb 18, 2019 at 9:41 AM Chanwoo Choi <cw00.choi@samsung.com> wrote:
>
> Hi,
>
> On 19. 2. 17. 오전 12:18, Yangtao Li wrote:
> > The semicolon is unneeded, so remove it.
> >
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > ---
> >  drivers/devfreq/event/rockchip-dfi.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event/rockchip-dfi.c
> > index 22b113363ffc..fcbf76ebf55d 100644
> > --- a/drivers/devfreq/event/rockchip-dfi.c
> > +++ b/drivers/devfreq/event/rockchip-dfi.c
> > @@ -211,7 +211,7 @@ static int rockchip_dfi_probe(struct platform_device *pdev)
> >       if (IS_ERR(data->clk)) {
> >               dev_err(dev, "Cannot get the clk dmc_clk\n");
> >               return PTR_ERR(data->clk);
> > -     };
> > +     }
> >
> >       /* try to find the optional reference to the pmu syscon */
> >       node = of_parse_phandle(np, "rockchip,pmu", 0);
> >
>
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>

Merged. Thanks.

>
> --
> Best Regards,
> Chanwoo Choi
> Samsung Electronics



-- 
MyungJoo Ham, Ph.D.
S/W Center, Samsung Electronics
