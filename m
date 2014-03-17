From: Antti P Miettinen <ananaza@iki.fi>
Subject: Re: [PATCH RFC v4 3/3] Documentation: arm: define DT idle states
 bindings
Date: Mon, 17 Mar 2014 13:15:07 +0200 (EET)
Message-ID: <20140317.131507.1338341364843764791.apm@brigitte.kvy.fi>
References: <1392724051-11950-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1392724051-11950-4-git-send-email-lorenzo.pieralisi@arm.com>
Reply-To: ananaza@iki.fi
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1392724051-11950-4-git-send-email-lorenzo.pieralisi@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: lorenzo.pieralisi@arm.com
Cc: mark.rutland@arm.com, mturquette@linaro.org, t.figa@samsung.com, mark.hambleton@broadcom.com, linux@arm.linux.org.uk, nico@linaro.org, daniel.lezcano@linaro.org, sebastian.capella@linaro.org, grant.likely@linaro.org, dave.martin@arm.com, Charles.Garcia-Tobin@arm.com, devicetree@vger.kernel.org, khilman@linaro.org, linux-pm@vger.kernel.org, galak@codeaurora.org, robh+dt@kernel.org, vincent.guittot@linaro.org, linux-arm-kernel@lists.infradead.org, pdeschrijver@nvidia.com, sboyd@codeaurora.org, amit.kucheria@linaro.org, broonie@kernel.org, santosh.shilimkar@ti.com, hanjun.guo@linaro.org, sudeep.holla@arm.com
List-Id: linux-pm@vger.kernel.org

Sorry for having been lazy in commenting..

From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Date: Tue, 18 Feb 2014 11:47:31 +0000
> +	- min-residency
> +		Usage: Required
> +		Value type: <prop-encoded-array>
> +		Definition: u32 value representing time in microseconds
> +			    required for the CPU to be in the idle state to
> +			    break even in power consumption terms compared
> +			    to idle state idle_standby ([4][5]).

To me this continues to be a bit illdefined. Say we have three states:
0,1,2. State 0 is the idle_standby. Providing a minimum residency for
state 1 compared to state 0 sort of makes sense, but if we provide a
minimum residency for state 2 compared to state 0 the break even time
is going to be smaller than break even when comparing state 1 and
state 2. With this data we'd enter state 2 when we'd be better off
entering state 1.

	--Antti
