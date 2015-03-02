From: Javi Merino <javi.merino@arm.com>
Subject: Re: [PATCH v3 0/5] Subject: The power allocator thermal governor
Date: Mon, 2 Mar 2015 17:40:54 +0000
Message-ID: <20150302174054.GB15351@e104805>
References: <1425316643-31991-1-git-send-email-javi.merino@arm.com>
 <20150302172847.GD8925@developer.hsd1.ca.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150302172847.GD8925@developer.hsd1.ca.comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: "rui.zhang@intel.com" <rui.zhang@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Punit Agrawal <Punit.Agrawal@arm.com>, "lina.iyer@linaro.org" <lina.iyer@linaro.org>, "broonie@kernel.org" <broonie@kernel.org>, "tixy@linaro.org" <tixy@linaro.org>, Kapileshwar Singh <Kapileshwar.Singh@arm.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Mar 02, 2015 at 05:28:50PM +0000, Eduardo Valentin wrote:
> On Mon, Mar 02, 2015 at 05:17:18PM +0000, Javi Merino wrote:
> > *** BLURB HERE ***
> > 
> > Hi linux-pm,
> > 
> > Introduce the power allocator governor, a thermal governor that
> > allocates device power to control temperature.  This series is based
> > on branch "linus" of Eduardo's linux-soc-thermal tree:
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal.git
> > 
> > Changes since v2:
> >   - Address Eduardo's review
> >     + Turn variable-size array in divvy_up_power() into a
> >       devm_kcalloc() as suggested by Eduardo
> >     + Remove #ifdeffery from thermal_core.c as suggested by Eduardo
> >   - Bring back cpufreq's CPUFREQ_UPDATE_POLICY_CPU notifier in order
> >     to update the cpu device in cpu_cooling.c when cpufreq changes
> >     the policy cpu.
> 
> 
> Can you please elaborate a bit more on the issue you saw to decide to
> bring this functionality back?

I explained it in patch 5 ("thermal: cpu_cooling: update the cpu
device when cpufreq updates the policy cpu"): When cpufreq changes the
policy cpu, the cpufreq cooling device needs to update the cached cpu
device accordingly.

> Can we keep the cpufreq changes as a separated thread? To me if the
> issue happens to power allocator, it also happens to the other
> governors.

The cached cpu device was introduced in patch 98ea0816118f ("thermal:
cpu_cooling: implement the power cooling device API") in your tree.
I'm posting it here because it only affects doesn't affect other
governors.

> I don't want to block power allocator due to the cpufreq
> changes.

You don't have to.  It's the last two patches precisely for that.  You
can merge everything up to patch 3 without depending on cpufreq
changes.

> Besides, cpufreq changes should go via the proper cpufreq tree, not the
> thermal tree.

It's a change to cpu_cooling (patch 5) that needs a revert of cpufreq
(patch 4).  The change to cpu_cooling depends on the patches already
in your branch.  So you will have to carry this patch in your branch
with an Ack from the cpufreq maintainers.

Cheers,
Javi
