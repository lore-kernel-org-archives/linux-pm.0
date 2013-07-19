From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq/intel_pstate: Change to scale off of max P-state
Date: Fri, 19 Jul 2013 09:23:12 +0530
Message-ID: <CAOh2x=m1M0ty5ibCrNUTvm5XjzDHu6fTDt0e-Hcdvkc-BdOA0g@mail.gmail.com>
References: <1374162523-2777-1-git-send-email-dirk.j.brandewie@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1374162523-2777-1-git-send-email-dirk.j.brandewie@gmail.com>
Sender: stable-owner@vger.kernel.org
To: dirk.brandewie@gmail.com
Cc: kernel@vger.kernel.org, linux-pm@vger.kernel.org, Dirk Brandewie <dirk.j.brandewie@intel.com>, stable@vger.kernel.org, dsmythies@telus.net
List-Id: linux-pm@vger.kernel.org

On Thu, Jul 18, 2013 at 9:18 PM,  <dirk.brandewie@gmail.com> wrote:
> From: Dirk Brandewie <dirk.j.brandewie@intel.com>
>
> Change to using max P-state instead of max turbo P-state.  This change
> resolves two issues.
>
> On a quiet system intel_pstate can fail to respond to a load change.
>    https://bugzilla.kernel.org/show_bug.cgi?id=59481
>
> On CPU SKUs that have a limited number of P-states and no turbo range
> intel_pstate fails to select the highest available P-state.
>
> This change is suitable for stable v3.9+
>
> Reported-by: arjan@linux.intel.com
> Reported-by: dsmythies@telus.net
> Tested-by: arjan@linux.intel.com
> Tested-by: dsmythies@telus.net
>
> CC: stable@vger.kernel.org
> CC: dsmythies@telus.net
> Signed-off-by: Dirk Brandewie <dirk.j.brandewie@intel.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
