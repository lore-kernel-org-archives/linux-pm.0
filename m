From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: kryo: allow building as a loadable module
Date: Tue, 12 Jun 2018 17:02:30 +0200
Message-ID: <3261365.2LNNG94y3I@aspire.rjw.lan>
References: <20180605114453.1381941-1-arnd@arndb.de> <20180606040929.tksvznlmb3ogtgur@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180606040929.tksvznlmb3ogtgur@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Ilia Lin <ilialin@codeaurora.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wednesday, June 6, 2018 6:09:29 AM CEST Viresh Kumar wrote:
> On 05-06-18, 13:44, Arnd Bergmann wrote:
> > Building the kryo cpufreq driver while QCOM_SMEM is a loadable module
> > results in a link error:
> > 
> > drivers/cpufreq/qcom-cpufreq-kryo.o: In function `qcom_cpufreq_kryo_probe':
> > qcom-cpufreq-kryo.c:(.text+0xbc): undefined reference to `qcom_smem_get'
> > 
> > The problem is that Kconfig ignores interprets the dependency as met
> > when the dependent symbol is a 'bool' one. By making it 'tristate',
> > it will be forced to be a module here, which builds successfully.
> > 
> > Fixes: 46e2856b8e18 ("cpufreq: Add Kryo CPU scaling driver")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  drivers/cpufreq/Kconfig.arm | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> > index c7ce928fbf1f..52f5f1a2040c 100644
> > --- a/drivers/cpufreq/Kconfig.arm
> > +++ b/drivers/cpufreq/Kconfig.arm
> > @@ -125,7 +125,7 @@ config ARM_OMAP2PLUS_CPUFREQ
> >  	default ARCH_OMAP2PLUS
> >  
> >  config ARM_QCOM_CPUFREQ_KRYO
> > -	bool "Qualcomm Kryo based CPUFreq"
> > +	tristate "Qualcomm Kryo based CPUFreq"
> >  	depends on ARM64
> >  	depends on QCOM_QFPROM
> >  	depends on QCOM_SMEM
> 
> Okay, so we really need this to be a module. But the driver can't really work as
> a module right now if we do this: insmod, rmmod, insmod. Because it doesn't free
> resources at rmmmod and will fail on second insmod.
> 
> Because what you are fixing is a critical build error, we better get it merged
> right now.
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Patch applied, thanks!
