From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] i2c-s3c2410: Add stub runtime power management
Date: Sun, 22 Jan 2012 15:22:34 +0000
Message-ID: <20120122152234.GA2915@opensource.wolfsonmicro.com>
References: <1327171600-5489-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <4F1C082D.2080005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4F1C082D.2080005@gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
Cc: Wolfram Sang <w.sang@pengutronix.de>, Ben Dooks <ben-linux@fluff.org>, linux-samsung-soc@vger.kernel.org, linux-i2c@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sun, Jan 22, 2012 at 01:59:25PM +0100, Sylwester Nawrocki wrote:
> On 01/21/2012 07:46 PM, Mark Brown wrote:

> > +	pm_runtime_get_sync(&adap->dev);

> IMHO it's more appropriate to use i2c->dev here instead, i.e. to reference
> the platform device we've enabled runtime PM for.

Oh, bah humbug.  Now that I notice this I think that's the reason I
enabled runtime PM for the adaptor - it's easier to get hold of.

> How about the following patch (untested) ? It might be a better start for 
> proper power management implementation and would still allow the driver 
> to work on platforms that don't support runtime PM. 

It's not really a platform issue - the platform bus by default does the
right thing and the runtime PM core is pure software, the only platform
dependency is if users have bothered truning runtime PM on.

> +static inline int s3c24xx_pm_runtime_put(struct s3c24xx_i2c *i2c)
> +{
> +	if (!pm_runtime_enabled(i2c->dev)) {
> +		clk_disable(i2c->clk);
> +		return 0;
> +	}
> +
> +	return pm_runtime_put(i2c->dev);
> +}

To be honest I don't think this is worth it.  Either we just keep the
clock management outside of runtime PM or we push it in but trying to
support both simultaneously adds complication and doesn't actually do
all that much in practical terms.
