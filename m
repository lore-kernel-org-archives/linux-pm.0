From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 3/6] sched: Add over-utilization/tipping point
 indicator
Date: Mon, 9 Apr 2018 13:49:32 +0200
Message-ID: <20180409114932.GY4082@hirez.programming.kicks-ass.net>
References: <20180320094312.24081-1-dietmar.eggemann@arm.com>
 <20180320094312.24081-4-dietmar.eggemann@arm.com>
 <20180409094001.GZ4043@hirez.programming.kicks-ass.net>
 <093ba425-4f81-9f86-78a6-1cd1fd4651f9@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <093ba425-4f81-9f86-78a6-1cd1fd4651f9@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org, Quentin Perret <quentin.perret@arm.com>, Thara Gopinath <thara.gopinath@linaro.org>, linux-pm@vger.kernel.org, Morten Rasmussen <morten.rasmussen@arm.com>, Chris Redpath <chris.redpath@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Valentin Schneider <valentin.schneider@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Apr 09, 2018 at 11:53:00AM +0200, Dietmar Eggemann wrote:
> But the patch changes this part further down.

Yes.. let's call it Monday morning sickness :-)
