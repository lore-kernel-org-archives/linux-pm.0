From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v10 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq
 HW driver
Date: Thu, 22 Nov 2018 10:37:08 +0530
Message-ID: <20181122050708.zictqzfne6odsywu@vireshk-i7>
References: <1542796967-5949-1-git-send-email-tdas@codeaurora.org>
 <1542796967-5949-3-git-send-email-tdas@codeaurora.org>
 <20181121220614.GU22824@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181121220614.GU22824@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Kaehlcke <mka@chromium.org>
Cc: Taniya Das <tdas@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>, Rajendra Nayak <rnayak@codeaurora.org>, devicetree@vger.kernel.org, robh@kernel.org, skannan@codeaurora.org, linux-arm-msm@vger.kernel.org, amit.kucheria@linaro.org, evgreen@google.com
List-Id: linux-pm@vger.kernel.org

On 21-11-18, 14:06, Matthias Kaehlcke wrote:
> On Wed, Nov 21, 2018 at 04:12:47PM +0530, Taniya Das wrote:
> > +	.boost_enabled	= true,
> 
> I have no real expertise with cpufreq boost, but after reading a bit
> through cpufreq code this seems wrong. Boost is enabled statically,
> however the driver has neither a ->set_boost function nor does it call
> cpufreq_enable_boost_support() which would use a default
> implementation for ->set_boost. As a result boost support is
> effectively disabled:
> 
> static bool cpufreq_boost_supported(void)
> {
>         return likely(cpufreq_driver) && cpufreq_driver->set_boost;
> }
> 
> The driver should probably do the same as cpufreq-dt.c and call
> cpufreq_enable_boost_support() if boost frequencies are available,
> instead of 'enabling' boost statically.

Feels like I have written the boost support in cpufreq core few decades back as
I don't remember any of it :)

But reading through the code this is what I understood.

There are two parts of boosting.

- Sysfs file available or not to enable/disable boost frequencies on the go.
  This file gets created only when cpufreq_enable_boost_support() gets called.

- Will cpufreq core consider boost frequencies or not while checking target
  frequency again, this is governed by cpufreq_driver->boost field, which can be
  set from driver or using the sysfs file mentioned above.

In this driver, all we have done is to set the cpufreq_driver->boost field to
true, which would allow cpufreq core to use boost frequencies as well. But that
isn't any better than making them all normal frequencies and getting rid of
boost stuff. The boosting stuff will be useful only if you want to disable some
of them at runtime, based on heating, etc. And that is possible only after you
create a sysfs file.

-- 
viresh
