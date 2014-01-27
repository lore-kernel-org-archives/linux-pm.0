From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH RFC v2 2/2] Documentation: arm: define DT C-states bindings
Date: Mon, 27 Jan 2014 11:41:26 +0000
Message-ID: <20140127114125.GD16639@e102568-lin.cambridge.arm.com>
References: <1390240079-6495-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1390240079-6495-3-git-send-email-lorenzo.pieralisi@arm.com>
 <20140125.101546.1134862463481697494.apm@brigitte.kvy.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140125.101546.1134862463481697494.apm@brigitte.kvy.fi>
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
Cc: Mark Rutland <Mark.Rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>, "khilman@linaro.org" <khilman@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "pdeschrijver@nvidia.com" <pdeschrijver@nvidia.com>, "nico@linaro.org" <nico@linaro.org>, "sboyd@codeaurora.org" <sboyd@codeaurora.org>, "amit.kucheria@linaro.org" <amit.kucheria@linaro.org>, "t.figa@samsung.com" <t.figa@samsung.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "santosh.shilimkar@ti.com" <santosh.shilimkar@ti.com>, "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, "mark.hambleton@broadcom.com" <mark.hambleton@broadcom.com>, Sudeep Holla <Sudeep.Holla@arm.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "galak@codeaurora.org" <galak@codeau>
List-Id: linux-pm@vger.kernel.org

On Sat, Jan 25, 2014 at 08:15:46AM +0000, Antti P Miettinen wrote:
> From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Subject: [PATCH RFC v2 2/2] Documentation: arm: define DT C-states bindings
> Date: Mon, 20 Jan 2014 17:47:59 +0000
> > +	- latency
> > +		Usage: Required
> > +		Value type: <prop-encoded-array>
> > +		Definition: List of u32 values representing worst case latency
> > +			    in microseconds required to enter and exit the
> > +			    C-state, one value per OPP [2]. The list should
> > +			    be specified in the same order as the operating
> > +			    points property list of the cpu this state is
> > +			    valid on.
> > +			    If no OPP bindings are present, the latency value
> > +			    is associated with the current OPP of CPUs in the
> > +			    system.
> 
> I'm afraid the CPU OPP is not enough to capture the variance in
> latencies. Especially memory frequency affects some of the latencies
> very stronly.

That's why I defined the worst case. How did you implemented it in your
idle drivers ? That would help generalize it, after all these bindings
are there to simplify drivers upstreaming, feedback welcome.

Thanks,
Lorenzo
