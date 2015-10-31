From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] cpufreq: arm_big_little: fix frequency check when bL switcher is active
Date: Sat, 31 Oct 2015 03:34:05 +0100
Message-ID: <11584056.2Z0CdQiHeS@vostro.rjw.lan>
References: <1445421333.2916.13.camel@linaro.org> <20151021095725.GA7784@ubuntu> <1446202098.2815.8.camel@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1446202098.2815.8.camel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Jon Medhurst (Tixy)" <tixy@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>
List-Id: linux-pm@vger.kernel.org

On Friday, October 30, 2015 10:48:18 AM Jon Medhurst wrote:
> On Wed, 2015-10-21 at 15:27 +0530, Viresh Kumar wrote:
> > On 21-10-15, 10:55, Jon Medhurst (Tixy) wrote:
> > > The check for correct frequency being set in bL_cpufreq_set_rate is
> > > broken when the big.LITTLE switcher is active, for two reasons.
> > > 
> > > 1. The 'new_rate' variable gets overwritten before the test by the
> > > code calculating the frequency of the old cluster.
> > > 
> > > 2. The frequency returned by bL_cpufreq_get_rate will be the virtual
> > > frequency, not the actual one the intended version of new_rate contains.
> > > 
> > > This means the function always returns an error causing an endless
> > > stream of: "cpufreq: __target_index: Failed to change cpu frequency: -5"
> > > 
> > > As the intent is to check for errors that clk_set_rate doesn't report
> > > lets move the check to immediately after that and directly use
> > > clk_get_rate, rather than the arm_big_little helpers which only confuse
> > > matters. Also, update the comment to be hopefully clearer about the
> > > purpose of the code.
> > > 
> > > Fixes: 0a95e630b49a ("cpufreq: arm_big_little: check if the frequency is set correctly")
> > > 
> > > Signed-off-by: Jon Medhurst <tixy@linaro.org>
> > > Acked-by: Sudeep Holla <sudeep.holla@arm.com>
> > > ---
> > > 
> [...]
> > 
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > 
> 
> Do I need to send this again with that Ack and Michael's Reviewed-by
> added?

Nope, it's on my to-do list.

Thanks,
Rafael
