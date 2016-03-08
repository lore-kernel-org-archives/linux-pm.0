From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v6 0/4] powercap/rapl: reduce ipi calls and misc clean
 up
Date: Tue, 8 Mar 2016 08:57:54 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1603080857310.3859@nanos>
References: <1456349498-1527-1-git-send-email-jacob.jun.pan@linux.intel.com> <20160307170642.31af8b7e@icelake>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:49243 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932180AbcCHH7U (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 8 Mar 2016 02:59:20 -0500
In-Reply-To: <20160307170642.31af8b7e@icelake>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Rusty Russell <rusty@rustcorp.com.au>

On Mon, 7 Mar 2016, Jacob Pan wrote:

> On Wed, 24 Feb 2016 13:31:34 -0800
> Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:
> 
> > Changes since v5:
> > 	- Split changes into seprate patches. No code change.
> > Changes since V4:
> > 	- Deleted unnecessary cpumask_any_and() call, assign first
> > cpu as lead Changes since V3:
> > 	- Avoid for_each_online_cpu() search for per package MSR
> > access. This is achieved by tracking a per package lead cpu via
> > cpumask_xx() calls. (suggested by Thomas Gleixner
> > <tglx@linutronix.de>)
> > 	    - Add direct reference of RAPL package for each RAPL
> > domain.
> > 
> > Jacob Pan (4):
> >   cpumask: export cpumask_any_but
> >   powercap/rapl: reduce ipi calls
> >   powercap/rapl: add package reference per domain
> >   powercap/rapl: track lead cpu per package
> > 
> >  drivers/powercap/intel_rapl.c | 220
> > ++++++++++++++++++++++--------------------
> > lib/cpumask.c                 |   1 + 2 files changed, 115
> > insertions(+), 106 deletions(-)
> > 
> Hi Thomas,
> 
> Do you have more comments?

No. Looks reasonable now.
