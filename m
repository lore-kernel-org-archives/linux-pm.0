From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH RFC] cpuidle/drivers/menu: Remove get_loadavg in the performance multiplier
Date: Wed, 03 Oct 2018 10:58:16 +0200
Message-ID: <4200780.ZjVhNjpZ67@aspire.rjw.lan>
References: <1537868328-13405-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1537868328-13405-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: linux-pm@vger.kernel.org, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Colin Cross <ccross@android.com>, Ramesh Thomas <ramesh.thomas@intel.com>, Alex Shi <alex.shi@linaro.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, September 25, 2018 11:38:44 AM CEST Daniel Lezcano wrote:
> The function get_loadavg() returns almost always zero. To be more
> precise, statistically speaking for a total of 1023379 times passing
> to the function, the load is equal to zero 1020728 times, greater than
> 100, 610 times, the remaining is between 0 and 5.
> 
> I'm putting in question this metric. Is it worth to keep it?

The honest answer is that I'm not sure.

Using the CPU load for driving idle state selection is questionable in general
(there need not be any connection between the two in principle) and this
particular function is questionable either.  If it really makes no difference
in addition to that, then yes it would be good to get rid of it.

That said it looks like that may be quite workload-dependent, so maybe there
are workloads where it does make a difference?  Like networking or similar?

Thanks,
Rafael
