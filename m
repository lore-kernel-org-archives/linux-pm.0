From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: qcom-kryo: add NULL entry to the end of_device_id array
Date: Thu, 26 Jul 2018 11:05:05 +0200
Message-ID: <4102618.ESNx517Qjd@aspire.rjw.lan>
References: <20180723123429.20040-1-yuehaibing@huawei.com> <20180724034335.v76tfqk2imlyf2eg@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180724034335.v76tfqk2imlyf2eg@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, YueHaibing <yuehaibing@huawei.com>
Cc: ilia.lin@gmail.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, July 24, 2018 5:43:35 AM CEST Viresh Kumar wrote:
> On 23-07-18, 20:34, YueHaibing wrote:
> > Make sure of_device_id tables are NULL terminated
> > Found by coccinelle spatch "misc/of_table.cocci"
> > 
> > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> > ---
> >  drivers/cpufreq/qcom-cpufreq-kryo.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/cpufreq/qcom-cpufreq-kryo.c b/drivers/cpufreq/qcom-cpufreq-kryo.c
> > index 29389ac..efc9a7a 100644
> > --- a/drivers/cpufreq/qcom-cpufreq-kryo.c
> > +++ b/drivers/cpufreq/qcom-cpufreq-kryo.c
> > @@ -183,6 +183,7 @@ static struct platform_driver qcom_cpufreq_kryo_driver = {
> >  static const struct of_device_id qcom_cpufreq_kryo_match_list[] __initconst = {
> >  	{ .compatible = "qcom,apq8096", },
> >  	{ .compatible = "qcom,msm8996", },
> > +	{}
> >  };
> >  
> >  /*
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> 

Patch applied, thanks!
