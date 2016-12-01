From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: dt: Add support for zx296718
Date: Thu, 01 Dec 2016 15:25:32 +0100
Message-ID: <33656568.Mu5lX1GPCY@aspire.rjw.lan>
References: <1480491329-5242-1-git-send-email-baoyou.xie@linaro.org> <20161130080855.GL3288@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161130080855.GL3288@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Baoyou Xie <baoyou.xie@linaro.org>
Cc: xie.baoyou@zte.com.cn, chen.chaokai@zte.com.cn, wang.qiang01@zte.com.cn, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wednesday, November 30, 2016 01:38:55 PM Viresh Kumar wrote:
> On 30-11-16, 15:35, Baoyou Xie wrote:
> > Add the compatible string for supporting the generic cpufreq driver on
> > the ZTE's zx296718 SoC.
> > 
> > Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
> > ---
> >  drivers/cpufreq/cpufreq-dt-platdev.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> > index 7126762..c0a28e23b 100644
> > --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> > +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> > @@ -81,6 +81,8 @@ static const struct of_device_id machines[] __initconst = {
> >  
> >  	{ .compatible = "xlnx,zynq-7000", },
> >  
> > +	{ .compatible = "zte,zx296718", },
> > +
> >  	{ }
> >  };
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied.

Thanks,
Rafael
