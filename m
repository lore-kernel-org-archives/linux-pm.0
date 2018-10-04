From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/6] cpuidle: menu: Fixes, optimizations and cleanups
Date: Thu, 4 Oct 2018 09:51:57 +0200
Message-ID: <20181004075157.GF19272@hirez.programming.kicks-ass.net>
References: <3510260.hvypppS8Bs@aspire.rjw.lan>
 <CAJZ5v0jYvV_C5AVMf+FhNfqsJuveYDRVOYjuOC8+yi8DPf1N6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jYvV_C5AVMf+FhNfqsJuveYDRVOYjuOC8+yi8DPf1N6w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Oct 04, 2018 at 08:55:45AM +0200, Rafael J. Wysocki wrote:
> On Tue, Oct 2, 2018 at 11:51 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > Hi All,
> >
> > This series fixes a couple of issues with the menu governor, optimizes it
> > somewhat and makes a couple of cleanups in it.  Please refer to the
> > patch changelogs for details.
> >
> > All of the changes in the series are straightforward in my view.  The
> > first two patches are fixes, the rest is optimizations and cleanups.
> 
> I'm inclined to take this stuff in for 4.20 if nobody has problems
> with it, so please have a look if you care (and you should, because
> the code in question is run on all tickless systems out there).

Looks ok to me,

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
