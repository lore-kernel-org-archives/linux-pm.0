From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 1/2] cpufreq: powernv: Adding fast_switch for schedutil
Date: Mon, 7 Nov 2016 14:42:40 +0530
Message-ID: <20161107091240.GG21030@vireshk-i7>
References: <1478504349-14796-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1478504349-14796-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Cc: rjw@rjwysocki.net, ego@linux.vnet.ibm.com, shilpa.bhat@linux.vnet.ibm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: linux-pm@vger.kernel.org

On 07-11-16, 13:09, Akshay Adiga wrote:
> Adding fast_switch which does light weight operation to set the desired
> pstate. Both global and local pstates are set to the same desired pstate.
> 
> Signed-off-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
> ---
> Changes from v1 :
> - Removed unnecessary check for index out of bound.

Provided Gautham/Shilpa find these patches fine..

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
