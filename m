From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V3 8/9] cpufreq: Keep policy->freq_table sorted in ascending order
Date: Wed, 08 Jun 2016 02:38:09 +0200
Message-ID: <3409903.LrptLTtVZr@vostro.rjw.lan>
References: <cover.1464960877.git.viresh.kumar@linaro.org> <CAJZ5v0hG9X_zoHHFBiiZnn5x0rMfukF4RpFMxr73r3C0VzrUHw@mail.gmail.com> <20160607042807.GC21466@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:54877 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750881AbcFHAeK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jun 2016 20:34:10 -0400
In-Reply-To: <20160607042807.GC21466@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Steve Muckle <steve.muckle@linaro.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, Steven Miao <realmz6@gmail.com>

On Tuesday, June 07, 2016 09:58:07 AM Viresh Kumar wrote:
> On 06-06-16, 23:56, Rafael J. Wysocki wrote:
> > Since you are adding new code, you can write it so it doesn't do
> > unnecessary checks from the start.
> 
> Hmm, I will do all that in this series only now.
> 
> > While at it, the "if ((freq < policy->min) || (freq > policy->max))"
> > checks in cpufreq_find_index_l() and cpufreq_find_index_h() don't look
> > good to me, because they very well may cause those function to return
> > -EINVAL even when there's a valid table and that may cause
> > acpi_cpufreq_fast_switch() to do bad things.
> 
> Hmm. So, the checks are for sure required here, otherwise we may end up
> returning a frequency which we aren't allowed to. Also note that 'freq' here
> isn't the target-freq, but the entry in the freq-table.
> 
> This routine should be returning a valid freq within the ranges specified by
> policy->min/max.

Which in principle may not be possible if the range doesn't include any
frequency in the table, eg. min == max and between the table entries.

However, the CPU has to run at *some* frequency, even if there's none in the
min/max range.

And if we are sure that there is at least one valid frequency between min
and max, please note that target_freq has already been clamped between them,
so clamping again is rather unuseful.  And of course it is racy in general,
which makes it even more unuseful.

> Also note that these routines shall *never* return -EINVAL, otherwise it is
> mostly a bug we are hitting.

So make them explicitly return a valid frequency every time.

> We have enough checks in place to make sure that there is at least one valid
> entry in the freq-table which is >= policy->min and <= policy->max.

That assuming that the driver will always do the right thing in its ->verify
callback.

> I will take care of rest of the comments though. Thanks.

Thanks!

