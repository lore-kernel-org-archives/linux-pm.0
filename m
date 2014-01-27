From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH RFC v2 2/2] Documentation: arm: define DT C-states bindings
Date: Mon, 27 Jan 2014 18:22:07 +0000
Message-ID: <20140127182207.GB8367@e102568-lin.cambridge.arm.com>
References: <1390240079-6495-3-git-send-email-lorenzo.pieralisi@arm.com>
 <20140125.101546.1134862463481697494.apm@brigitte.kvy.fi>
 <20140127114125.GD16639@e102568-lin.cambridge.arm.com>
 <20140127.144815.1048814583962628826.apm@brigitte.kvy.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140127.144815.1048814583962628826.apm@brigitte.kvy.fi>
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

On Mon, Jan 27, 2014 at 12:48:15PM +0000, Antti P Miettinen wrote:
> From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > That's why I defined the worst case. How did you implemented it in your
> > idle drivers ? That would help generalize it, after all these bindings
> > are there to simplify drivers upstreaming, feedback welcome.
> 
> Currently we do not handle this well downstream either. The problem
> with worst case is that the absolute worst case can be really bad and
> probability of it might be very low. Sorry - no ready answer :-)

Point taken, but these bindings still get us to a point that is much
better than today situation. After all, if the worst case can happen
either we design for worst case or we update parameters at runtime in
the kernel (which is not happening as of now) according to a notification
mechanism.

It is certainly worth investigating, probably we can define OPPs as
generic (ie not tied to the CPU), as performance point or system
operating points. I will think about this.

In the meantime if you have further pieces of feedback please keep them
coming.

Thanks,
Lorenzo
