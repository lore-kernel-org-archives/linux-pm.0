From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: RE: Re: [PATCH v1] PM / devfreq: exynos-ppmu : Handle return value
 of clk_prepare_enable
Date: Wed, 24 May 2017 01:30:36 +0000
Message-ID: <20170524013036epcms1p3f5ced11e6ebe5664ce70718dedcf8de1@epcms1p3>
References: <592403E7.8060906@samsung.com>
        <1495191364-16015-1-git-send-email-arvind.yadav.cs@gmail.com>
        <CGME20170519105745epcas5p29a5cbb259cd15138d7220f34e130e00a@epcms1p3>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <592403E7.8060906@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, Arvind Yadav <arvind.yadav.cs@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, "krzk@kernel.org" <krzk@kernel.org>, "kgene@kernel.org" <kgene@kernel.org>, "javier@osg.samsung.com" <javier@osg.samsung.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

> On 2017년 05월 19일 19:56, Arvind Yadav wrote:

> > clk_prepare_enable() can fail here and we must check its return value.

> > 

> > Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

> > ---

> >  drivers/devfreq/event/exynos-ppmu.c | 6 +++++-

> >  1 file changed, 5 insertions(+), 1 deletion(-)

> > 

> > diff --git a/drivers/devfreq/event/exynos-ppmu.c b/drivers/devfreq/event/exynos-ppmu.c

> > index 9b73509..8f6537a 100644

> > --- a/drivers/devfreq/event/exynos-ppmu.c

> > +++ b/drivers/devfreq/event/exynos-ppmu.c

> > @@ -648,7 +648,11 @@ static int exynos_ppmu_probe(struct platform_device *pdev)

> >  			dev_name(&pdev->dev), desc[i].name);

> >  	}

> >  

> > -	clk_prepare_enable(info->ppmu.clk);

> > +	ret = clk_prepare_enable(info->ppmu.clk);

> > +	if (ret) {

> > +		dev_err(&pdev->dev, "failed to prepare ppmu clock\n");

> > +		return ret;

> > +	}

> 

> You're right. But, actually, some ppmu device-tree node doesn't include

> the clock information because exynos clk driver don't support the

> clock for some ppmu devices. Until now, the clock of ppmu devices

> are default on state.



If it does not include the clock information, info->ppmu.clk is NULL,

which makes ret == NULL, so this should be ok.

(Line 593 of this file does that.)





Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>

(Applied to next-rc in devfreq tree)



(same applies to exynos-nocp commit as well)





Cheers,

MyungJoo
