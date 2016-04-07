From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] drivers/idle: make intel_idle.c driver more explicitly
 non-modular
Date: Thu, 7 Apr 2016 17:53:55 +0100
Message-ID: <20160407165355.GA9188@linaro.org>
References: <1459099777-4962-1-git-send-email-paul.gortmaker@windriver.com>
 <20160404195535.GQ1778@windriver.com>
 <20160405031152.GA22836@linutronix.de>
 <1A7043D5F58CCB44A599DFD55ED4C94846A1C854@fmsmsx115.amr.corp.intel.com>
 <20160405043017.GA24357@linutronix.de>
 <1A7043D5F58CCB44A599DFD55ED4C94846A1CD40@fmsmsx115.amr.corp.intel.com>
 <20160405073312.GA30124@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160405073312.GA30124@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: rcochran@linutronix.de
Cc: "Brown, Len" <len.brown@intel.com>, "Gortmaker, Paul (Wind River)" <paul.gortmaker@windriver.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Apr 05, 2016 at 09:33:12AM +0200, rcochran@linutronix.de wrote:
> On Tue, Apr 05, 2016 at 05:53:47AM +0000, Brown, Len wrote:
> > > On Tue, Apr 05, 2016 at 04:20:47AM +0000, Brown, Len wrote:
> > > > No, I do not believe that cpuidle should bother
> > > > supporting changing idle drivers at run-time.
> > > 
> > > Huh?  But you just said, "it would be good to be able to unload it
> > > when it doesn't probe."
> > 
> > being able to switch the registered driver at run-time
> > does not require the driver to be modular.
> 
> Uh, right, but you don't think that the cpuidle core should allow
> changing drivers.  If it doesn't allowing changing drivers, then there
> would be just one choice, compiled in, and thus none of the drivers
> should be modular.

Actually, the modular support has been removed from almost all the cpuidle
drivers and the cpuidle framework is no longer assuming driver could
be unloaded.

The cpuidle drivers are very arch/platform specific and the acpi vs
something is an exception and could be handled differently than
converting to modular again.

I don't see the point on removing a cpuidle driver at runtime to
something else.

Removing the modular dead code in the driver makes sense as this
what have been done in the others drivers.

  -- Daniel
