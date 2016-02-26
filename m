From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v10 1/2] cpufreq: powernv: Fix bugs in
 powernv_cpufreq_{init/exit}
Date: Fri, 26 Feb 2016 16:15:00 +0530
Message-ID: <20160226104500.GH5823@vireshk-i7>
References: <1456483012-29466-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1456483012-29466-2-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1456483012-29466-2-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, ego@linux.vnet.ibm.com, shreyas@linux.vnet.ibm.com
List-Id: linux-pm@vger.kernel.org

On 26-02-16, 16:06, Shilpasri G Bhat wrote:
> Unregister the notifiers if cpufreq_driver_register() fails in
> powernv_cpufreq_init(). Re-arrange the unregistration and cleanup routines
> in powernv_cpufreq_exit() to free all the resources after the driver
> has unregistered.
> 
> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> ---
>  drivers/cpufreq/powernv-cpufreq.c | 40 ++++++++++++++++++++++++++++-----------
>  1 file changed, 29 insertions(+), 11 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
