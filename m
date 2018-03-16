From: Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [RFT][PATCH v4 3/7] sched: idle: Do not stop the tick before
 cpuidle_idle_call()
Date: Fri, 16 Mar 2018 15:17:20 +0100
Message-ID: <20180316141719.GB20981@lerouge>
References: <2352117.3UUoYAu18A@aspire.rjw.lan>
 <3550231.xNMJN5JcLx@aspire.rjw.lan>
 <20180315181858.GA14983@lerouge>
 <CAJZ5v0jGi_ewnJXxwuY1-y6Ti64Y601A4DQuDhtMJ+riYPJpzA@mail.gmail.com>
 <CAJZ5v0hGsXV8HTKC8iS0pD6VLoe8pDutos7NhWPU+wid_q7Now@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hGsXV8HTKC8iS0pD6VLoe8pDutos7NhWPU+wid_q7Now@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Peter Zijlstra <peterz@infradead.org>, Linux PM <linux-pm@vger.kernel.org>, Frederic Weisbecker <fweisbec@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Thomas Ilsche <thomas.ilsche@tu-dresden.de>, Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@surriel.com>, Aubrey Li <aubrey.li@linux.intel.com>, Mike Galbraith <mgalbraith@suse.de>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Mar 15, 2018 at 10:12:57PM +0100, Rafael J. Wysocki wrote:
> On Thu, Mar 15, 2018 at 9:41 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > On Thu, Mar 15, 2018 at 7:19 PM, Frederic Weisbecker
> > <frederic@kernel.org> wrote:
> >> On Mon, Mar 12, 2018 at 10:53:25AM +0100, Rafael J. Wysocki wrote:
> >>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>>
> >>> Make cpuidle_idle_call() decide whether or not to stop the tick.
> >>>
> >>> First, the cpuidle_enter_s2idle() path deals with the tick (and with
> >>> the entire timekeeping for that matter) by itself and it doesn't need
> >>> the tick to be stopped beforehand.
> >>
> >> Not sure you meant timekeeping either :)
> >
> > Yeah, I meant nohz.
> 
> Well, not really. :-)
> 
> It is the entire timekeeping this time, as it can be suspended
> entirely in that code path.

Fair point.

Thanks!
