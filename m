From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V4] cpufreq: imx6q: read OCOTP through nvmem for imx6ul/imx6ull
Date: Tue, 16 Oct 2018 11:09:56 +0200
Message-ID: <3002020.tALnatBSDD@aspire.rjw.lan>
References: <1538978854-9678-1-git-send-email-Anson.Huang@nxp.com> <20181008061508.m3u7acg2q76jljay@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181008061508.m3u7acg2q76jljay@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Anson Huang <Anson.Huang@nxp.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Linux-imx@nxp.com
List-Id: linux-pm@vger.kernel.org

On Monday, October 8, 2018 8:15:08 AM CEST Viresh Kumar wrote:
> On 08-10-18, 14:07, Anson Huang wrote:
> > On i.MX6UL/i.MX6ULL, accessing OCOTP directly is wrong because
> > the ocotp clock needs to be enabled first. Add support for reading
> > OCOTP through the nvmem API, and keep the old method there to
> > support old dtb.
> > 
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > ---
> > changes since V3:
> > 	put node earlier to save one line code.
> >  drivers/cpufreq/imx6q-cpufreq.c | 52 +++++++++++++++++++++++++++--------------
> >  1 file changed, 35 insertions(+), 17 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
> > index b2ff423..8cfee0a 100644
> > --- a/drivers/cpufreq/imx6q-cpufreq.c
> > +++ b/drivers/cpufreq/imx6q-cpufreq.c
> > @@ -12,6 +12,7 @@
> >  #include <linux/cpu_cooling.h>
> >  #include <linux/err.h>
> >  #include <linux/module.h>
> > +#include <linux/nvmem-consumer.h>
> >  #include <linux/of.h>
> >  #include <linux/of_address.h>
> >  #include <linux/pm_opp.h>
> > @@ -290,20 +291,32 @@ static void imx6q_opp_check_speed_grading(struct device *dev)
> >  #define OCOTP_CFG3_6ULL_SPEED_792MHZ	0x2
> >  #define OCOTP_CFG3_6ULL_SPEED_900MHZ	0x3
> >  
> > -static void imx6ul_opp_check_speed_grading(struct device *dev)
> > +static int imx6ul_opp_check_speed_grading(struct device *dev)
> >  {
> > -	struct device_node *np;
> > -	void __iomem *base;
> >  	u32 val;
> > +	int ret = 0;
> >  
> > -	np = of_find_compatible_node(NULL, NULL, "fsl,imx6ul-ocotp");
> > -	if (!np)
> > -		return;
> > +	if (of_find_property(dev->of_node, "nvmem-cells", NULL)) {
> > +		ret = nvmem_cell_read_u32(dev, "speed_grade", &val);
> > +		if (ret)
> > +			return ret;
> > +	} else {
> > +		struct device_node *np;
> > +		void __iomem *base;
> > +
> > +		np = of_find_compatible_node(NULL, NULL, "fsl,imx6ul-ocotp");
> > +		if (!np)
> > +			return -ENOENT;
> > +
> > +		base = of_iomap(np, 0);
> > +		of_node_put(np);
> > +		if (!base) {
> > +			dev_err(dev, "failed to map ocotp\n");
> > +			return -EFAULT;
> > +		}
> >  
> > -	base = of_iomap(np, 0);
> > -	if (!base) {
> > -		dev_err(dev, "failed to map ocotp\n");
> > -		goto put_node;
> > +		val = readl_relaxed(base + OCOTP_CFG3);
> > +		iounmap(base);
> >  	}
> >  
> >  	/*
> > @@ -314,7 +327,6 @@ static void imx6ul_opp_check_speed_grading(struct device *dev)
> >  	 * 2b'11: 900000000Hz on i.MX6ULL only;
> >  	 * We need to set the max speed of ARM according to fuse map.
> >  	 */
> > -	val = readl_relaxed(base + OCOTP_CFG3);
> >  	val >>= OCOTP_CFG3_SPEED_SHIFT;
> >  	val &= 0x3;
> >  
> > @@ -334,9 +346,7 @@ static void imx6ul_opp_check_speed_grading(struct device *dev)
> >  				dev_warn(dev, "failed to disable 900MHz OPP\n");
> >  	}
> >  
> > -	iounmap(base);
> > -put_node:
> > -	of_node_put(np);
> > +	return ret;
> >  }
> >  
> >  static int imx6q_cpufreq_probe(struct platform_device *pdev)
> > @@ -394,10 +404,18 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
> >  	}
> >  
> >  	if (of_machine_is_compatible("fsl,imx6ul") ||
> > -	    of_machine_is_compatible("fsl,imx6ull"))
> > -		imx6ul_opp_check_speed_grading(cpu_dev);
> > -	else
> > +	    of_machine_is_compatible("fsl,imx6ull")) {
> > +		ret = imx6ul_opp_check_speed_grading(cpu_dev);
> > +		if (ret == -EPROBE_DEFER)
> > +			return ret;
> > +		if (ret) {
> > +			dev_err(cpu_dev, "failed to read ocotp: %d\n",
> > +				ret);
> > +			return ret;
> > +		}
> > +	} else {
> >  		imx6q_opp_check_speed_grading(cpu_dev);
> > +	}
> >  
> >  	/* Because we have added the OPPs here, we must free them */
> >  	free_opp = true;
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Patch applied, thanks!
