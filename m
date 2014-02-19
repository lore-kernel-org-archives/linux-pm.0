From: Sebastian Capella <sebastian.capella@linaro.org>
Subject: Re: [PATCH RFC v4 3/3] Documentation: arm: define DT idle states
 bindings
Date: Wed, 19 Feb 2014 08:04:49 -0800
Message-ID: <20140219160449.11460.93660@capellas-linux>
References: <1392724051-11950-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1392724051-11950-4-git-send-email-lorenzo.pieralisi@arm.com>
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
To: devicetree@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Mike Turquette <mturquette@linaro.org>, Tomasz Figa <t.figa@samsung.com>, Mark Hambleton <mark.hambleton@broadcom.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Russell King <linux@arm.linux.org.uk>, Nicolas Pitre <nico@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-arm-kernel@lists.infradead.org, Grant Likely <grant.likely@linaro.org>, Dave Martin <dave.martin@arm.com>, Charles Garcia Tobin <Charles.Garcia-Tobin@arm.com>, Kevin Hilman <khilman@linaro.org>, linux-pm@vger.kernel.org, Kumar Gala <galak@codeaurora.org>, Rob Herring <robh+dt@kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Antti Miettinen <ananaza@iki.fi>, Peter De Schrijver <pdeschrijver@nvidia.com>, Stephen Boyd <sboyd@codeaurora.org>, Amit Kucheria <amit.kucheria@linaro.org>, Mark Brown <broonie@kernel.org>, Santosh Shilimkar <santosh.sh>
List-Id: linux-pm@vger.kernel.org

Quoting Lorenzo Pieralisi (2014-02-18 03:47:31)
> +       - index
> +               Usage: Required
> +               Value type: <u32>
> +               Definition: It represents the idle state index.
> +                           An increasing index value implies less power
> +                           consumption. Index must be given a sequential
> +                           value = {0, 1, ....}, starting from 0.
One minor comment.  In the example, it can be tricky to see how this is sequential
since the states interleave.  Not sure if it merits rewording here?

These look good to me!

Thanks!

Sebastian
