From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 0/5] powercap/intel_rapl: Fixes, hotplug conversion and
 simplifcation
Date: Thu, 24 Nov 2016 09:33:02 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1611240931580.3434@nanos>
References: <20161122210518.079483154@linutronix.de> <20161123110647.37485542@icelake> <CAJZ5v0hCtb42GOaLOA2CPBQjGAaTDxH6qTMrRQSYCOVjQGyVMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:36421 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932607AbcKXIhV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Nov 2016 03:37:21 -0500
In-Reply-To: <CAJZ5v0hCtb42GOaLOA2CPBQjGAaTDxH6qTMrRQSYCOVjQGyVMQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, Rafael Wysocki <rjw@sisk.pl>, the arch/x86 maintainers <x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Linux PM <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@intel.com>

Rafael,

On Wed, 23 Nov 2016, Rafael J. Wysocki wrote:
> On Wed, Nov 23, 2016 at 8:06 PM, Jacob Pan
> > Looks good to me. The cpu topology management is much more streamlined.
> > Thanks. I also sent out this patch below on top of yours.
> >
> > [PATCH] powercap/intel_rapl: fix and tidy up error handling
> 
> OK
> 
> Thomas, I'm assuming that this series will go in via tip.  Please let
> me know if you want me to take it instead.

It does not depend on anything in tip, so please route it through your tree.

Thanks,

	tglx
