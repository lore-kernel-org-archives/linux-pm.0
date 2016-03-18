From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] powercap: intel_rapl: PSys support
Date: Fri, 18 Mar 2016 10:52:40 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1603181051420.3978@nanos>
References: <1458253409-13318-1-git-send-email-srinivas.pandruvada@linux.intel.com> <20160317225100.GA3805@pd.tnic> <1458255363.3861.40.camel@linux.intel.com> <20160317185532.7ab0adc5@yairi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:35963 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751280AbcCRJyS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 18 Mar 2016 05:54:18 -0400
In-Reply-To: <20160317185532.7ab0adc5@yairi>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Borislav Petkov <bp@suse.de>, rjw@rjwysocki.net, linux-pm@vger.kernel.org, mingo@redhat.com, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>

On Thu, 17 Mar 2016, Jacob Pan wrote:

> On Thu, 17 Mar 2016 15:56:03 -0700
> Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> wrote:
> 
> > > > +#define MSR_PLATFORM_ENERGY_STATUS	0x0000064d
> > > > +#define MSR_PLATFORM_POWER_LIMIT	0x0000065c  
> > > Please add those defines to intel_rapl.c as they're being used only
> > > there, apparently.  
> > OK. I will move them.
> 
> I think it could be used by perf rapl pmu also, but later.

Right. And they should be added to perf _BEFORE_ that powercap stuff utilizes
them.

Thanks,

	tglx

