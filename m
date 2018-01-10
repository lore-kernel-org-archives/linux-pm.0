From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/2] cpufreq: scpi: remove arm_big_little dependency
Date: Wed, 10 Jan 2018 20:16:31 +0530
Message-ID: <20180110144631.GE3626@vireshk-i7>
References: <1515516568-31359-1-git-send-email-sudeep.holla@arm.com>
 <1515516568-31359-3-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1515516568-31359-3-git-send-email-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Jeremy Linton <jeremy.linton@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org

On 09-01-18, 16:49, Sudeep Holla wrote:
> The dependency on physical_package_id from the topology to get the
> cluster identifier is wrong. The concept of cluster used in ARM topology
> is unfortunately not well defined in the architecture, we should avoid
> using it. Further the frequency domain need not be mapped to so called
> "clusters" one to one.
> 
> SCPI already provides means to obtain the frequency domain id from the
> device tree. In order to support some new topologies(e.g. DSU which
> contains 2 frequency domains within the physical cluster), pseudo
> clusters are created to make this driver work which is wrong again.
> 
> In order to solve those issues and also remove dependency of topological
> physical id for frequency domain, this patch removes the arm_big_little
> dependency from scpi driver.
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/cpufreq/scpi-cpufreq.c | 193 +++++++++++++++++++++++++++++++++++++----
>  1 file changed, 178 insertions(+), 15 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
