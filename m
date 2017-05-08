From: Sean Wang <sean.wang@mediatek.com>
Subject: Re: [PATCH 6/6] dt-bindings: cpufreq: enhance Mediatek cpufreq
 dt-binding document
Date: Mon, 8 May 2017 14:58:31 +0800
Message-ID: <1494226711.9662.22.camel@mtkswgap22>
References: <1493997974-17699-1-git-send-email-sean.wang@mediatek.com>
         <1493997974-17699-7-git-send-email-sean.wang@mediatek.com>
         <20170508042010.GD17010@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20170508042010.GD17010@vireshk-i7>
Sender: linux-clk-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@rjwysocki.net, robh+dt@kernel.org, matthias.bgg@gmail.com, mark.rutland@arm.com, mturquette@baylibre.com, jamesjj.liao@mediatek.com, p.zabel@pengutronix.de, shunli.wang@mediatek.com, erin.lo@mediatek.com, jdelvare@suse.de, devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, 2017-05-08 at 09:50 +0530, Viresh Kumar wrote:
> On 05-05-17, 23:26, sean.wang@mediatek.com wrote:
> > From: Sean Wang <sean.wang@mediatek.com>
> > 
> > Update binding document to reflect the lastest driver logic and
> 
> The bindings don't follow the drivers but its the other way around. Don't
> mention anything about the drivers in the bindings patches.


Okay. I made a mistake: DT bindings shouldn't reference drivers and they
are OS-agnostic. I will correct them with the principle. 

Thanks for your patience and guidance 


> > add more examples guiding people how to use Mediatek cpufreq driver.
> > 
> > Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> > ---
> >  .../bindings/cpufreq/cpufreq-mediatek.txt          | 170 ++++++++++++++++++++-
> >  1 file changed, 167 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt
> > index 52b457c..0703927 100644
> > --- a/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt
> > +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt
> > @@ -1,4 +1,5 @@
> > -Device Tree Clock bindins for CPU DVFS of Mediatek MT8173 SoC
> > +Binding for Mediatek's CPUFreq driver
> > +=====================================
> >  
> >  Required properties:
> >  - clocks: A list of phandle + clock-specifier pairs for the clocks listed in clock names.
> > @@ -9,6 +10,8 @@ Required properties:
> >  			  transition and not stable yet.
> >  	Please refer to Documentation/devicetree/bindings/clk/clock-bindings.txt for
> >  	generic clock consumer properties.
> > +- operating-points-v2: Pleaser refer to Documentation/devicetree/bindings/opp/opp.txt
> > +	for detail.
> >  - proc-supply: Regulator for Vproc of CPU cluster.
> >  
> >  Optional properties:
> > @@ -17,9 +20,166 @@ Optional properties:
> >  	       Vsram to fit SoC specific needs. When absent, the voltage scaling
> >  	       flow is handled by hardware, hence no software "voltage tracking" is
> >  	       needed.
> > +- #cooling-cells:
> > +- cooling-min-level:
> > +- cooling-max-level:
> > +	Please refer to Documentation/devicetree/bindings/thermal/thermal.txt
> > +	for detail.
> > +
> > +Example 1 (MT7623 SoC):
> > +
> > +	cpu_opp_table: opp_table {
> > +		compatible = "operating-points-v2";
> > +		opp-shared;
> > +
> > +		opp@598000000 {
> 
> s/opp@/opp-/

I have referred to other dt-binding as examples where they also use opp@
as the prefix word.  e.g bindings/cpufreq/ti-cpufreq.txt did it.

Or I misunderstand something you pointed out here ?












> 


