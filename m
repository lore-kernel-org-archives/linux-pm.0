From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 02/11] tools/power turbostat: Use Intel family processor
 macros
Date: Fri, 14 Oct 2016 13:56:36 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1610141354090.11707@nanos>
References: <20161013153105.2517-1-piotr.luc@intel.com> <20161013153105.2517-3-piotr.luc@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:60188 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754366AbcJNL74 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Oct 2016 07:59:56 -0400
In-Reply-To: <20161013153105.2517-3-piotr.luc@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Piotr Luc <piotr.luc@intel.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Doug Thompson <dougthompson@xmission.com>, Borislav Petkov <bp@alien8.de>, linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

On Thu, 13 Oct 2016, Piotr Luc wrote:
> +	case INTEL_FAM6_NEHALEM_EP:		/* Core i7, Xeon 5500 series - Bloomfield, Gainstown NHM-EP */

What's the point of keeping all those comments around?

> +	case INTEL_FAM6_SANDYBRIDGE:		/* SNB */

Especialy those, which are completely useless?

The defines are there to be self explaining and the extra verbose
information should be in the header file defining the macros and not in the
source code.

Thanks,

	tglx
