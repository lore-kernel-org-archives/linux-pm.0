From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH] powercap: intel_rapl: PSys support
Date: Thu, 17 Mar 2016 18:55:32 -0700
Message-ID: <20160317185532.7ab0adc5@yairi>
References: <1458253409-13318-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	<20160317225100.GA3805@pd.tnic>
	<1458255363.3861.40.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:4038 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750705AbcCRBze (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 17 Mar 2016 21:55:34 -0400
In-Reply-To: <1458255363.3861.40.camel@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Borislav Petkov <bp@suse.de>, rjw@rjwysocki.net, linux-pm@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, x86@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org, jacob.jun.pan@linux.intel.com

On Thu, 17 Mar 2016 15:56:03 -0700
Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> wrote:

> > > +#define MSR_PLATFORM_ENERGY_STATUS	0x0000064d
> > > +#define MSR_PLATFORM_POWER_LIMIT	0x0000065c  
> > Please add those defines to intel_rapl.c as they're being used only
> > there, apparently.  
> OK. I will move them.

I think it could be used by perf rapl pmu also, but later.
