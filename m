From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/7] cpufreq: dt: Register an Energy Model
Date: Tue, 29 Jan 2019 10:51:44 +0530
Message-ID: <20190129052144.plicqu4vozh3l3ss@vireshk-i7>
References: <20190128165522.31749-1-quentin.perret@arm.com>
 <20190128165522.31749-3-quentin.perret@arm.com>
 <20190128193656.GI81583@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190128193656.GI81583@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Kaehlcke <mka@chromium.org>
Cc: Quentin Perret <quentin.perret@arm.com>, rjw@rjwysocki.net, sudeep.holla@arm.com, liviu.dudau@arm.com, lorenzo.pieralisi@arm.com, robh+dt@kernel.org, mark.rutland@arm.com, nm@ti.com, sboyd@kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, dietmar.eggemann@arm.com
List-Id: linux-pm@vger.kernel.org

On 28-01-19, 11:36, Matthias Kaehlcke wrote:
> I think this patch will result in error messages at registration on
> platforms that use the cpufreq-dt driver and don't specify
> 'dynamic-power-coefficient' for the CPUs in the DT. Not sure if that's
> a problem as long as the cpufreq initialization succeeds regardless,
> it could be seen as a not-so-gentle nudge to add the values.

That wouldn't be acceptable.

-- 
viresh
