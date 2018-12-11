From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [RFC PATCH] PM / OPP: Always expose one supply in debugfs
Date: Tue, 11 Dec 2018 09:49:10 +0000
Message-ID: <20181211094908.2dzmmzu6aq6cs4yn@queper01-lin>
References: <20181210113247.11412-1-quentin.perret@arm.com>
 <20181210115410.clyrxhp5plptrf5n@queper01-lin>
 <20181211092549.2ydogec7bnlfokwy@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181211092549.2ydogec7bnlfokwy@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tuesday 11 Dec 2018 at 14:55:49 (+0530), Viresh Kumar wrote:
> On 10-12-18, 11:54, Quentin Perret wrote:
> > On Monday 10 Dec 2018 at 11:32:47 (+0000), Quentin Perret wrote:
> > > On some platforms, the opp_table->regulator_count field is kept at zero
> > > even though opp->supplies is always allocated. However, the loop used to
> > > display the supplies in the debugfs doesn't deal correctly with this,
> > > which results in the supplies not being displayed in debugfs on those
> > > platforms.
> > > 
> > > Fix this by making sure to always display at least once supply in
> > > debugfs.
> > > 
> > > Signed-off-by: Quentin Perret <quentin.perret@arm.com>
> > > 
> > > ---
> > > 
> > > This has been observed on Juno r2 which uses SCPI and Hikey960 which
> > > uses DT. I am not particularly familiar with that part of the code, so
> > > I'm not sure if this is even remotely correct (hence the RFC tag).
> > > 
> > > I first thought setting opp_table->regulator_count to 1 would be the
> > > right fix but that causes other issues. This fix seems to work OK on
> > > Juno and Hikey960, at least.
> > > 
> > > Feedback is welcome :-)
> > 
> > Hmm, so I just figured what I'm doing here is basically reverting:
> > 
> >     1fae788ed640 ("PM / OPP: Don't create debugfs "supply-0" directory unnecessarily")
> > 
> > Should I send a proper revert instead of this patch ? It _is_ handy to
> > read voltage numbers when available.
> 
> First of all I am really happy that someone apart from me is using this debug
> interface :)

:-)

My current use case is to compute the 'dynamic-power-coefficient' thing
for IPA. With P=CV^2f, I can measure P and get f easily, but V is a bit
trickier (as of now at least). PM_OPP has the information I need, so it'd
be handy to expose it somewhere.

> At least that patch was correct and if we have to fix something, it should be
> fixed somewhere else.

Understood.

> I tried to reproduce the issue on hikey and straight away understood why it is
> behaving that way. There is no "cpu-supply" property defined for the CPUs.

Ah, right. The opp-microvolt binding is specified however, so I guess we
could expose that too ...

> I looked at juno driver and couldn't see any references to voltage there. Are
> you trying to add that support ?

So, on Juno we do get voltage numbers from firmware, and those get
registered properly in PM_OPP, exactly like for Hikey960. So it's
probably the same problem in both cases.

FWIW, this is what I get on juno with my 'fix' applied:

  $ cat /sys/kernel/debug/opp/cpu0/*/supply-0/u_volt_target
  820000
  850000
  900000
  950000
  1000000

> Anyway, this should still be fixed irrespective of the "cpu-supply" property.
> The other fix you mentioned about setting opp_table->regulator_count to 1 is
> actually the right thing to do but the fix may require changes at multiple
> places. I can help writing a patch for that if you want, else I am open to you
> giving it a shot :)

You'll definitely know the code better than me so if you have a patch in
mind, please don't hesitate. I'll be happy to test it on my two boards
here :-)

Thanks,
Quentin
