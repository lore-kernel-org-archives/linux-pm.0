From: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH v10 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq
 HW driver
Date: Mon, 26 Nov 2018 15:30:15 -0800
Message-ID: <20181126233015.GX22824@google.com>
References: <1542796967-5949-1-git-send-email-tdas@codeaurora.org>
 <1542796967-5949-3-git-send-email-tdas@codeaurora.org>
 <20181121220614.GU22824@google.com>
 <20181122050708.zictqzfne6odsywu@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181122050708.zictqzfne6odsywu@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Taniya Das <tdas@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>, Rajendra Nayak <rnayak@codeaurora.org>, devicetree@vger.kernel.org, robh@kernel.org, skannan@codeaurora.org, linux-arm-msm@vger.kernel.org, amit.kucheria@linaro.org, evgreen@google.com
List-Id: linux-pm@vger.kernel.org

On Thu, Nov 22, 2018 at 10:37:08AM +0530, Viresh Kumar wrote:
> On 21-11-18, 14:06, Matthias Kaehlcke wrote:
> > On Wed, Nov 21, 2018 at 04:12:47PM +0530, Taniya Das wrote:
> > > +	.boost_enabled	= true,
> > 
> > I have no real expertise with cpufreq boost, but after reading a bit
> > through cpufreq code this seems wrong. Boost is enabled statically,
> > however the driver has neither a ->set_boost function nor does it call
> > cpufreq_enable_boost_support() which would use a default
> > implementation for ->set_boost. As a result boost support is
> > effectively disabled:
> > 
> > static bool cpufreq_boost_supported(void)
> > {
> >         return likely(cpufreq_driver) && cpufreq_driver->set_boost;
> > }
> > 
> > The driver should probably do the same as cpufreq-dt.c and call
> > cpufreq_enable_boost_support() if boost frequencies are available,
> > instead of 'enabling' boost statically.
> 
> Feels like I have written the boost support in cpufreq core few decades back as
> I don't remember any of it :)
> 
> But reading through the code this is what I understood.

Thanks for digging into it!

> There are two parts of boosting.
> 
> - Sysfs file available or not to enable/disable boost frequencies on the go.
>   This file gets created only when cpufreq_enable_boost_support() gets called.
> 
> - Will cpufreq core consider boost frequencies or not while checking target
>   frequency again, this is governed by cpufreq_driver->boost field, which can be
>   set from driver or using the sysfs file mentioned above.
> 
> In this driver, all we have done is to set the cpufreq_driver->boost field to
> true, which would allow cpufreq core to use boost frequencies as well. But that
> isn't any better than making them all normal frequencies and getting rid of
> boost stuff. The boosting stuff will be useful only if you want to disable some
> of them at runtime, based on heating, etc. And that is possible only after you
> create a sysfs file.

That matches what Amit reported (and I confirmed) about the CPU
frequency "being stuck" at the boost frequency
(https://lore.kernel.org/patchwork/patch/998335/#1186701) on a loaded
system.

Taniya: I wonder if it would make sense to drop boost support for now
in order to land a first working version of the driver soon, instead
of keeping respinning this series. Boost support could be added as a
separate feature, just like cooling devices. If you have a working
quick fix now that's also fine, otherwise I'd suggest the iterative
approach, I'm sure you also want to see this landing ;-)

Cheers

Matthias
