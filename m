From: Tejun Heo <tj@kernel.org>
Subject: Re: [RFC v3 0/5] Add capacity capping support to the CPU controller
Date: Mon, 20 Mar 2017 10:51:31 -0400
Message-ID: <20170320145131.GA3623@htj.duckdns.org>
References: <1488292722-19410-1-git-send-email-patrick.bellasi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1488292722-19410-1-git-send-email-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Paul Turner <pjt@google.com>, Vincent Guittot <vincent.guittot@linaro.org>, John Stultz <john.stultz@linaro.org>, Todd Kjos <tkjos@android.com>, Tim Murray <timmurray@google.com>, Andres Oportus <andresoportus@google.com>, Joel Fernandes <joelaf@google.com>, Juri Lelli <juri.lelli@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>
List-Id: linux-pm@vger.kernel.org

Hello, Patrick.

On Tue, Feb 28, 2017 at 02:38:37PM +0000, Patrick Bellasi wrote:
>  a) Boosting of important tasks, by enforcing a minimum capacity in the
>     CPUs where they are enqueued for execution.
>  b) Capping of background tasks, by enforcing a maximum capacity.
>  c) Containment of OPPs for RT tasks which cannot easily be switched to
>     the usage of the DL class, but still don't need to run at the maximum
>     frequency.

As this is something completely new, I think it'd be a great idea to
give a couple concerete examples in the head message to help people
understand what it's for.

Thanks.

-- 
tejun
