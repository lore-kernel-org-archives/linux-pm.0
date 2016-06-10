From: Andy Gross <andy.gross@linaro.org>
Subject: Re: [PATCH 3/5] arm64: dts: msm8916: Add spc compat tag
Date: Fri, 10 Jun 2016 11:12:34 -0500
Message-ID: <20160610161234.GO13357@hector.attlocal.net>
References: <1463634020-17252-1-git-send-email-andy.gross@linaro.org>
 <1463634020-17252-4-git-send-email-andy.gross@linaro.org>
 <20160610154857.GA6430@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160610154857.GA6430@leverpostej>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, stanimir.varbanov@linaro.org, lorenzo.pieralisi@arm.com
List-Id: linux-pm@vger.kernel.org

On Fri, Jun 10, 2016 at 04:48:57PM +0100, Mark Rutland wrote:
> [+ Lorenzo]
> 
> On Thu, May 19, 2016 at 12:00:18AM -0500, Andy Gross wrote:
> > This patch adds the qcom,idle-state-spc compatible to the SPC idle
> > state.  This compatible indicates that the state is one which supports
> > freeze.
> > 
> > Signed-off-by: Andy Gross <andy.gross@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/msm8916.dtsi | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> > index 208af00..032e411 100644
> > --- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> > @@ -104,7 +104,7 @@
> >  
> >  		idle-states {
> >  			CPU_SPC: spc {
> > -				compatible = "arm,idle-state";
> > +				compatible = "qcom,idle-state-spc", "arm,idle-state";
> >  				arm,psci-suspend-param = <0x40000002>;
> >  				entry-latency-us = <130>;
> >  				exit-latency-us = <150>;
> 
> This looks suspicious.
> 
> This is a PSCI idle state, and we have a PSCI driver driven by the
> generic ARM cpuidle driver.
> 
> Why do we need a qcom-specific compatible here?
> 
> Surely we should be able to use the idle code in a generic fashion to
> driver suspend-to-idle?

We need a way to identify specific idle states that support suspend-to-idle.  In
addition, when we have identified the states, we may have to configure the
enter_freeze() function.

I chose to do this outside of the arm cpuidle driver because I didn't want to
add any more DT information aside from the compatible, and I needed a separate
place for the Qualcomm specific suspend code.  With the compatible, this makes
my 32 and 64 bit processor suspend code identical, as we have our own cpuidle
driver for the 32 bit procs.

An alternative would be to add some facilities to communicate this to the arm
cpuidle driver and configure the enter_freeze() function at some later point.

Regards,

Andy
