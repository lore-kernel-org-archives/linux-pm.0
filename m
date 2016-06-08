From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V3 8/9] cpufreq: Keep policy->freq_table sorted in
 ascending order
Date: Wed, 8 Jun 2016 09:18:15 +0530
Message-ID: <20160608034815.GA20114@vireshk-i7>
References: <cover.1464960877.git.viresh.kumar@linaro.org>
 <CAJZ5v0hG9X_zoHHFBiiZnn5x0rMfukF4RpFMxr73r3C0VzrUHw@mail.gmail.com>
 <20160607042807.GC21466@vireshk-i7>
 <3409903.LrptLTtVZr@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33264 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751125AbcFHDsT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jun 2016 23:48:19 -0400
Received: by mail-pa0-f47.google.com with SMTP id ec8so46347380pac.0
        for <linux-pm@vger.kernel.org>; Tue, 07 Jun 2016 20:48:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <3409903.LrptLTtVZr@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Steve Muckle <steve.muckle@linaro.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, Steven Miao <realmz6@gmail.com>

On 08-06-16, 02:38, Rafael J. Wysocki wrote:
> On Tuesday, June 07, 2016 09:58:07 AM Viresh Kumar wrote:
> > On 06-06-16, 23:56, Rafael J. Wysocki wrote:
> > > Since you are adding new code, you can write it so it doesn't do
> > > unnecessary checks from the start.
> > 
> > Hmm, I will do all that in this series only now.
> > 
> > > While at it, the "if ((freq < policy->min) || (freq > policy->max))"
> > > checks in cpufreq_find_index_l() and cpufreq_find_index_h() don't look
> > > good to me, because they very well may cause those function to return
> > > -EINVAL even when there's a valid table and that may cause
> > > acpi_cpufreq_fast_switch() to do bad things.
> > 
> > Hmm. So, the checks are for sure required here, otherwise we may end up
> > returning a frequency which we aren't allowed to. Also note that 'freq' here
> > isn't the target-freq, but the entry in the freq-table.
> > 
> > This routine should be returning a valid freq within the ranges specified by
> > policy->min/max.
> 
> Which in principle may not be possible if the range doesn't include any
> frequency in the table, eg. min == max and between the table entries.

By within ranges I meant, policy->min <= freq <= policy->max, and that's how all
our checks are. So even if the table will have a single valid frequency, we will
return that only.

> However, the CPU has to run at *some* frequency, even if there's none in the
> min/max range.

I completely agree. But the error will be fired only if there is no frequency
within ranges we can switch to. And that's a bug somewhere else then.

> And if we are sure that there is at least one valid frequency between min
> and max, please note that target_freq has already been clamped between them,

Yeah, its already clamped by the freq-change helpers in cpufreq core, but others
may not be doing it properly.

> > Also note that these routines shall *never* return -EINVAL, otherwise it is
> > mostly a bug we are hitting.
> 
> So make them explicitly return a valid frequency every time.

I thought about return Index 0 on such errors, will that be fine ? Anyway the
new patches have added a WARN() for such cases.

> > We have enough checks in place to make sure that there is at least one valid
> > entry in the freq-table which is >= policy->min and <= policy->max.
> 
> That assuming that the driver will always do the right thing in its ->verify
> callback.

Yeah.

-- 
viresh
