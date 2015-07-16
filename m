From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v4 0/6] powernv: cpufreq: Report frequency throttle by OCC
Date: Thu, 16 Jul 2015 10:44:07 +0530
Message-ID: <20150716051407.GB15404@linux>
References: <1436796602-10228-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1436796602-10228-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: rjw@rjwysocki.net, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 13-07-15, 19:39, Shilpasri G Bhat wrote:
> This patchset intends to add frequency throttle reporting mechanism
> to powernv-cpufreq driver when OCC throttles the frequency. OCC is an
> On-Chip-Controller which takes care of the power and thermal safety of
> the chip. The CPU frequency can be throttled during an OCC reset or
> when OCC tries to limit the max allowed frequency. The patchset will
> report such conditions so as to keep the user informed about reason
> for the drop in performance of workloads when frequency is throttled.
> 
> Changes from v3:
> - Rebased on top of 4.2-rc1
> - Minor changes in patch 2,3,4,6 this does not change the
>   functionality of the code
> - 594fcb9ec9e powerpc/powernv: Expose OPAL APIs required by PRD
>   interface , this patch fixes the build error due to which this
>   series was initially dropped
>   ERROR: ".opal_message_notifier_register"
>   drivers/cpufreq/powernv-cpufreq.ko] undefined!

I have already Acked v3 of this and that applies to this one as well..

-- 
viresh
