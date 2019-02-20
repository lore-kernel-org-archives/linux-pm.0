From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [PATCH 3/3] PM / devfreq: tegra: remove unneeded variable
Date: Wed, 20 Feb 2019 23:25:48 +0900
Message-ID: <CAJ0PZbQ9sP5Kfkzn-kFQ2NCdxEk1fRB9WqrE5XD50K9F31ymag@mail.gmail.com>
References: <20190216151826.11584-1-tiny.windzz@gmail.com> <CGME20190216151918epcas1p25c2971b063cc66981fda6a67a8276585@epcas1p2.samsung.com>
 <20190216151826.11584-4-tiny.windzz@gmail.com> <7fe8f9ba-ffcc-55ed-38b0-f37538257c1b@samsung.com>
 <abb56481-0cc7-3d31-2dae-ba602a423811@nvidia.com>
Reply-To: myungjoo.ham@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <abb56481-0cc7-3d31-2dae-ba602a423811@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, Yangtao Li <tiny.windzz@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Thierry Reding <thierry.reding@gmail.com>, Linux PM list <linux-pm@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-rockchip@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, linux-tegra@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, Feb 18, 2019 at 6:58 PM Jon Hunter <jonathanh@nvidia.com> wrote:
>
>
> On 18/02/2019 00:38, Chanwoo Choi wrote:
> > On 19. 2. 17. 오전 12:18, Yangtao Li wrote:
> >> This variable is not used after initialization, so
> >> remove it. And in order to unify the code style,
> >> move the location where the dev_get_drvdata is called
> >> by the way.
> >>
> >> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> >> ---
> >>  drivers/devfreq/tegra-devfreq.c | 7 ++-----
> >>  1 file changed, 2 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
> >> index c59d2eee5d30..c89ba7b834ff 100644
> >> --- a/drivers/devfreq/tegra-devfreq.c
> >> +++ b/drivers/devfreq/tegra-devfreq.c
> >> @@ -573,10 +573,7 @@ static int tegra_governor_get_target(struct devfreq *devfreq,
> >>  static int tegra_governor_event_handler(struct devfreq *devfreq,
> >>                                      unsigned int event, void *data)
> >>  {
> >> -    struct tegra_devfreq *tegra;
> >> -    int ret = 0;
> >> -
> >> -    tegra = dev_get_drvdata(devfreq->dev.parent);
> >> +    struct tegra_devfreq *tegra = dev_get_drvdata(devfreq->dev.parent);
> >>
> >>      switch (event) {
> >>      case DEVFREQ_GOV_START:
> >> @@ -600,7 +597,7 @@ static int tegra_governor_event_handler(struct devfreq *devfreq,
> >>              break;
> >>      }
> >>
> >> -    return ret;
> >> +    return 0;
> >>  }
> >>
> >>  static struct devfreq_governor tegra_devfreq_governor = {
> >>
> >
> > Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> >
>
> Acked-by: Jon Hunter <jonathanh@nvidia.com>
>
> Thanks!
> Jon

Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>

Merged. Thanks!

>
> --
> nvpublic



-- 
MyungJoo Ham, Ph.D.
S/W Center, Samsung Electronics
