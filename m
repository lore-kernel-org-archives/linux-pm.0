From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 0/2] cpufreq/powernv: Set core pstate to a minimum just
 before hotplugging it out
Date: Fri, 5 Sep 2014 13:11:22 +0530
Message-ID: <CAKohpo=chEW_TtXWCHa3OEwrqU25TPBES4icjMVxL6nezrf8+w@mail.gmail.com>
References: <20140905073812.3629.29175.stgit@preeti.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140905073812.3629.29175.stgit@preeti.in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Dirk Brandewie <dirk.j.brandewie@intel.com>, Shreyas Prabhu <shreyas@linux.vnet.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Patrick Marlier <patrick.marlier@gmail.com>, "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>, Dirk Brandewie <dirk.brandewie@gmail.com>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

On 5 September 2014 13:09, Preeti U Murthy <preeti@linux.vnet.ibm.com> wrote:
> Today cpus go to winkle when they are offlined. Since it is the deepest
> idle state that we have, it is expected to save good amount of power as compared
> to online state, where cores can enter nap/fastsleep only which are
> shallower idle states.
> However we observed no powersavings with winkle as compared to nap/fastsleep
> and traced the problem to the pstate of the core being kept at a high even
> when the core is offline. This can keep the socket pstate high, thus burning
> power unnecessarily. This patchset fixes this issue.
>
> Changes in V2: Changed smp_call_function_any() to smp_call_function_single() in Patch[2/2]

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
