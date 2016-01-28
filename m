From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Subject: Re: [PATCH v7 3/6] cpufreq: powernv: Remove cpu_to_chip_id() from
 hot-path
Date: Thu, 28 Jan 2016 13:41:03 +0530
Message-ID: <20160128081103.GB13654@in.ibm.com>
References: <1453965941-7363-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1453965941-7363-4-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Reply-To: ego@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1453965941-7363-4-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, pc@us.ibm.com, anton@samba.org, ego@linux.vnet.ibm.com, shreyas@linux.vnet.ibm.com, bsingharora@gmail.com, mpe@ellerman.id.au
List-Id: linux-pm@vger.kernel.org

On Thu, Jan 28, 2016 at 12:55:38PM +0530, Shilpasri G Bhat wrote:
> cpu_to_chip_id() does a DT walk through to find out the chip id by
> taking a contended device tree lock. This adds an unnecessary overhead
> in a hot path. So instead of calling cpu_to_chip_id() everytime cache
> the chip ids for all cores in the array 'core_to_chip_map' and use it
> in the hotpath.
> 
> Reported-by: Anton Blanchard <anton@samba.org>
> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>

Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
