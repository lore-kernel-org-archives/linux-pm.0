From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/2] fix some problems for cpufreq
Date: Sat, 29 Nov 2014 23:30:03 +0100
Message-ID: <4004530.x5fm24OG42@vostro.rjw.lan>
References: <1417142619-14548-1-git-send-email-wangweidong1@huawei.com> <2248504.pAVebap2qN@vostro.rjw.lan> <547923F2.6000701@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <547923F2.6000701@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wang Weidong <wangweidong1@huawei.com>
Cc: viresh.kumar@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, guohanjun@huawei.com
List-Id: linux-pm@vger.kernel.org

On Saturday, November 29, 2014 09:40:02 AM Wang Weidong wrote:
> On 2014/11/29 9:26, Rafael J. Wysocki wrote:
> > On Friday, November 28, 2014 10:43:37 AM Wang Weidong wrote:
> >> Hi Rafael and Viresh
> >>
> >> Sorry to trouble you again. As for:
> >> "acpi-cpufreq: get the cur_freq from acpi_processor_performance states"
> >> I do it again, and add the other patch.
> >>
> >> patch #1: acpi-cpufreq: make the freq_table store the same freq value
> >>
> >> I think it can work. The set of available states which come
> >> from acpi won't change. Just like the power would be remove,
> >> the acpi driver will do that:
> >> call
> >>  ->acpi_processor_ppc_has_changed
> >>  ->cpufreq_update_policy
> >>  ->acpi_ppc_notifier_block.notifier_call
> >>    ->acpi_processor_ppc_notifier
> >>    ->cpufreq_verify_within_limits
> >> The progress will change the policy's min_freq and max_freq
> >> while it won't change the set of states(freq_tables).
> > 
> > OK, so the above information needs to go into the changelog of patch [1/2].
> > Also, please clarify the problem description in that changelog, it is very
> > difficult to understand the way it is now.
> > 
> 
> sure, I should do it.
> 
> >> patch #2: cpufreq: show the real avail freqs with the freq_table
> >>
> >> when the min_freq and max_freq change, we should sync the availble
> >> freqs.
> > 
> > Why?  Do any other cpufreq drivers do that?
> > 
> 
> If some cpufreq drivers support several freqs like this:
> 1.05 Ghz 1.30Ghz 1.70GHz 2.10GHz 2.3GHz
>            |                |
>           min              max
> So what the available freqs is 1.30GHz 1.70GHz 2.10GHz
> 
> when we do cpufreq-info or cat scaling_available_frequencies,
> I think the available freqs table show only show these 3 value,
> not all the values.

That changes an existing user space interface, however, and the
only reason I can figure out from what you're saying is your personal
opinion.  This isn't a good enough reason, however.

What if there are utilities and scripts out there relying on the
current behavior?


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
