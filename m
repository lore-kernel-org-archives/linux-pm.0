From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] intel_pstate, decrease number of "HWP enabled" messages
Date: Thu, 22 Oct 2015 20:45:18 +0530
Message-ID: <20151022151518.GH3897@ubuntu>
References: <1445521411-28850-1-git-send-email-prarit@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1445521411-28850-1-git-send-email-prarit@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>
Cc: linux-kernel@vger.kernel.org, Kristen Carlson Accardi <kristen@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 22-10-15, 09:43, Prarit Bhargava wrote:
> When booting an HWP enabled system the kernel displays one "HWP enabled"
> message for each cpu.  The messages are superfluous since HWP is globally
> enabled across all CPUs. This patch also adds an informational message
> when HWP is disabled via intel_pstate=no_hwp.
> 
> Cc: Kristen Carlson Accardi <kristen@linux.intel.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> ---
>  drivers/cpufreq/intel_pstate.c |   10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
