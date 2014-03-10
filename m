From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH RFC v4 3/3] Documentation: arm: define DT idle states
 bindings
Date: Mon, 10 Mar 2014 18:01:09 +0000
Message-ID: <20140310180109.GB834@e102568-lin.cambridge.arm.com>
References: <1392724051-11950-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1392724051-11950-4-git-send-email-lorenzo.pieralisi@arm.com>
 <20140219160449.11460.93660@capellas-linux>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140219160449.11460.93660@capellas-linux>
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
To: Sebastian Capella <sebastian.capella@linaro.org>
Cc: Mark Rutland <Mark.Rutland@arm.com>, Mike Turquette <mturquette@linaro.org>, Tomasz Figa <t.figa@samsung.com>, Mark Hambleton <mark.hambleton@broadcom.com>, Russell King <linux@arm.linux.org.uk>, Nicolas Pitre <nico@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Dave P Martin <Dave.Martin@arm.com>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Kumar Gala <galak@codeaurora.org>, Rob Herring <robh+dt@kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Antti Miettinen <ananaza@iki.fi>, Peter De Schrijver <pdeschrijver@nvidia.com>, Stephen Boyd <sboyd@codeaurora.org>, Amit
List-Id: linux-pm@vger.kernel.org

On Wed, Feb 19, 2014 at 04:04:49PM +0000, Sebastian Capella wrote:
> Quoting Lorenzo Pieralisi (2014-02-18 03:47:31)
> > +       - index
> > +               Usage: Required
> > +               Value type: <u32>
> > +               Definition: It represents the idle state index.
> > +                           An increasing index value implies less power
> > +                           consumption. Index must be given a sequential
> > +                           value = {0, 1, ....}, starting from 0.
> One minor comment.  In the example, it can be tricky to see how this is sequential
> since the states interleave.  Not sure if it merits rewording here?

- index
	Usage: Required
	Value type: <u32>
	Definition: It represents the idle state index.
		    The index must be given an increasing
		    value = {0, 1, ....}, starting from 0, with higher
		    values implying less power consumption.
		    Indices must be unique as seen from a cpu
		    perspective, ie phandles in the cpu nodes [1]
		    cpu-idle-states array property are not allowed to
		    point at idle state nodes having the same index
		    value.

Ack ?

I will post a v5, should be final.

Lorenzo
