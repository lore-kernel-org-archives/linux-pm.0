From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/4] sched / idle: Reduce the number of branches in the idle loop
Date: Mon, 04 May 2015 23:23:22 +0200
Message-ID: <21372869.SeRj1zt7yN@vostro.rjw.lan>
References: <3084951.QaIkFrZ3VU@vostro.rjw.lan> <20150504142505.GM23123@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150504142505.GM23123@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Monday, May 04, 2015 04:25:05 PM Peter Zijlstra wrote:
> On Mon, May 04, 2015 at 03:54:43PM +0200, Rafael J. Wysocki wrote:
> > Hi,
> > 
> > The "reflect" variable that had to be added to cpuidle_idle_call() to fix a
> > regression during the 4.0 cycle has bothered me a bit since then and guess
> > what?  It is not necessary.
> > 
> > After the last regression fix related to tick_broadcast_exit() I realized
> > that it should be possible to eliminate this variable by splitting
> > cpuidle_idle_call() into smaller routines and reordering the code in
> > question which is done by this patch series.
> > 
> > It also gets rid of one more redundant check while at it.
> 
> 
> Ooh nice! Yes that thing bothered me too.
> 
> Once you fix that one weird opening bracket:
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Fixed and queued up as 4.2 material, thanks!
