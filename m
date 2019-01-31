From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH v2 1/5] PM / OPP: Introduce a power estimation helper
Date: Thu, 31 Jan 2019 09:34:21 +0000
Message-ID: <20190131093418.umsbh4eevgod42sh@queper01-lin>
References: <20190130170506.20450-1-quentin.perret@arm.com>
 <20190130170506.20450-2-quentin.perret@arm.com>
 <20190130190703.GM81583@google.com>
 <20190131072209.nhbgid3cystvr2p5@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190131072209.nhbgid3cystvr2p5@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Matthias Kaehlcke <mka@chromium.org>, sudeep.holla@arm.com, rjw@rjwysocki.net, nm@ti.com, sboyd@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dietmar.eggemann@arm.com
List-Id: linux-pm@vger.kernel.org

On Thursday 31 Jan 2019 at 12:52:09 (+0530), Viresh Kumar wrote:
> On 30-01-19, 11:07, Matthias Kaehlcke wrote:
> > On Wed, Jan 30, 2019 at 05:05:02PM +0000, Quentin Perret wrote:
> > > +static int __maybe_unused _get_cpu_power(unsigned long *mW, unsigned long *kHz,
> > > +					 int cpu)
> > 
> > why __maybe_unused?
> 
> Yeah, it isn't required I think. He probably added it for the case
> where CONFIG_ENERGY_MODEL=n, but even then an inline routine is
> defined which will accept it as argument and wouldn't do anything with
> it. Had it been a macro, we would have required __maybe_unused but not
> now.

The thing is, the EM_DATA_CB() macro _is_ stubbed for
CONFIG_ENERGY_MODEL=n:

https://elixir.bootlin.com/linux/v5.0-rc4/source/include/linux/energy_model.h#L165

So, without __maybe_unused you get do get a compiler warning.

Thanks,
Quentin

> 
> -- 
> viresh
