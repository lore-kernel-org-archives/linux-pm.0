From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 1/1] x86/platform/iosf_mbi: Remove duplicate
 definitions
Date: Wed, 25 Nov 2015 15:20:18 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1511251514580.12555@nanos>
References: <1447264769-21981-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <1447264769-21981-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Anvin <hpa@zytor.com>, Wolfram Sang <wsa@the-dreams.de>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Hock Leong Kweh <hock.leong.kweh@intel.com>
List-Id: linux-pm@vger.kernel.org

On Wed, 11 Nov 2015, Andy Shevchenko wrote:

> The read and write opcodes are global for all units on SoC and even across
> Intel SoCs. Remove duplication of corresponding constants. At the same time
> convert all current users.
> 
> No functional change.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Anvin <hpa@zytor.com>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Cc: Hock Leong Kweh <hock.leong.kweh@intel.com>
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> Since v1:
> - satisfy kbuild robot
> 
>  arch/x86/include/asm/iosf_mbi.h              | 49 +++++-----------------
>  arch/x86/platform/atom/punit_atom_debug.c    |  7 +---
>  arch/x86/platform/intel-quark/imr.c          | 28 +++++--------
>  drivers/i2c/busses/i2c-designware-baytrail.c | 17 +++-----
>  drivers/powercap/intel_rapl.c                | 10 ++---
>  drivers/thermal/intel_quark_dts_thermal.c    | 61 ++++++++++++++--------------
>  drivers/thermal/intel_soc_dts_iosf.c         | 43 ++++++++++----------

Hmm. Either we get acks of all maintainers and merge it through
tip/x86/... or we do the following:

Add the new constants w/o using them in a seperate patch and ship that
linuswards now. Then the subsystem maintainers can pick the individual
patches up and after the merge window closes we remove the old
constants in one go.

Either way works for me.

Thanks,

	tglx
