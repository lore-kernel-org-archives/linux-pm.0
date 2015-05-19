From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/2] PM / sleep: Make ->enter_freeze callbacks depend on
 CONFIG_SUSPEND
Date: Tue, 19 May 2015 17:00:26 +0200
Message-ID: <20150519150026.GE3644@twins.programming.kicks-ass.net>
References: <7138791.PFSSF2gqXk@vostro.rjw.lan>
 <2834114.lD6BFXhtqK@vostro.rjw.lan>
 <20150518121826.GG21418@twins.programming.kicks-ass.net>
 <4721283.2H3KXdSq7L@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4721283.2H3KXdSq7L@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

On Mon, May 18, 2015 at 11:45:10PM +0200, Rafael J. Wysocki wrote:
> On Monday, May 18, 2015 02:18:26 PM Peter Zijlstra wrote:
> > On Sat, May 16, 2015 at 01:38:48AM +0200, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > 
> > > The ->enter_freeze callbacks of cpuidle drivers are only used if
> > > CONFIG_SUSPEND is set, so make them explicitly depend on that
> > > Kconfig option.
> > 
> > No real objection, but is it worth it to sprinkle that CONFIG stuff over
> > all drivers?
> 
> Well, you maybe right that it isn't.  The footprint is small anyway.
> 
> What about [1/2]?

1/2 looks fine to me.
