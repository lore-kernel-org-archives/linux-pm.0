From: Andy Gross <andy.gross@linaro.org>
Subject: Re: [PATCH 3/5] arm64: dts: msm8916: Add spc compat tag
Date: Fri, 10 Jun 2016 11:52:48 -0500
Message-ID: <20160610165248.GQ13357@hector.attlocal.net>
References: <1463634020-17252-1-git-send-email-andy.gross@linaro.org>
 <1463634020-17252-4-git-send-email-andy.gross@linaro.org>
 <20160610154857.GA6430@leverpostej>
 <20160610161234.GO13357@hector.attlocal.net>
 <20160610163153.GA23743@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f50.google.com ([209.85.218.50]:32938 "EHLO
	mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751951AbcFJQwu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jun 2016 12:52:50 -0400
Received: by mail-oi0-f50.google.com with SMTP id k23so121276200oih.0
        for <linux-pm@vger.kernel.org>; Fri, 10 Jun 2016 09:52:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160610163153.GA23743@red-moon>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, stanimir.varbanov@linaro.org

On Fri, Jun 10, 2016 at 05:31:53PM +0100, Lorenzo Pieralisi wrote:
> On Fri, Jun 10, 2016 at 11:12:34AM -0500, Andy Gross wrote:
> > On Fri, Jun 10, 2016 at 04:48:57PM +0100, Mark Rutland wrote:
> > > [+ Lorenzo]
> > > 
> > > On Thu, May 19, 2016 at 12:00:18AM -0500, Andy Gross wrote:
> > > > This patch adds the qcom,idle-state-spc compatible to the SPC idle
> > > > state.  This compatible indicates that the state is one which supports
> > > > freeze.
> > > > 
> > > > Signed-off-by: Andy Gross <andy.gross@linaro.org>
> > > > ---
> > > >  arch/arm64/boot/dts/qcom/msm8916.dtsi | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> > > > index 208af00..032e411 100644
> > > > --- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
> > > > +++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> > > > @@ -104,7 +104,7 @@
> > > >  
> > > >  		idle-states {
> > > >  			CPU_SPC: spc {
> > > > -				compatible = "arm,idle-state";
> > > > +				compatible = "qcom,idle-state-spc", "arm,idle-state";
> > > >  				arm,psci-suspend-param = <0x40000002>;
> > > >  				entry-latency-us = <130>;
> > > >  				exit-latency-us = <150>;
> > > 
> > > This looks suspicious.
> > > 
> > > This is a PSCI idle state, and we have a PSCI driver driven by the
> > > generic ARM cpuidle driver.
> > > 
> > > Why do we need a qcom-specific compatible here?
> > > 
> > > Surely we should be able to use the idle code in a generic fashion to
> > > driver suspend-to-idle?
> > 
> > We need a way to identify specific idle states that support
> > suspend-to-idle.  In addition, when we have identified the states, we
> > may have to configure the enter_freeze() function.
> > 
> > I chose to do this outside of the arm cpuidle driver because I didn't
> > want to add any more DT information aside from the compatible, and I
> > needed a separate place for the Qualcomm specific suspend code.  With
> > the compatible, this makes my 32 and 64 bit processor suspend code
> > identical, as we have our own cpuidle driver for the 32 bit procs.
> > 
> > An alternative would be to add some facilities to communicate this to
> > the arm cpuidle driver and configure the enter_freeze() function at
> > some later point.
> 
> (1) enter_freeze() hooks are not strictly necessary to enable
>     suspend-to-idle (they are if we want the tick to be frozen
>     on suspend-to-idle, which is different)

I'd think that you'd want the tick frozen.  Even if you are going to just call
the deepest freezable idle state in your freeze_function, you don't want to keep
getting woken up as this costs some power usage


> (2) If I understand your code correctly you have to set the suspend
>     ops hook to make sure suspend-to-idle is enabled. This is a core
>     code issue rather than anything else, given that suspend-to-idle
>     (hey it is based on CPUidle !) does NOT rely on suspend ops to
>     function.

It only requires having suspend_ops and a valid function.  Otherwise you can
never suspend and never exercise the freeze portion of the cpuidle code.

> 
> So the gist is: as far as I am concerned you do not need any of this
> code to enable (yes you need PSCI idle states but no
> qcom,idle-state-spc compatible string whatsoever) suspend-to-idle
> on ARM64 on top of PSCI, let me know what I am missing.

If we had the facilities in the arm cpuidle driver then for 64 bit processors, I
wouldn't have to do anything except provision my suspend_ops + valid function.
For 32 bit, we actually already use this compat tag and I just have to add code
in the spm driver (qcom cpuidle) to init the suspend_ops.

Regards,

Andy
