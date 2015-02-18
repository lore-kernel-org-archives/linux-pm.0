From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] PM-Trace: add pm-trace support for suspending phase
Date: Wed, 18 Feb 2015 08:13:49 +0100
Message-ID: <2560707.D2ZlsDH2Ex@vostro.rjw.lan>
References: <54E00347.1070307@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:50770 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751402AbbBRGuf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 Feb 2015 01:50:35 -0500
In-Reply-To: <54E00347.1070307@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Fu, Zhonghui" <zhonghui.fu@linux.intel.com>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, pavel@ucw.cz, len.brown@intel.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org

On Sunday, February 15, 2015 10:24:07 AM Fu, Zhonghui wrote:
> Occasionally, the system can't come back up after suspend/resume
> due to problems of device suspending phase. This patch make
> PM_TRACE infrastructure cover device suspending phase of
> suspend/resume process, and the information in RTC can tell
> developers which device suspending function make system hang.
> 
> Signed-off-by: Zhonghui Fu <zhonghui.fu@linux.intel.com>
> ---
> Changes in v2:
>  - Add -M option so that the rename and changes can be reviewed much easier.
> 
>  arch/x86/include/asm/pm-trace.h              |   36 ++++++++++++++++++++++++++
>  arch/x86/include/asm/resume-trace.h          |   21 ---------------
>  drivers/base/power/main.c                    |   20 +++++++++++---
>  drivers/base/power/trace.c                   |    6 ++--
>  include/linux/{resume-trace.h => pm-trace.h} |    9 +++---
>  kernel/power/main.c                          |    2 +-
>  6 files changed, 61 insertions(+), 33 deletions(-)
>  create mode 100644 arch/x86/include/asm/pm-trace.h
>  delete mode 100644 arch/x86/include/asm/resume-trace.h
>  rename include/linux/{resume-trace.h => pm-trace.h} (75%)
> 
> diff --git a/arch/x86/include/asm/pm-trace.h b/arch/x86/include/asm/pm-trace.h
> new file mode 100644
> index 0000000..09bd918
> --- /dev/null
> +++ b/arch/x86/include/asm/pm-trace.h
> @@ -0,0 +1,36 @@
> +#ifndef _ASM_X86_PM_TRACE_H
> +#define _ASM_X86_PM_TRACE_H
> +
> +#include <asm/asm.h>
> +
> +#define TRACE_RESUME(user)					\
> +do {								\
> +	if (pm_trace_enabled) {					\
> +		const void *tracedata;				\
> +		asm volatile(_ASM_MOV " $1f,%0\n"		\
> +			     ".section .tracedata,\"a\"\n"	\
> +			     "1:\t.word %c1\n\t"		\
> +			     _ASM_PTR " %c2\n"			\
> +			     ".previous"			\
> +			     :"=r" (tracedata)			\
> +			     : "i" (__LINE__), "i" (__FILE__));	\
> +		generate_pm_trace(tracedata, user);		\
> +	}							\
> +} while (0)
> +
> +#define TRACE_SUSPEND(user)					\
> +do {								\
> +	if (pm_trace_enabled) {					\
> +		const void *tracedata;				\
> +		asm volatile(_ASM_MOV " $1f,%0\n"		\
> +			     ".section .tracedata,\"a\"\n"	\
> +			     "1:\t.word %c1\n\t"		\
> +			     _ASM_PTR " %c2\n"			\
> +			     ".previous"			\
> +			     :"=r" (tracedata)			\
> +			     : "i" (__LINE__), "i" (__FILE__));	\
> +		generate_pm_trace(tracedata, user);		\
> +	}							\
> +} while (0)

Are those macros identical or am I missing anything?

If they are identical, why do we need two identical macros?


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
