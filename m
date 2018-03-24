From: Sean Wang <sean.wang@mediatek.com>
Subject: Re: [PATCH v1 05/16] rtc: mediatek: add MT6323 support to RTC driver
Date: Sat, 24 Mar 2018 15:06:16 +0800
Message-ID: <1521875176.28226.25.camel@mtkswgap22>
References: <cover.1521794176.git.sean.wang@mediatek.com>
         <c49898db977a0b37363a35d3e3b297af891d7219.1521794177.git.sean.wang@mediatek.com>
         <20180323100156.GE3417@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180323100156.GE3417@piout.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, sre@kernel.org, lee.jones@linaro.org, a.zummo@towertech.it, eddie.huang@mediatek.com, devicetree@vger.kernel.org, linux-rtc@vger.kernel.org, linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, 2018-03-23 at 11:01 +0100, Alexandre Belloni wrote:
> Hi,
> 
> The subject line should be rtc: mt6397: (to differentiate with rtc-mt7622)
> 

Sure, I will change subject line into rtc: mt6397: along with the other
related patches.

> On 23/03/2018 at 17:15:02 +0800, sean.wang@mediatek.com wrote:
> > From: Sean Wang <sean.wang@mediatek.com>
> > 
> > Just to add MT6323 support to the existent RTC driver.
> > 
> > Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> > ---
> >  drivers/rtc/rtc-mt6397.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/rtc/rtc-mt6397.c b/drivers/rtc/rtc-mt6397.c
> > index 385f830..0df7ccd 100644
> > --- a/drivers/rtc/rtc-mt6397.c
> > +++ b/drivers/rtc/rtc-mt6397.c
> > @@ -398,6 +398,7 @@ static SIMPLE_DEV_PM_OPS(mt6397_pm_ops, mt6397_rtc_suspend,
> >  			mt6397_rtc_resume);
> >  
> >  static const struct of_device_id mt6397_rtc_of_match[] = {
> > +	{ .compatible = "mediatek,mt6323-rtc", },
> >  	{ .compatible = "mediatek,mt6397-rtc", },
> >  	{ }
> >  };
> > -- 
> > 2.7.4
> > 
> 
