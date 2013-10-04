From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2 6/6] Introduce Intel RAPL power capping driver
Date: Fri, 04 Oct 2013 11:07:45 -0700
Message-ID: <1380910065.2081.117.camel@joe-AO722>
References: <1380904616-17519-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <1380904616-17519-7-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtprelay0003.hostedemail.com ([216.40.44.3]:35591 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750842Ab3JDSHs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 4 Oct 2013 14:07:48 -0400
In-Reply-To: <1380904616-17519-7-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, len.brown@intel.com, rjw@sisk.pl, arjan@linux.intel.com, jacob.jun.pan@linux.intel.com

On Fri, 2013-10-04 at 09:36 -0700, Srinivas Pandruvada wrote:
> The Intel Running Average Power Limit(RAPL) technology provides platform
> software with the ability to monitor, control, and get notifications on
> power usage.
[]
> diff --git a/drivers/powercap/Makefile b/drivers/powercap/Makefile
[]
> +/* bitmasks for RAPL MSRs, used by primitive access functions */
> +#define ENERGY_STATUS_MASK      0xffffffff
> +
> +#define POWER_LIMIT1_MASK       0x7FFF
> +#define POWER_LIMIT1_ENABLE     BIT(15)
> +#define POWER_LIMIT1_CLAMP      BIT(16)
> +
> +#define POWER_LIMIT2_MASK       (0x7FFFULL<<32)
> +#define POWER_LIMIT2_ENABLE     BIT_ULL(47)
> +#define POWER_LIMIT2_CLAMP      BIT_ULL(48)
> +#define POWER_PACKAGE_LOCK      BIT_ULL(63)
> +#define POWER_PP_LOCK           BIT(31)
> +
> +#define TIME_WINDOW1_MASK       (0x7F<<17)
> +#define TIME_WINDOW2_MASK       (0x7FULL<<49)


Is there a reason why these masks aren't all ULL?


