From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V3 0/9] PM / OPP: Multiple regulator support
Date: Fri, 18 Nov 2016 08:36:36 +0530
Message-ID: <20161118030636.GA3110@vireshk-i7>
References: <cover.1477463128.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1477463128.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, sboyd@codeaurora.org
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, robh@kernel.org, d-gerlach@ti.com, broonie@kernel.org
List-Id: linux-pm@vger.kernel.org

On 26-10-16, 12:02, Viresh Kumar wrote:
> Hi,
> 
> Some platforms (like TI) have complex DVFS configuration for CPU
> devices, where multiple regulators are required to be configured to
> change DVFS state of the device. This was explained well by Nishanth
> earlier [1].
> 
> One of the major complaints around multiple regulators case was that the
> DT isn't responsible in any way to represent the ordering in which
> multiple supplies need to be programmed, before or after frequency
> change. It was considered in this patch and such information is left to
> the platform specific OPP driver now, which can register its own
> opp_set_rate() callback with the OPP core and the OPP core will then
> call it during DVFS.
> 
> The patches are tested on Exynos5250 (Dual A15). I have hacked around DT
> and code to pass values for multiple regulators and verified that they
> are all properly read by the kernel (using debugfs interface).
> 
> Dave Gerlach has already tested it on the real TI platforms and it works
> well for him.
> 
> This is rebased over: linux-next branch in the PM tree.
> 
> V2->V3:
> - The last patch is new
> - Removed a debug leftover pr_info() message
> - Renamed few names as s/set_rate/set_opp
> - Removed a TODO comment (as it is done now with this series)
> - created struct for min_uV and max_uV
> - kerneldoc comments for structures in pm_opp.h
> - s/const char */const char * const
> - use kasprintf()
> - Some more minor reformatting
> - More Ack/RBY tags added

Hi guys,

Can we please get this series reviewed quickly and come to a conclusion? It has
already taken a lot of time getting this merged and the present code seems to be
the best possible shot we have, AFAIU.

-- 
viresh
