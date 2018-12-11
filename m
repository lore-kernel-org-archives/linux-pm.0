From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC PATCH] PM / OPP: Always expose one supply in debugfs
Date: Tue, 11 Dec 2018 14:55:49 +0530
Message-ID: <20181211092549.2ydogec7bnlfokwy@vireshk-i7>
References: <20181210113247.11412-1-quentin.perret@arm.com>
 <20181210115410.clyrxhp5plptrf5n@queper01-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181210115410.clyrxhp5plptrf5n@queper01-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 10-12-18, 11:54, Quentin Perret wrote:
> On Monday 10 Dec 2018 at 11:32:47 (+0000), Quentin Perret wrote:
> > On some platforms, the opp_table->regulator_count field is kept at zero
> > even though opp->supplies is always allocated. However, the loop used to
> > display the supplies in the debugfs doesn't deal correctly with this,
> > which results in the supplies not being displayed in debugfs on those
> > platforms.
> > 
> > Fix this by making sure to always display at least once supply in
> > debugfs.
> > 
> > Signed-off-by: Quentin Perret <quentin.perret@arm.com>
> > 
> > ---
> > 
> > This has been observed on Juno r2 which uses SCPI and Hikey960 which
> > uses DT. I am not particularly familiar with that part of the code, so
> > I'm not sure if this is even remotely correct (hence the RFC tag).
> > 
> > I first thought setting opp_table->regulator_count to 1 would be the
> > right fix but that causes other issues. This fix seems to work OK on
> > Juno and Hikey960, at least.
> > 
> > Feedback is welcome :-)
> 
> Hmm, so I just figured what I'm doing here is basically reverting:
> 
>     1fae788ed640 ("PM / OPP: Don't create debugfs "supply-0" directory unnecessarily")
> 
> Should I send a proper revert instead of this patch ? It _is_ handy to
> read voltage numbers when available.

First of all I am really happy that someone apart from me is using this debug
interface :)

At least that patch was correct and if we have to fix something, it should be
fixed somewhere else.

I tried to reproduce the issue on hikey and straight away understood why it is
behaving that way. There is no "cpu-supply" property defined for the CPUs.

I looked at juno driver and couldn't see any references to voltage there. Are
you trying to add that support ?

Anyway, this should still be fixed irrespective of the "cpu-supply" property.
The other fix you mentioned about setting opp_table->regulator_count to 1 is
actually the right thing to do but the fix may require changes at multiple
places. I can help writing a patch for that if you want, else I am open to you
giving it a shot :)

Thanks.

-- 
viresh
