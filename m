From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/3] sched: idle: Add sched balance option
Date: Fri, 25 Apr 2014 15:22:38 +0200
Message-ID: <20140425132238.GD11096@twins.programming.kicks-ass.net>
References: <1398342291-16322-1-git-send-email-daniel.lezcano@linaro.org>
 <1398342291-16322-3-git-send-email-daniel.lezcano@linaro.org>
 <CAP245DX9wewQFhcyGj5ZuNE7hHC4fRn90POC32HLF6ugja6nJg@mail.gmail.com>
 <535911DC.9050109@linaro.org>
 <CAP245DXFRfARtEfj70XD8D8OiAT_1i_5G2zao+y0DT0Lg_YFJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAP245DXFRfARtEfj70XD8D8OiAT_1i_5G2zao+y0DT0Lg_YFJA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Amit Kucheria <amit.kucheria@linaro.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Ingo Molnar <mingo@elte.hu>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


The infinite wisdom of the original PC keyboard gifted us with backspace
and delete, use them!

On Fri, Apr 25, 2014 at 04:24:49PM +0530, Amit Kucheria wrote:
> In that case, "performance" should be the default so we don't change
> existing system behavior. And perhaps we want to keep these energy
> heuristics in a separate file, at least until we've gotten them right.

No, we're not going to make a separate file. Its going to be fully
integrated in the normal load balancer, no special add on hacks and
warts.
