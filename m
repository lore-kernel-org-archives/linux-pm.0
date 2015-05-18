From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 2/2] PM / sleep: Make ->enter_freeze callbacks depend on CONFIG_SUSPEND
Date: Mon, 18 May 2015 23:45:10 +0200
Message-ID: <4721283.2H3KXdSq7L@vostro.rjw.lan>
References: <7138791.PFSSF2gqXk@vostro.rjw.lan> <2834114.lD6BFXhtqK@vostro.rjw.lan> <20150518121826.GG21418@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150518121826.GG21418@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

On Monday, May 18, 2015 02:18:26 PM Peter Zijlstra wrote:
> On Sat, May 16, 2015 at 01:38:48AM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > The ->enter_freeze callbacks of cpuidle drivers are only used if
> > CONFIG_SUSPEND is set, so make them explicitly depend on that
> > Kconfig option.
> 
> No real objection, but is it worth it to sprinkle that CONFIG stuff over
> all drivers?

Well, you maybe right that it isn't.  The footprint is small anyway.

What about [1/2]?
