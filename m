From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v6 3/7] arm64: kernel: introduce cpu_init_idle CPU
 operation
Date: Tue, 22 Jul 2014 10:12:03 +0100
Message-ID: <20140722091203.GB8511@e102568-lin.cambridge.arm.com>
References: <1405958786-17243-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1405958786-17243-4-git-send-email-lorenzo.pieralisi@arm.com>
 <53CD9A53.5070001@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <53CD9A53.5070001@codeaurora.org>
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
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Mark Rutland <Mark.Rutland@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Tomasz Figa <t.figa@samsung.com>, Chander Kashyap <chander.kashyap@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Nicolas Pitre <nico@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Sebastian Capella <sebcape@gmail.com>, Mark Brown <broonie@kernel.org>, Antti Miettinen <ananaza@iki.fi>, Paul Walmsley <paul@pwsan.com>, Geoff Levand <geoff@infradead.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Amit Kucheria <amit.kucheria@linaro.org>B
List-Id: linux-pm@vger.kernel.org

On Mon, Jul 21, 2014 at 11:55:15PM +0100, Stephen Boyd wrote:
> On 07/21/14 09:06, Lorenzo Pieralisi wrote:
> > diff --git a/arch/arm64/kernel/cpuidle.c b/arch/arm64/kernel/cpuidle.c
> > new file mode 100644
> > index 0000000..46eb3ea
> > --- /dev/null
> > +++ b/arch/arm64/kernel/cpuidle.c
> > @@ -0,0 +1,27 @@
> > +/*
> > + * ARM64 CPU idle arch support
> > + *
> > + * Copyright (C) 2014 ARM Ltd.
> > + * Author: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +#include <linux/of.h>
> > +#include <linux/of_device.h>
> > +#include <asm/cpu_ops.h>
> > +
> > +int cpu_init_idle(unsigned int cpu)
> 
> sparse will probably complain here unless we include <asm/cpuidle.h> right?

Yes, I missed that, now fixed, thanks a lot.

Lorenzo
