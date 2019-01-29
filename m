From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 6/7] arm64: dts: juno: Add cpu dynamic-power-coefficient
 information
Date: Tue, 29 Jan 2019 15:27:35 +0000
Message-ID: <20190129152735.GA24772@e107155-lin>
References: <20190128165522.31749-1-quentin.perret@arm.com>
 <20190128165522.31749-7-quentin.perret@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190128165522.31749-7-quentin.perret@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org, liviu.dudau@arm.com, lorenzo.pieralisi@arm.com, robh+dt@kernel.org, mark.rutland@arm.com, nm@ti.com, sboyd@kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, dietmar.eggemann@arm.com, Sudeep Holla <sudeep.holla@arm.com>, mka@chromium.org
List-Id: linux-pm@vger.kernel.org

On Mon, Jan 28, 2019 at 04:55:21PM +0000, Quentin Perret wrote:
> From: Dietmar Eggemann <dietmar.eggemann@arm.com>
>
> A CPUfreq driver, like the scpi driver used on Juno boards, which
> provide the Energy Model with power cost information via the PM_OPP
> of_dev_pm_opp_get_cpu_power() function, do need the
> dynamic-power-coefficient (C) in the device tree.
>
> Method used to obtain the C value:
> C is computed by measuring energy (E) consumption of a frequency domain
> (FD) over a 10s runtime (t) sysbench workload running at each Operating
> Performance Point (OPP) affine to 1 or 2 CPUs of that FD while the other
> CPUs of the system are hotplugged out.
> By definition all CPUs of a FD have the the same micro-architecture. An
> OPP is characterized by a certain frequency (f) and voltage (V) value.
> The corresponding power values (P) are calculated by dividing the delta
> of the E values between the runs with 2 and 1 CPUs by t.
>
> With n data tuples (P, f, V), n equal to number of OPPs for this
> frequency domain, we can solve C by:
>
> P = Pstat + Pdyn
>
> P = Pstat + CV²f
>
> Cx = (Px - P1)/(Vx²fx - V1²f1) with x = {2, ..., n}
>
> The C value is the arithmetic mean out of {C2, ..., Cn}.
>
> Since DVFS is broken on Juno r1, no dynamic-power-coefficient
> information has been added to its dts file.
>

Since the binding for "dynamic-power-coefficient" property already exist,
and I don't see any dependency for this and the next patch(TC2) on this
series, I will apply them. Please shout if for any reason that's not true.

--
Regards,
Sudeep
