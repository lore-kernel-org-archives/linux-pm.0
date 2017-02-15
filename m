From: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 6/9] arm, arm64: factorize common cpu capacity default code
Date: Wed, 15 Feb 2017 17:17:05 -0600
Message-ID: <CAL_JsqKLiQ2cSffadMWbN2PkqBOiA-6Mx5YVMCehVQNpy7YqrQ@mail.gmail.com>
References: <20170209092525.6654-1-juri.lelli@arm.com> <20170209092525.6654-7-juri.lelli@arm.com>
 <20170210142857.GA18321@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170210142857.GA18321-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: Juri Lelli <juri.lelli-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Morten Rasmussen <morten.rasmussen-5wv7dgnIgG8@public.gmane.org>, dietmar.eggemann-5wv7dgnIgG8@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Feb 10, 2017 at 8:28 AM, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org> wrote:
> On Thu, Feb 09, 2017 at 09:25:22AM +0000, Juri Lelli wrote:
>> arm and arm64 share lot of code relative to parsing CPU capacity
>> information from DT, using that information for appropriate scaling and
>> exposing a sysfs interface for chaging such values at runtime.
>>
>> Factorize such code in a common place (driver/base/arch_topology.c) in
>> preparation for further additions.
>>
>> Suggested-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
>> Suggested-by: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
>> Suggested-by: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>
>> Cc: Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
>> Cc: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>
>> Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
>> Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
>> Signed-off-by: Juri Lelli <juri.lelli-5wv7dgnIgG8@public.gmane.org>
>> ---
>>
>> Changes from v1:
>>  - keep the original GPLv2 header
>> ---
>>  arch/arm/Kconfig             |   1 +
>>  arch/arm/kernel/topology.c   | 213 ++------------------------------------
>>  arch/arm64/Kconfig           |   1 +
>>  arch/arm64/kernel/topology.c | 219 +--------------------------------------
>>  drivers/base/Kconfig         |   8 ++
>>  drivers/base/Makefile        |   1 +
>>  drivers/base/arch_topology.c | 237 +++++++++++++++++++++++++++++++++++++++++++
>>  7 files changed, 257 insertions(+), 423 deletions(-)
>>  create mode 100644 drivers/base/arch_topology.c
>
> Ah, so you want _me_ to maintain this, ok, I better review it...
>
>> --- a/drivers/base/Kconfig
>> +++ b/drivers/base/Kconfig
>> @@ -339,4 +339,12 @@ config CMA_ALIGNMENT
>>
>>  endif
>>
>> +config GENERIC_ARCH_TOPOLOGY
>> +     bool
>> +     help
>> +       Enable support for architectures common topology code: e.g., parsing
>> +       CPU capacity information from DT, usage of such information for
>> +       appropriate scaling, sysfs interface for changing capacity values at
>> +          runtime.
>
> Mix of spaces and tabs :(
>
>> +
>>  endmenu
>> diff --git a/drivers/base/Makefile b/drivers/base/Makefile
>> index f2816f6ff76a..397e5c344e6a 100644
>> --- a/drivers/base/Makefile
>> +++ b/drivers/base/Makefile
>> @@ -23,6 +23,7 @@ obj-$(CONFIG_SOC_BUS) += soc.o
>>  obj-$(CONFIG_PINCTRL) += pinctrl.o
>>  obj-$(CONFIG_DEV_COREDUMP) += devcoredump.o
>>  obj-$(CONFIG_GENERIC_MSI_IRQ_DOMAIN) += platform-msi.o
>> +obj-$(CONFIG_GENERIC_ARCH_TOPOLOGY) += arch_topology.o
>>
>>  obj-y                        += test/
>>
>> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
>> new file mode 100644
>> index 000000000000..c1dd430adad2
>> --- /dev/null
>> +++ b/drivers/base/arch_topology.c
>> @@ -0,0 +1,237 @@
>> +/*
>> + * driver/base/arch_topology.c - Arch specific cpu topology information
>
> No need to keep the filename in the file, you know what it is called :)
>
>> + *
>> + * Copyright (C) 2016, ARM Ltd.
>> + * Written by: Juri Lelli, ARM Ltd.
>> + *
>> + * This file is subject to the terms and conditions of the GNU General Public
>> + * License.  See the file "COPYING" in the main directory of this archive
>> + * for more details.
>
> So, v2 only?  Please be specific.  Even better yet, use a SPDX header if
> you want to, those are always nice.

Sorry to hijack this thread, but you're recommending SPDX now? You
seemed pretty negative on it last time it came up[1]. Or was that just
in context of the churn of converting existing files? Personally, I
like the use of SPDX tags over free form license text and would like
to encourage it for dts files.

Rob

[1] https://lkml.org/lkml/2015/2/5/65
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
