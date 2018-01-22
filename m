From: Sean Wang <sean.wang@mediatek.com>
Subject: Re: [PATCH v1 2/4] cpufreq: mediatek: Add mediatek related projects
 into blacklist
Date: Mon, 22 Jan 2018 16:39:29 +0800
Message-ID: <1516610369.12197.20.camel@mtkswgap22>
References: <1512713278-17807-1-git-send-email-andrew-sh.cheng@mediatek.com>
         <1512713278-17807-3-git-send-email-andrew-sh.cheng@mediatek.com>
         <20171211075532.GB25177@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailgw01.mediatek.com ([210.61.82.183]:13248 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750928AbeAVIji (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jan 2018 03:39:38 -0500
In-Reply-To: <20171211075532.GB25177@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Andrew-sh Cheng <andrew-sh.cheng@mediatek.com>, mark.rutland@arm.com, khilman@baylibre.com, devicetree@vger.kernel.org, srv_heupstream@mediatek.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org, steven.liu@mediatek.com, Ryder.Lee@mediatek.com, Mark-MC.Lee@mediatek.com

Hi, Rafael and Viresh

Can you kindly guide me how to let the patch also be applied to 4.14 and
4.15 tree? Do I need to submit another patches for them?

These trees really need them. Otherwise, multi_v7_defconfig setup will
cause an occasional hang or unexpected behaviors on related boards as
[1] kernelci reported :-(

	Sean

[1]
https://kernelci.org/boot/mt7623n-bananapi-bpi-r2/


On Mon, 2017-12-11 at 13:25 +0530, Viresh Kumar wrote:
> On 08-12-17, 14:07, Andrew-sh Cheng wrote:
> > mediatek projects will use mediate-cpufreq.c as cpufreq driver,
> > instead of using cpufreq_dt.c
> > Add mediatek related projects into cpufreq-dt blacklist
> > 
> > Signed-off-by: Andrew-sh Cheng <andrew-sh.cheng@mediatek.com>
> > ---
> >  drivers/cpufreq/cpufreq-dt-platdev.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> > index ecc56e2..3b585e4 100644
> > --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> > +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> > @@ -108,6 +108,14 @@ static const struct of_device_id blacklist[] __initconst = {
> >  
> >  	{ .compatible = "marvell,armadaxp", },
> >  
> > +	{ .compatible = "mediatek,mt2701", },
> > +	{ .compatible = "mediatek,mt2712", },
> > +	{ .compatible = "mediatek,mt7622", },
> > +	{ .compatible = "mediatek,mt7623", },
> > +	{ .compatible = "mediatek,mt817x", },
> > +	{ .compatible = "mediatek,mt8173", },
> > +	{ .compatible = "mediatek,mt8176", },
> > +
> >  	{ .compatible = "nvidia,tegra124", },
> >  
> >  	{ .compatible = "st,stih407", },
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
