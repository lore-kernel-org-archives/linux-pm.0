From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/7] cpufreq: dt: Register an Energy Model
Date: Wed, 30 Jan 2019 15:47:15 +0530
Message-ID: <20190130101715.nz2bpqnust7gv4at@vireshk-i7>
References: <20190128165522.31749-1-quentin.perret@arm.com>
 <20190128165522.31749-3-quentin.perret@arm.com>
 <20190128193656.GI81583@google.com>
 <20190129052144.plicqu4vozh3l3ss@vireshk-i7>
 <20190129091546.tfh3lo4w4sosfuba@queper01-lin>
 <20190130051806.fdsos27jaekkwgbs@vireshk-i7>
 <20190130091055.zjj2jrjvi2n3ht66@queper01-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190130091055.zjj2jrjvi2n3ht66@queper01-lin>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: mark.rutland@arm.com, nm@ti.com, lorenzo.pieralisi@arm.com, devicetree@vger.kernel.org, sboyd@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, liviu.dudau@arm.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org, Matthias Kaehlcke <mka@chromium.org>, sudeep.holla@arm.com, dietmar.eggemann@arm.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On 30-01-19, 09:12, Quentin Perret wrote:
> What I had in mind is something as simple as:
> 
> 	void of_dev_pm_opp_register_em(struct cpumask *cpus)
> 	{
> 		/* Bail out if an EM is there */
> 		if (em_cpu_get(cpumask_first(cpus)))
> 			return;
> 
> 		/* Check prerequisites: dpc coeff in DT, ... */
> 		...
> 
> 		em_register_perf_domain(...);
> 	}
> 
> IIUC, Matthias' point was that if the EM is already registered, there is
> no good reason to call em_register_perf_domain() again. Now, that should
> in fact be harmless because em_register_perf_domain() already does that
> check. It's just cleaner and easier to understand from a conceptual
> standpoint to not call that function several times for no reason I
> assume.

If there is no good reason to call em_register_perf_domain() several
times, then the same applies to of_dev_pm_opp_register_em() as well,
isn't it ?

This is init code anyway isn't going to run a lot, so I wouldn't
suggest adding any such (duplicate) checks in
of_dev_pm_opp_register_em().

-- 
viresh
