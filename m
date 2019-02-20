From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [PATCH 1/3] PM / devfreq: rk3399_dmc: remove unneeded semicolon
Date: Wed, 20 Feb 2019 22:55:59 +0900
Message-ID: <CAJ0PZbQ808ztVzWyq_cTAD5o276y-t+0Lih2a5jOv05585VTEg@mail.gmail.com>
References: <20190216151826.11584-1-tiny.windzz@gmail.com> <CGME20190216152219epcas4p3ec89de91f9e158da7cc7cfeefb6e113e@epcas4p3.samsung.com>
 <20190216151826.11584-2-tiny.windzz@gmail.com> <9e7f9e6d-3b53-35f2-e945-13895385af31@samsung.com>
Reply-To: myungjoo.ham@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9e7f9e6d-3b53-35f2-e945-13895385af31@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Yangtao Li <tiny.windzz@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Linux PM list <linux-pm@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-rockchip@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, linux-tegra@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, Feb 18, 2019 at 10:09 AM Chanwoo Choi <cw00.choi@samsung.com> wrote:
>
> Hi,
>
> On 19. 2. 17. 오전 12:18, Yangtao Li wrote:
> > The semicolon is unneeded, so remove it.
> >
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > ---
> >  drivers/devfreq/rk3399_dmc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
> > index e795ad2b3f6b..a228dad2bee4 100644
> > --- a/drivers/devfreq/rk3399_dmc.c
> > +++ b/drivers/devfreq/rk3399_dmc.c
> > @@ -322,7 +322,7 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
> >
> >               dev_err(dev, "Cannot get the clk dmc_clk\n");
> >               return PTR_ERR(data->dmc_clk);
> > -     };
> > +     }
> >
> >       data->edev = devfreq_event_get_edev_by_phandle(dev, 0);
> >       if (IS_ERR(data->edev))
> >
>
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>

Merged.

>
> --
> Best Regards,
> Chanwoo Choi
> Samsung Electronics


-- 
MyungJoo Ham, Ph.D.
S/W Center, Samsung Electronics
