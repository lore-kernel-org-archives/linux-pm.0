From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2] Documentation: admin-guide: PM: Add cpuidle document
Date: Thu, 29 Nov 2018 09:54:06 +0530
Message-ID: <20181129042406.f2h2yt25atwnhz26@vireshk-i7>
References: <9986634.fXZiTbRPzQ@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9986634.fXZiTbRPzQ@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Jonathan Corbet <corbet@lwn.net>, Linux PM <linux-pm@vger.kernel.org>, Jacob Pan <jacob.jun.pan@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, Linux ACPI <linux-acpi@vger.kernel.org>, Linux Documentation <linux-doc@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ulf Hansson <ulf.hansson@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Giovanni Gherdovich <ggherdovich@suse.cz>, Sudeep Holla <sudeep.holla@arm.com>
List-Id: linux-pm@vger.kernel.org

On 28-11-18, 12:47, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Important information is missing from user/admin cpuidle documentation
> available today, so add a new user/admin document for cpuidle containing
> current and comprehensive information to admin-guide and drop the old
> .txt documents it is replacing.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> -> v2:
>    * Fix typos.
>    * Improve description of the state0, state1, etc directories to cover the
>      relationship between their numbers and the represented idle states depth
>      (Viresh).
> 
> ---
>  Documentation/admin-guide/pm/cpuidle.rst       |  604 +++++++++++++++++++++++++
>  Documentation/admin-guide/pm/working-state.rst |    1 
>  Documentation/cpuidle/core.txt                 |   23 
>  Documentation/cpuidle/sysfs.txt                |   98 ----
>  4 files changed, 605 insertions(+), 121 deletions(-)

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
