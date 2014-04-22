From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] sched / idle: Make cpuidle_idle_call() void
Date: Tue, 22 Apr 2014 13:49:30 +0200
Message-ID: <20140422114930.GH11182@twins.programming.kicks-ass.net>
References: <4717784.WmVEpDoliM@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4717784.WmVEpDoliM@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Apr 21, 2014 at 01:26:58AM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The only value ever returned by cpuidle_idle_call() is 0 and its
> only caller ignores that value anyway, so make it void.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Thanks!
