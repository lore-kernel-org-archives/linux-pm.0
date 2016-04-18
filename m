From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 1/2] cpufreq: powernv: Remove flag use-case of
 policy->driver_data
Date: Mon, 18 Apr 2016 15:45:05 +0530
Message-ID: <20160418101505.GA2322@vireshk-i7>
References: <1460701739-31549-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
 <1460701739-31549-2-git-send-email-akshay.adiga@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1460701739-31549-2-git-send-email-akshay.adiga@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, ego@linux.vnet.ibm.com, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

On 15-04-16, 11:58, Akshay Adiga wrote:
> From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> 
> commit 1b0289848d5d ("cpufreq: powernv: Add sysfs attributes to show
> throttle stats") used policy->driver_data as a flag for one-time creation
> of throttle sysfs files. Instead of this use 'kernfs_find_and_get()' to
> check if the attribute already exists. This is required as
> policy->driver_data is used for other purposes in the later patch.
> 
> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> Signed-off-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
> ---
>  drivers/cpufreq/powernv-cpufreq.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
