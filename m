From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH 2/6] ARM: cpuidle: Add a cpuidle ops structure to be used
 for DT
Date: Tue, 17 Mar 2015 11:29:05 +0000
Message-ID: <20150317112905.GA14984@red-moon>
References: <1425385777-14766-1-git-send-email-daniel.lezcano@linaro.org>
 <1425385777-14766-3-git-send-email-daniel.lezcano@linaro.org>
 <55075453.2070503@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:58723 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932631AbbCQL3G (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 17 Mar 2015 07:29:06 -0400
Content-Disposition: inline
In-Reply-To: <55075453.2070503@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, "robherring2@gmail.com" <robherring2@gmail.com>, "arnd@arndb.de" <arnd@arndb.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "lina.iyer@linaro.org" <lina.iyer@linaro.org>

On Mon, Mar 16, 2015 at 10:08:19PM +0000, Stephen Boyd wrote:
> On 03/03/15 04:29, Daniel Lezcano wrote:
> >
> > The code is optimized to use the __init section intensively in order to reduce
> > the memory footprint after the driver is initialized and unify the function
> > names with ARM64.
> >
> > In order to prevent multiple declarations and the specific cpuidle ops to be
> > spread across the different headers, a mechanism, similar to the cgroup subsys,
> > has been introduced.
> >
> > A new platform willing to add its cpuidle ops must add an entry in the file
> > cpuidle_ops.h in the current form:
> >
> >  #if IS_ENABLED(CONFIG_ARM_FOO_CPUIDLE)
> >  CPUIDLE_OPS(foo)
> >  #endif
> >
> > ... and use the variable name in the specific low level code:
> >
> > struct cpuidle_ops foo_cpuidle_ops;
> >
> > The CPUIDLE_OPS macro will be processed in different way in the cpuidle.c file,
> > thus allowing to keep untouched the arm cpuidle core code in the future when
> > a new platform is added.
> [...]
> > diff --git a/arch/arm/include/asm/cpuidle_ops.h b/arch/arm/include/asm/cpuidle_ops.h
> > new file mode 100644
> > index 0000000..be0a612
> > --- /dev/null
> > +++ b/arch/arm/include/asm/cpuidle_ops.h
> > @@ -0,0 +1,3 @@
> > +/*
> > + * List of cpuidle operations
> > + */
> > diff --git a/arch/arm/kernel/cpuidle.c b/arch/arm/kernel/cpuidle.c
> > index 45969f8..25e9789c 100644
> > --- a/arch/arm/kernel/cpuidle.c
> > +++ b/arch/arm/kernel/cpuidle.c
> > @@ -10,8 +10,29 @@
> >   */
> >  
> >  #include <linux/cpuidle.h>
> > +#include <linux/of.h>
> > +#include <linux/of_device.h>
> >  #include <asm/cpuidle.h>
> >  
> > +#define CPUIDLE_OPS(__x) extern struct cpuidle_ops __x ## _cpuidle_ops;
> > +#include <asm/cpuidle_ops.h>
> > +#undef CPUIDLE_OPS
> > +
> > +#define CPUIDLE_OPS(__x) __x ## _cpuidle_ops_id,
> > +enum cpuidle_ops_id {
> > +#include <asm/cpuidle_ops.h>
> > +        CPUIDLE_OPS_COUNT,
> > +};
> > +#undef CPUIDLE_OPS
> > +
> > +#define CPUIDLE_OPS(__x) [__x ## _cpuidle_ops_id ] = &__x ## _cpuidle_ops,
> > +static struct cpuidle_ops *supported_cpuidle_ops[] __initconst = {
> > +#include <asm/cpuidle_ops.h>
> > +};
> > +#undef CPUIDLE_OPS
> > +
> > +static struct cpuidle_ops cpuidle_ops[NR_CPUS];
> 
> Is there any reason why we aren't putting these structures into a linker
> section like we do for the smp operations structures?

I think it can be done with an OF_TABLE, it is a bit of shame cpuidle_ops
should work on UP too otherwise they could have been merged in
smp_ops to create cpu_ops, like arm64 does.

> The nice thing about using the linker is it makes it clearer at the
> location where we define the structure that it's actually used by
> something. Right now the structures are defined non-static in a file and
> then we have to know that a CPUIDLE_OPS() define has been made in
> another architecture specific asm header file so that this macro magic
> works. The commit text says something about multiple declarations and
> ops spread across header files, which shouldn't apply if we're using the
> linker to find these ops and merge them into an array we can iterate over.

It makes sense, see above for UP vs SMP. I wonder if we can't find
something to overcome the UP limitation nicely, the init code in
arch/arm/kernel/devtree.c is identical for smp_ops and cpuidle_ops,
apart from the CONFIG_SMP ifdeffery.

Lorenzo
