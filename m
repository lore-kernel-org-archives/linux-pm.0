From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 5/6] intel_idle: Add ->enter_freeze callbacks
Date: Thu, 12 Feb 2015 17:25:25 +0100
Message-ID: <20150212162525.GW5029@twins.programming.kicks-ass.net>
References: <8292243.ibkmfVtXac@vostro.rjw.lan>
 <2407992.WHaFxrNaoa@vostro.rjw.lan>
 <20150212132643.GY23123@twins.programming.kicks-ass.net>
 <25445086.IBiaGBbm1j@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <25445086.IBiaGBbm1j@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Thomas Gleixner <tglx@linutronix.de>, Alan Cox <alan@linux.intel.com>, "Li, Aubrey" <aubrey.li@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Kristen Carlson Accardi <kristen@linux.intel.com>, John Stultz <john.stultz@linaro.org>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Feb 12, 2015 at 05:24:51PM +0100, Rafael J. Wysocki wrote:
> On Thursday, February 12, 2015 02:26:43 PM Peter Zijlstra wrote:

> > Why bother with enter_freeze() for any but the deepest state (C6 in this
> > case)?
> 
> User space may disable the deepest one (and any of them in general) via sysfs
> and there's no good reason to ignore its choice in this particular case while
> we're honoring it otherwise.
> 
> So the logic is basically "find the deepest one which isn't disabled" and
> setting the pointers costs us nothing really.
> 
> > Also, should we ignore things like intel_idle.max_cstate for this
> > selection?
> 
> No, we shouldn't.  The deeper ones may just not work then.

OK, fair enough.
