From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v7 3/6] cpufreq: powernv: Remove cpu_to_chip_id() from
 hot-path
Date: Thu, 28 Jan 2016 13:58:40 +0530
Message-ID: <20160128082840.GI3935@vireshk>
References: <1453965941-7363-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1453965941-7363-4-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1453965941-7363-4-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, pc@us.ibm.com, anton@samba.org, ego@linux.vnet.ibm.com, shreyas@linux.vnet.ibm.com, bsingharora@gmail.com, mpe@ellerman.id.au
List-Id: linux-pm@vger.kernel.org

On 28-01-16, 12:55, Shilpasri G Bhat wrote:
> cpu_to_chip_id() does a DT walk through to find out the chip id by
> taking a contended device tree lock. This adds an unnecessary overhead
> in a hot path. So instead of calling cpu_to_chip_id() everytime cache
> the chip ids for all cores in the array 'core_to_chip_map' and use it
> in the hotpath.
> 
> Reported-by: Anton Blanchard <anton@samba.org>
> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> ---
> Changes from v6:
> - Minor changes to move the code 'cpumask_copy()' after 'core_to_chip_map'
>   is allocated.
> - Move 'kfree(chips)' to a separate patch.

See, you weren't that bad :)

Just that you missed saying that individual patches contain
version-log in cover-letter :)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
