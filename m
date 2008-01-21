From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 9/10] introduce intel_menlow platform
	specific driver
Date: Mon, 21 Jan 2008 09:53:31 +0000
Message-ID: <20080121095331.GA5333__42888.6563437574$1200930722$gmane$org@infradead.org>
References: <1200556278.2935.118.camel@acpi-sony.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1200556278.2935.118.camel@acpi-sony.sh.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, sujith.thomas@intel.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, Jan 17, 2008 at 03:51:17PM +0800, Zhang Rui wrote:
> From: Thomas Sujith <sujith.thomas@intel.com>
> 
> Intel menlow platform specific driver for thermal management.
> 
> Signed-off-by: Thomas Sujith <sujith.thomas@intel.com>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/misc/Kconfig        |   10 
>  drivers/misc/Makefile       |    1 
>  drivers/misc/intel_menlow.c |  527 ++++++++++++++++++++++++++++++++++++++++++++

Why is this in drivers/misc?  I don't have a thermal.h in mainline, but
if this is a new subsystem your adding care to create a directory under
drivers/ for it?

> +/*
> +*  intel_menlow.c - Intel menlow Driver for thermal management extension
> +*
> +*  Copyright (C) 2008 Intel Corp
> +*  Copyright (C) 2008 Sujith Thomas <sujith.thomas@intel.com>
> +*  Copyright (C) 2008 Zhang Rui <rui.zhang@intel.com>

Please add a whitespace before the * so they line up.

> +MODULE_AUTHOR("Thomas Sujith");
> +MODULE_AUTHOR("Zhang Rui");

I've never seen a driver with two MODULE_AUTHOR statements before.  Does
this actually work?  What does modinfo -F author say for your module?
