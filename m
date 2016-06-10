From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH 3/5] arm64: dts: msm8916: Add spc compat tag
Date: Fri, 10 Jun 2016 21:59:48 +0100
Message-ID: <20160610205948.GD24178@red-moon>
References: <1463634020-17252-1-git-send-email-andy.gross@linaro.org>
 <1463634020-17252-4-git-send-email-andy.gross@linaro.org>
 <20160610154857.GA6430@leverpostej>
 <20160610161234.GO13357@hector.attlocal.net>
 <20160610163153.GA23743@red-moon>
 <20160610165248.GQ13357@hector.attlocal.net>
 <20160610170656.GA23854@red-moon>
 <20160610172716.GR13357@hector.attlocal.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160610172716.GR13357@hector.attlocal.net>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Andy Gross <andy.gross@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, stanimir.varbanov@linaro.org
List-Id: linux-pm@vger.kernel.org

On Fri, Jun 10, 2016 at 12:27:16PM -0500, Andy Gross wrote:
> On Fri, Jun 10, 2016 at 06:06:56PM +0100, Lorenzo Pieralisi wrote:
> > On Fri, Jun 10, 2016 at 11:52:48AM -0500, Andy Gross wrote:
> > 
> > [...]
> > 
> > > > (1) enter_freeze() hooks are not strictly necessary to enable
> > > >     suspend-to-idle (they are if we want the tick to be frozen
> > > >     on suspend-to-idle, which is different)
> > > 
> > > I'd think that you'd want the tick frozen.  Even if you are going to
> > > just call the deepest freezable idle state in your freeze_function,
> > > you don't want to keep getting woken up as this costs some power usage
> > 
> > As I said, that's a separate issue from these bindings.
> 
> I kind of see that coupled with the determination that a idle state
> supports freeze.  Or are you wanting to have something else that
> decides whether or not to configure the enter_freeze?

All PSCI based idle state support freeze, as long as most of the
other idle routines for ARM 32-bit, I do not even think we should
bother with defining DT bindings for it.

[...]

> > For 64-bit you do not have to have add any facility.
> > 
> > 1) we should change core code to make PM_SUSPEND_FREEZE independent
> >    of suspend_set_ops()
> 
> So then, if cpuidle is active and you have idle states supporting
> freeze, then you can always implicitly freeze the system.  This would
> infer then that the system will always indicate it can do freeze.  I
> am good with that.
> 
> For now, we can get away with just implementing the changes you are
> suggesting.

Cracking.

> > 2) we should define which idle states are freezable (99% of them are
> >    minus coupled idle states), through generic bindings
> 
> This would be in the form of a DT property?  And given this property
> then we'd just assign a enter_freeze() function that calls the enter()
> for that state.  Or would we have something else that we need to key
> off of to decide to configure the enter_freeze?

See above, I will give it more thought. I take an action to change
core code as per discussion above.

Thanks for raising the point.

Lorenzo
