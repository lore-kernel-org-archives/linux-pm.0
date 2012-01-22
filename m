From: Sylwester Nawrocki <sylvester.nawrocki-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c-s3c2410: Add stub runtime power management
Date: Sun, 22 Jan 2012 18:22:14 +0100
Message-ID: <4F1C45C6.1040003@gmail.com>
References: <1327171600-5489-1-git-send-email-broonie@opensource.wolfsonmicro.com> <4F1C082D.2080005@gmail.com> <20120122152234.GA2915@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120122152234.GA2915-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 01/22/2012 04:22 PM, Mark Brown wrote:
> On Sun, Jan 22, 2012 at 01:59:25PM +0100, Sylwester Nawrocki wrote:
>> How about the following patch (untested) ? It might be a better start for
>> proper power management implementation and would still allow the driver
>> to work on platforms that don't support runtime PM.
> 
> It's not really a platform issue - the platform bus by default does the
> right thing and the runtime PM core is pure software, the only platform
> dependency is if users have bothered truning runtime PM on.

It is a platform (SoC) issue in terms of enabling PM_RUNTIME, which is 
pure software, as you're pointing out. I think we agree here that the 
only issue is that some (ill) platforms refuse to enable PM_RUNTIME.

And clock gating belongs to runtime PM, which this I2C controller driver
chooses to implement without runtime PM awareness. 

>> +static inline int s3c24xx_pm_runtime_put(struct s3c24xx_i2c *i2c)
>> +{
>> +	if (!pm_runtime_enabled(i2c->dev)) {
>> +		clk_disable(i2c->clk);
>> +		return 0;
>> +	}
>> +
>> +	return pm_runtime_put(i2c->dev);
>> +}
> 
> To be honest I don't think this is worth it.  Either we just keep the
> clock management outside of runtime PM or we push it in but trying to
> support both simultaneously adds complication and doesn't actually do
> all that much in practical terms.

It's not pretty, I agree. However it is supposed to be more a temporary
solution, rather than anything final. And it probably is better at 
avoiding any races and mismatch between real device state and the PM core
knowledge of it. I'm not going to persuade my version too much, it's far
from prefect, similarly as the original patch in this thread. The best 
solution would be to force platform to enable PM_RUNTIME if they want to
use a driver which does runtime PM. But this has to wait, yet, probably
infinitely.. :)
