From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH v4 1/3] arm64: defconfig: Enable CONFIG_ENERGY_MODEL
Date: Wed, 15 May 2019 10:22:44 +0100
Message-ID: <20190515092242.azcracudtdnruwnz@queper01-lin>
References: <20190515082318.7993-1-quentin.perret@arm.com>
 <20190515082318.7993-2-quentin.perret@arm.com>
 <2f598ea3-752d-0f1d-fd33-f07cda3b7bd0@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2f598ea3-752d-0f1d-fd33-f07cda3b7bd0@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: edubezval@gmail.com, rui.zhang@intel.com, javi.merino@kernel.org, viresh.kumar@linaro.org, amit.kachhap@gmail.com, rjw@rjwysocki.net, will.deacon@arm.com, catalin.marinas@arm.com, dietmar.eggemann@arm.com, ionela.voinescu@arm.com, mka@chromium.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Wednesday 15 May 2019 at 10:46:09 (+0200), Daniel Lezcano wrote:
> On 15/05/2019 10:23, Quentin Perret wrote:
> > The recently introduced Energy Model (EM) framework manages power cost
> > tables for the CPUs of the system. Its only user right now is the
> > scheduler, in the context of Energy Aware Scheduling (EAS).
> > 
> > However, the EM framework also offers a generic infrastructure that
> > could replace subsystem-specific implementations of the same concepts,
> > as this is the case in the thermal framework.
> > 
> > So, in order to prepare the migration of the thermal subsystem to use
> > the EM framework, enable it in the default arm64 defconfig, which is the
> > most commonly used architecture for IPA. This will also compile-in all
> > of the EAS code, although it won't be enabled by default -- EAS requires
> > to use the 'schedutil' CPUFreq governor while arm64 defaults to
> > 'performance'.
> > 
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > Signed-off-by: Quentin Perret <quentin.perret@arm.com>
> 
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Thanks !
Quentin
