From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 6/6] dt-bindings: cpufreq: enhance Mediatek cpufreq
 dt-binding document
Date: Mon, 8 May 2017 12:36:46 +0530
Message-ID: <20170508070646.GE17010@vireshk-i7>
References: <1493997974-17699-1-git-send-email-sean.wang@mediatek.com>
 <1493997974-17699-7-git-send-email-sean.wang@mediatek.com>
 <20170508042010.GD17010@vireshk-i7>
 <1494226711.9662.22.camel@mtkswgap22>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1494226711.9662.22.camel@mtkswgap22>
Sender: linux-clk-owner@vger.kernel.org
To: Sean Wang <sean.wang@mediatek.com>
Cc: rjw@rjwysocki.net, robh+dt@kernel.org, matthias.bgg@gmail.com, mark.rutland@arm.com, mturquette@baylibre.com, jamesjj.liao@mediatek.com, p.zabel@pengutronix.de, shunli.wang@mediatek.com, erin.lo@mediatek.com, jdelvare@suse.de, devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 08-05-17, 14:58, Sean Wang wrote:
> > > +		opp@598000000 {
> > 
> > s/opp@/opp-/
> 
> I have referred to other dt-binding as examples where they also use opp@
> as the prefix word.  e.g bindings/cpufreq/ti-cpufreq.txt did it.
> 
> Or I misunderstand something you pointed out here ?

Its on the way:

https://marc.info/?l=linux-kernel&m=149266711829469&w=2

-- 
viresh
