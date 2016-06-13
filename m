From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH 3/5] arm64: dts: msm8916: Add spc compat tag
Date: Mon, 13 Jun 2016 14:48:33 +0100
Message-ID: <20160613134833.GB26738@red-moon>
References: <1463634020-17252-1-git-send-email-andy.gross@linaro.org>
 <1463634020-17252-4-git-send-email-andy.gross@linaro.org>
 <20160610154857.GA6430@leverpostej>
 <20160610161234.GO13357@hector.attlocal.net>
 <20160610162555.GB6430@leverpostej>
 <20160610164721.GP13357@hector.attlocal.net>
 <20160613110043.GB19604@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:51885 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423440AbcFMNr7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 13 Jun 2016 09:47:59 -0400
Content-Disposition: inline
In-Reply-To: <20160613110043.GB19604@leverpostej>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Andy Gross <andy.gross@linaro.org>, linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, stanimir.varbanov@linaro.org

On Mon, Jun 13, 2016 at 12:00:43PM +0100, Mark Rutland wrote:
> On Fri, Jun 10, 2016 at 11:47:21AM -0500, Andy Gross wrote:
> > On Fri, Jun 10, 2016 at 05:25:55PM +0100, Mark Rutland wrote:
> > > On Fri, Jun 10, 2016 at 11:12:34AM -0500, Andy Gross wrote:
> > > > On Fri, Jun 10, 2016 at 04:48:57PM +0100, Mark Rutland wrote:
> > > > > [+ Lorenzo]
> > > > > 
> > > > > On Thu, May 19, 2016 at 12:00:18AM -0500, Andy Gross wrote:
> > > > > > This patch adds the qcom,idle-state-spc compatible to the SPC idle
> > > > > > state.  This compatible indicates that the state is one which supports
> > > > > > freeze.
> > > > > > 
> > > > > > Signed-off-by: Andy Gross <andy.gross@linaro.org>
> > > > > > ---
> > > > > >  arch/arm64/boot/dts/qcom/msm8916.dtsi | 2 +-
> > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > 
> > > > > > diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> > > > > > index 208af00..032e411 100644
> > > > > > --- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
> > > > > > +++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> > > > > > @@ -104,7 +104,7 @@
> > > > > >  
> > > > > >  		idle-states {
> > > > > >  			CPU_SPC: spc {
> > > > > > -				compatible = "arm,idle-state";
> > > > > > +				compatible = "qcom,idle-state-spc", "arm,idle-state";
> > > > > >  				arm,psci-suspend-param = <0x40000002>;
> > > > > >  				entry-latency-us = <130>;
> > > > > >  				exit-latency-us = <150>;
> > > > > 
> > > > > This looks suspicious.
> > > > > 
> > > > > This is a PSCI idle state, and we have a PSCI driver driven by the
> > > > > generic ARM cpuidle driver.
> > > > > 
> > > > > Why do we need a qcom-specific compatible here?
> > > > > 
> > > > > Surely we should be able to use the idle code in a generic fashion to
> > > > > driver suspend-to-idle?
> > > > 
> > > > We need a way to identify specific idle states that support suspend-to-idle.  In
> > > > addition, when we have identified the states, we may have to configure the
> > > > enter_freeze() function.
> > > 
> > > Could you elaborate on what you mean by a state supporting
> > > suspend-to-idle? It was my understanding that any idle state should
> > > function for suspend-to-idle (and the choice of state is potentially
> > > subjective).
> > 
> > when you freeze the system, cpuidle will try to find the deepest state which
> > supports freeze (by checking if a enter_freeze() exists).  If it does exist,
> > then the tick is frozen and the enter_freeze is called as each cpu goes idle.
> 
> Per Lorenzo's replies in another thread, it sounds like this is a
> generic issue, and not specific to Qualcomm. My understanding is that
> the only issue is coupled idle states, and further, that issue is really
> an implementation detail within Linux w.r.t. IRQ management.
> 
> So it sounds like we need to rework things to be robust in the case of
> coupled idle states, and we can wire up enter_freeze for all states
> generically.
> 
> If there is some peroblem with making things robust, I assume we can
> identify coupled idle states today in some generic manner. I don't
> currently see the need for any DT binding.
> 
> Lorenzo, does the above make sense to you?

It does but I have a concern, let me summarize the problem here.

An idle state is freezeable if it can be entered with a function
that does not enable IRQs and that's a kernel implementation
detail; that function is used to initialize its enter_freeze()
hook.

That's the case for all ARM platforms I am aware of, apart
from the ones relying on coupled C-states that (by construction,
in core CPUidle code) rely on IRQ enabling in their enter
function body to work (NB: I do not handle coupled idle states
in generic ARM CPUidle code, and I will never do so that's a
non-existing problem).

The point is: while initializing the idle states in:

drivers/cpuidle/dt_idle_states.c (init_state_node())

we do not have all necessary information to know if we can
safely initialize the enter_freeze() hook (because
that's a property that depends on the CPUidle back-end).

We could add a DT property to report an idle state as
"freezeable", but that's ugly and ill-defined, it is a kernel
implementation detail, not sure a DT property makes sense
here.

So, either:

(1) We consider all idle states to be "freezeable" and so
    I initialize their enter_freeze() pointer == enter()
    (and assume the idle back-end does NOT enable IRQs, I
    could add some documentation for that)

(2) I have to add code that probes the idle back-end (ie
    the arm_cpuidle_suspend() implementation) to detect
    which states require IRQs to be enabled.

(2) is ugly/convoluted (and solving a problem that does not exist
at present). I am quite tempted to go for (1) and if we ever
have some issues with that we blacklist the respective platforms
enable-methods in the DT idle parsing code.

Thoughts appreciated.

Lorenzo
