From: Sean Wang <sean.wang@mediatek.com>
Subject: Re: [PATCH v1 06/16] rtc: mediatek: remove unnecessary parentheses
Date: Sun, 25 Mar 2018 03:21:58 +0800
Message-ID: <1521919318.31197.0.camel@mtkswgap22>
References: <cover.1521794176.git.sean.wang@mediatek.com>
         <92d07e90f43899981a82fbc684c3d15aaecaf591.1521794177.git.sean.wang@mediatek.com>
         <20180323102123.GG3417@piout.net> <1521875652.28226.29.camel@mtkswgap22>
         <20180324185330.GO3417@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180324185330.GO3417@piout.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, sre@kernel.org, lee.jones@linaro.org, a.zummo@towertech.it, eddie.huang@mediatek.com, devicetree@vger.kernel.org, linux-rtc@vger.kernel.org, linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sat, 2018-03-24 at 19:53 +0100, Alexandre Belloni wrote:
> On 24/03/2018 at 15:14:12 +0800, Sean Wang wrote:
> > On Fri, 2018-03-23 at 11:21 +0100, Alexandre Belloni wrote:
> > > On 23/03/2018 at 17:15:03 +0800, sean.wang@mediatek.com wrote:
> > > > From: Sean Wang <sean.wang@mediatek.com>
> > > > 
> > > > Remove unnecessary parentheses due to explicit C operator precedence.
> > > > 
> > > > Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> > > > ---
> > > >  drivers/rtc/rtc-mt6397.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/rtc/rtc-mt6397.c b/drivers/rtc/rtc-mt6397.c
> > > > index 0df7ccd..4411c08 100644
> > > > --- a/drivers/rtc/rtc-mt6397.c
> > > > +++ b/drivers/rtc/rtc-mt6397.c
> > > > @@ -106,7 +106,7 @@ static irqreturn_t mtk_rtc_irq_handler_thread(int irq, void *data)
> > > >  	int ret;
> > > >  
> > > >  	ret = regmap_read(rtc->regmap, rtc->addr_base + RTC_IRQ_STA, &irqsta);
> > > > -	if ((ret >= 0) && (irqsta & RTC_IRQ_STA_AL)) {
> > > > +	if (ret >= 0 && irqsta & RTC_IRQ_STA_AL) {
> > > 
> > > I don't think this makes the code particularly clearer.
> > > 
> > 
> > But it is still a one of check items in checkpatch
> > 
> > CHECK:UNNECESSARY_PARENTHESES: Unnecessary parentheses around 'ret >= 0'
> > #126: FILE: drivers/rtc/rtc-xxx.c:109:
> > +       if ((ret >= 0) && (irqsta & RTC_IRQ_STA_AL)) {
> > 
> > 
> > or we still want to keep it in parentheses around here?
> > 
> 
> Yeah, this is a matter of taste, I would keep the parentheses.

okay, lets keep the parentheses

> 
> 
