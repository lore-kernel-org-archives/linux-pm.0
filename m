From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 0/4] Utilization estimation (util_est) for FAIR tasks
Date: Wed, 13 Dec 2017 17:03:57 +0100
Message-ID: <20171213160357.3se4vvyo5lqud2uo@hirez.programming.kicks-ass.net>
References: <20171205171018.9203-1-patrick.bellasi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171205171018.9203-1-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Dec 05, 2017 at 05:10:14PM +0000, Patrick Bellasi wrote:
> With this feature enabled, the measured overhead is in the range of ~1%
> on the same HW/SW test configuration.

That's quite a lot; did you look where that comes from?
