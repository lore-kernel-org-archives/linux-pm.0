From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC PATCH v2 6/8] cpuidle: make fast idle threshold tunable
Date: Tue, 17 Oct 2017 02:01:17 +0200
Message-ID: <6153229.9lQq4PJGJ7@aspire.rjw.lan>
References: <1506756034-6340-1-git-send-email-aubrey.li@intel.com> <2242303.t20yq9Lc6j@aspire.rjw.lan> <d039059f-5ff4-780e-5865-8361315896c5@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d039059f-5ff4-780e-5865-8361315896c5@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Li, Aubrey" <aubrey.li@linux.intel.com>
Cc: Aubrey Li <aubrey.li@intel.com>, tglx@linutronix.de, peterz@infradead.org, len.brown@intel.com, ak@linux.intel.com, tim.c.chen@linux.intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Monday, October 16, 2017 8:00:45 AM CEST Li, Aubrey wrote:
> On 2017/10/14 8:59, Rafael J. Wysocki wrote:
> > On Saturday, September 30, 2017 9:20:32 AM CEST Aubrey Li wrote:
> >> Add a knob to make fast idle threshold tunable
> >>
> >> Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
> > 
> > I first of all am not sure about the need to add a tunable for this at all
> > in the first place.
> 
> Actually I think a fixed value(10) might be good enough but not quite sure
> if there is a requirement to tune it for different scenario, for example even
> if the predicted idle interval is 100x overhead, I still want a fast path for
> a better benchmark score?

Any new tunables make the test matrix expand considerably, so it generally is
better to err on the conservative side with adding them.

Thanks,
Rafael
