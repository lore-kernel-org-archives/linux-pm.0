From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 00/09] Some kernel/time cleanups (related to timer_suspend/resume)
Date: Wed, 25 Mar 2015 13:13:51 +0100
Message-ID: <2450480.24OCjXdgSB@vostro.rjw.lan>
References: <20150216121435.203983131@infradead.org> <4241632.Wi7SZdKMQs@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4241632.Wi7SZdKMQs@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, March 25, 2015 01:04:23 PM Rafael J. Wysocki wrote:
> Hi,
> 
> On Monday, February 16, 2015 01:14:35 PM Peter Zijlstra wrote:
> > Hi,
> > 
> > While working with Rafael on the suspend to idle machinery Thomas made these
> > cleanups; since one might as well clean code up while you've done the work of
> > thinking through it again.
> > 
> > As it stands there's very little overlap between Rafael's series and this one
> > aside from a few trivial fixups. So we'll merge them seperately.
> 
> Since some of the original Thomas' patches needed to be rebased on top of the
> suspend-to-idle material that went in during the 4.0 merge window, I did
> that with the patches related to the suspending/resuming of ticks which
> follow.

I forgot to mention that I'd tested these vs suspend-to-idle and suspend-to-RAM
on a couple of different systems and they don't seem to break anything for me.

Also I have a plan to make the compilation of some PM-related stuff conditional
on CONFIG_PM_SLEEP etc. on top of these.

Rafael
