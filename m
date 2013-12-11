From: Luis Henriques <luis.henriques@canonical.com>
Subject: Re: [PATCH][3.11.y]  intel_pstate: fix no_turbo
Date: Wed, 11 Dec 2013 10:35:20 +0000
Message-ID: <20131211103520.GA6127@hercules>
References: <52A76D78.4070507@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <52A76D78.4070507@canonical.com>
Sender: cpufreq-owner@vger.kernel.org
To: Joseph Salisbury <joseph.salisbury@canonical.com>
Cc: Kamal Mostafa <kamal.mostafa@canonical.com>, stable@vger.kernel.org, srinivas.pandruvada@linux.intel.com, dirk.j.brandewie@intel.com, rafael.j.wysocki@intel.com, viresh.kumar@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Kernel Team <kernel-team@lists.ubuntu.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Dec 10, 2013 at 02:37:28PM -0500, Joseph Salisbury wrote:
> Hello,
> 
> Please consider including mainline commit
> 1ccf7a1cdafadd02e33e8f3d74370685a0600ec6 in the next v3.11.y release. 
> 
> It was included in the mainline tree as of v3.12-rc4.  It has been
> tested and confirmed
> to resolve http://bugs.launchpad.net/bugs/1254091 .
> 
> commit 1ccf7a1cdafadd02e33e8f3d74370685a0600ec6
> Author: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Date:   Tue Oct 1 10:28:41 2013 -0700
> 
>     intel_pstate: fix no_turbo
> 
> Other stable trees may also want to pick up this commit.
> 
> Sincerely,
> Joseph Salisbury
> 

Thanks Joseph, I'm queuing this patch for the 3.11 kernel.

Cheers,
--
Luis
