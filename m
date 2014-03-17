From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH RFC v4 3/3] Documentation: arm: define DT idle states
 bindings
Date: Mon, 17 Mar 2014 11:53:03 +0000
Message-ID: <20140317115303.GB28453@e102568-lin.cambridge.arm.com>
References: <1392724051-11950-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1392724051-11950-4-git-send-email-lorenzo.pieralisi@arm.com>
 <20140317.131507.1338341364843764791.apm@brigitte.kvy.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140317.131507.1338341364843764791.apm@brigitte.kvy.fi>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Antti P Miettinen <ananaza@iki.fi>
Cc: Mark Rutland <Mark.Rutland@arm.com>, "mturquette@linaro.org" <mturquette@linaro.org>, "t.figa@samsung.com" <t.figa@samsung.com>, "mark.hambleton@broadcom.com" <mark.hambleton@broadcom.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "nico@linaro.org" <nico@linaro.org>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "sebastian.capella@linaro.org" <sebastian.capella@linaro.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Dave P Martin <Dave.Martin@arm.com>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "khilman@linaro.org" <khilman@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "galak@codeaurora.org" <galak@codeaurora.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>, linux-arm-kernel@lists.infradea
List-Id: linux-pm@vger.kernel.org

Hi Antti,

On Mon, Mar 17, 2014 at 11:15:07AM +0000, Antti P Miettinen wrote:
> Sorry for having been lazy in commenting..

No worries, comments always welcome.

> From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Date: Tue, 18 Feb 2014 11:47:31 +0000
> > +	- min-residency
> > +		Usage: Required
> > +		Value type: <prop-encoded-array>
> > +		Definition: u32 value representing time in microseconds
> > +			    required for the CPU to be in the idle state to
> > +			    break even in power consumption terms compared
> > +			    to idle state idle_standby ([4][5]).
> 
> To me this continues to be a bit illdefined. Say we have three states:
> 0,1,2. State 0 is the idle_standby. Providing a minimum residency for
> state 1 compared to state 0 sort of makes sense, but if we provide a
> minimum residency for state 2 compared to state 0 the break even time
> is going to be smaller than break even when comparing state 1 and
> state 2. With this data we'd enter state 2 when we'd be better off
> entering state 1.

I am not sure I got your reply right, but min-residency for
state 2 will be higher than state 1, since it has to cater for the
dynamic power consumed by entering the state (but burns less power
than state 1 when _in_ the state).

Entering a state has a power cost and min-residency should take that into
account, worst-case as per other stats.

min-residency (and so the break-even) should take into account that
entering the state is not for free.

I think that comparing against idle_standby is the only sane way we can
define that parameter, either that or we remove it.

Does it make sense ?

Thanks !
Lorenzo
