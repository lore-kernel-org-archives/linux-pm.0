From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: intel_pstate: Drop redundant wrapper function
Date: Fri, 10 Mar 2017 08:46:45 +0530
Message-ID: <CAOh2x==jb5nYaJbebKskJYUf+Y2qQ8agKkcM3gLgoV5A8DNb3Q@mail.gmail.com>
References: <8470689.BtHKNtPoNa@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8470689.BtHKNtPoNa@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Mar 9, 2017 at 9:00 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> intel_pstate_hwp_set_policy() is a wrapper around
> intel_pstate_hwp_set(), but the only value it adds is to check
> hwp_active before calling the latter and one of its two callers
> has already checked hwp_active before that happens, so in that
> code path the additional check is redundant and using the wrapper
> is rather pointless.
>
> For this reason, drop intel_pstate_hwp_set_policy() and make its
> callers invoke intel_pstate_hwp_set() directly (after checking
> hwp_active).
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/intel_pstate.c |   18 ++++--------------
>  1 file changed, 4 insertions(+), 14 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
