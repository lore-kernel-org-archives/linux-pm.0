From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH V5] powercap/drivers/idle_injection: Add an idle
 injection framework
Date: Thu, 7 Jun 2018 11:09:28 +0200
Message-ID: <20180607090928.GK12198@hirez.programming.kicks-ass.net>
References: <1528190208-22915-1-git-send-email-daniel.lezcano@linaro.org>
 <20180606122357.GN12258@hirez.programming.kicks-ass.net>
 <22f5cf0b-049e-7938-55f6-4b4b154f8389@linaro.org>
 <20180606150203.GE12180@hirez.programming.kicks-ass.net>
 <ea347237-7cef-095a-5ddb-19c181d10c23@linaro.org>
 <20180607083229.GJ12198@hirez.programming.kicks-ass.net>
 <20180607084251.rv2tg3kgz4aohlpd@vireshk-i7>
 <9996fb40-c7aa-db61-5445-52c146f44d85@linaro.org>
 <20180607084921.toctrooftl6y7kkx@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180607084921.toctrooftl6y7kkx@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>, Javi Merino <javi.merino@kernel.org>, Leo Yan <leo.yan@linaro.org>, Kevin Wangtao <kevin.wangtao@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Rui Zhang <rui.zhang@intel.com>, Daniel Thompson <daniel.thompson@linaro.org>, "open list:POWER MANAGEMENT CORE" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Jun 07, 2018 at 02:19:21PM +0530, Viresh Kumar wrote:
> On 07-06-18, 10:46, Daniel Lezcano wrote:
> > Yes, correct.
> > 
> > But if we don't care about who wins to store to value, is there a risk
> > of scramble variable if we just assign a value ?
> 
> Normally no, as the compiler wouldn't screw it up badly. But there is no rule
> which stops the compiler from doing this:
> 
> idle_duration_ms = 5;
> idle_duration_ms = -5;
> idle_duration_ms = 0;
> idle_duration_ms = <real-value-we-want-to-write>;
> 
> So we *must* use READ/WRITE_ONCE() to make sure garbage values aren't seen by
> readers.

That too, however it is far worse..

The compiler is allowed to do store/load-tearing. Basically it can emit
individual byte store/loads in any random order.

So:
	foo = bar = 0;

	P0			P1

	foo = 0x12345678;	bar = foo;

Could result in: bar == 0x12005600 or any other random combination.

Now, it generally doesn't do this, because it is really retarded to
generate code like that. But we've seen cases where it managed to do
really weird things (think constructing 64bit literals with two or more
smaller stores, which total smaller code).

The volatile in READ/WRITE_ONCE() disallows this and ensures the
variables are read / written in a single go (assuming naturally aligned
native word sizes).
