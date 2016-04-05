From: rcochran@linutronix.de
Subject: Re: [PATCH] drivers/idle: make intel_idle.c driver more explicitly
 non-modular
Date: Tue, 5 Apr 2016 09:33:12 +0200
Message-ID: <20160405073312.GA30124@linutronix.de>
References: <1459099777-4962-1-git-send-email-paul.gortmaker@windriver.com>
 <20160404195535.GQ1778@windriver.com>
 <20160405031152.GA22836@linutronix.de>
 <1A7043D5F58CCB44A599DFD55ED4C94846A1C854@fmsmsx115.amr.corp.intel.com>
 <20160405043017.GA24357@linutronix.de>
 <1A7043D5F58CCB44A599DFD55ED4C94846A1CD40@fmsmsx115.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:36828 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751785AbcDEHdW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 5 Apr 2016 03:33:22 -0400
Content-Disposition: inline
In-Reply-To: <1A7043D5F58CCB44A599DFD55ED4C94846A1CD40@fmsmsx115.amr.corp.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: "Gortmaker, Paul (Wind River)" <paul.gortmaker@windriver.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Tue, Apr 05, 2016 at 05:53:47AM +0000, Brown, Len wrote:
> > On Tue, Apr 05, 2016 at 04:20:47AM +0000, Brown, Len wrote:
> > > No, I do not believe that cpuidle should bother
> > > supporting changing idle drivers at run-time.
> > 
> > Huh?  But you just said, "it would be good to be able to unload it
> > when it doesn't probe."
> 
> being able to switch the registered driver at run-time
> does not require the driver to be modular.

Uh, right, but you don't think that the cpuidle core should allow
changing drivers.  If it doesn't allowing changing drivers, then there
would be just one choice, compiled in, and thus none of the drivers
should be modular.

Or what do you mean?

Confused,
Richard

