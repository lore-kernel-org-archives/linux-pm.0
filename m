From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH 3/5] arm64: dts: msm8916: Add spc compat tag
Date: Fri, 10 Jun 2016 18:06:56 +0100
Message-ID: <20160610170656.GA23854@red-moon>
References: <1463634020-17252-1-git-send-email-andy.gross@linaro.org>
 <1463634020-17252-4-git-send-email-andy.gross@linaro.org>
 <20160610154857.GA6430@leverpostej>
 <20160610161234.GO13357@hector.attlocal.net>
 <20160610163153.GA23743@red-moon>
 <20160610165248.GQ13357@hector.attlocal.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:39821 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750848AbcFJRG0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 10 Jun 2016 13:06:26 -0400
Content-Disposition: inline
In-Reply-To: <20160610165248.GQ13357@hector.attlocal.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Gross <andy.gross@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, stanimir.varbanov@linaro.org

On Fri, Jun 10, 2016 at 11:52:48AM -0500, Andy Gross wrote:

[...]

> > (1) enter_freeze() hooks are not strictly necessary to enable
> >     suspend-to-idle (they are if we want the tick to be frozen
> >     on suspend-to-idle, which is different)
> 
> I'd think that you'd want the tick frozen.  Even if you are going to
> just call the deepest freezable idle state in your freeze_function,
> you don't want to keep getting woken up as this costs some power usage

As I said, that's a separate issue from these bindings.

> > (2) If I understand your code correctly you have to set the suspend
> >     ops hook to make sure suspend-to-idle is enabled. This is a core
> >     code issue rather than anything else, given that suspend-to-idle
> >     (hey it is based on CPUidle !) does NOT rely on suspend ops to
> >     function.
> 
> It only requires having suspend_ops and a valid function.  Otherwise
> you can never suspend and never exercise the freeze portion of the
> cpuidle code.

As I said, *currently* you have to call suspend_set_ops() to set
up the pm_states label for PM_SUSPEND_FREEZE, suspend_ops are
irrelevant to make suspend-to-idle work and as I said that's
related to core code rather than platform specific suspend ops.

We should solve issues, not work around them.

> > So the gist is: as far as I am concerned you do not need any of this
> > code to enable (yes you need PSCI idle states but no
> > qcom,idle-state-spc compatible string whatsoever) suspend-to-idle
> > on ARM64 on top of PSCI, let me know what I am missing.
> 
> If we had the facilities in the arm cpuidle driver then for 64 bit
> processors, I wouldn't have to do anything except provision my
> suspend_ops + valid function.  For 32 bit, we actually already use
> this compat tag and I just have to add code in the spm driver (qcom
> cpuidle) to init the suspend_ops.

For 64-bit you do not have to have add any facility.

1) we should change core code to make PM_SUSPEND_FREEZE independent
   of suspend_set_ops()
2) we should define which idle states are freezable (99% of them are
   minus coupled idle states), through generic bindings

Lorenzo
