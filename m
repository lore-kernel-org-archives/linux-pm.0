From: Antti Miettinen <ananaza@iki.fi>
Subject: Re: [PATCH RFC 2/2] Documentation: arm: define DT C-states bindings
Date: Tue, 10 Dec 2013 08:31:56 +0200
Message-ID: <87lhztgqsj.fsf@iki.fi>
References: <1386001205-11978-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1386001205-11978-3-git-send-email-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1386001205-11978-3-git-send-email-lorenzo.pieralisi@arm.com>
 (Lorenzo Pieralisi's message of "Mon, 2 Dec 2013 16:20:05 +0000")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, linux-pm@vger.kernel.org, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>, Amit Kucheria <amit.kucheria@linaro.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Nicolas Pitre <nico@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Hanjun Guo <hanjun.guo@linaro.org>, Mark Hambleton <mark.hambleton@broadcom.com>, Grant Likely <grant.likely@linaro.org>, Dave Martin <dave.martin@arm.com>, linux-arm-kernel@lists.infradead.org, Charles Garcia Tobin <Charles.Garcia-Tobin@arm.com>
List-Id: linux-pm@vger.kernel.org

Hi Lorenzo,

Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> writes:
> +	- latency
> +		Usage: Required
> +		Value type: <u32>
> +		Definition: Worst case latency in microseconds required to
> +			    enter and exit the C-state.
> +
> +	- min-residency
> +		Usage: Required
> +		Value type: <u32>
> +		Definition: Time in microseconds required for the CPU to be in
> +			    the C-state to make up for the dynamic power
> +			    consumed to enter/exit the C-state in order to
> +			    break even in terms of power consumption compared
> +			    to C1 state (wfi).
> +			    This parameter depends on the operating conditions
> +			    (operating point, cache state) and must assume
> +			    worst case scenario.

I have a concern with these. I know it is not the fault of this patch as
these parameters are what current cpuidle governor/driver interface
uses, but..

Power state entry/exit latencies can be vary quite a lot. Especially CPU
and memory frequencies affect them as can e.g. PMIC properties. Also
power level during entry/exit depends on clocks and voltages. Also the
power level of a sleep state can be context dependent (clocks and
voltages). These mean that also the minimum residency for energy break
even varies. Defining a minimum residency against C1 is a bit
arbitrary. There is no guarantee that the break even order of idle
states remains constant over device context changes.

I have not really properly thought through this but here's an idea.. how
about an alternative interface between governor and driver? The cpuidle
core would provide the expected wakeup time and currently enforced
minimum latency to the driver and the driver would make the decision
about the state to choose.

	--Antti
