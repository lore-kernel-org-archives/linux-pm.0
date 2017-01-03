From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH] cpufreq: s3c64xx: remove incorrect __init annotation
Date: Tue, 3 Jan 2017 21:20:08 +0200
Message-ID: <20170103192008.3taowqq4kjggv6fh@kozik-lap>
References: <20161216090625.2235668-1-arnd@arndb.de>
 <20170102070903.GC8588@vireshk-i7>
 <20170102173651.hvsfalhcmisv4mtv@kozik-lap>
 <CAJZ5v0jaKnn+LTTdpgxaFLNaYSuqV8d9PKphOnHrPw0Zp_Uj5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jaKnn+LTTdpgxaFLNaYSuqV8d9PKphOnHrPw0Zp_Uj5w@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Arnd Bergmann <arnd@arndb.de>, Kukjin Kim <kgene@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux Samsung SoC <linux-samsung-soc@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Jan 02, 2017 at 10:19:29PM +0100, Rafael J. Wysocki wrote:
> On Mon, Jan 2, 2017 at 6:36 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > On Mon, Jan 02, 2017 at 12:39:03PM +0530, Viresh Kumar wrote:
> >> On 16-12-16, 10:06, Arnd Bergmann wrote:
> >> > s3c64xx_cpufreq_config_regulator is incorrectly annotated
> >> > as __init, since the caller is also not init:
> >> >
> >> > WARNING: vmlinux.o(.text+0x92fe1c): Section mismatch in reference from the function s3c64xx_cpufreq_driver_init() to the function .init.text:s3c64xx_cpufreq_config_regulator()
> >> >
> >> > With modern gcc versions, the function gets inline, so we don't
> >> > see the warning, this only happens with gcc-4.6 and older.
> >> >
> >> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >> > ---
> >> >  drivers/cpufreq/s3c64xx-cpufreq.c | 2 +-
> >> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >> >
> >> > diff --git a/drivers/cpufreq/s3c64xx-cpufreq.c b/drivers/cpufreq/s3c64xx-cpufreq.c
> >> > index 176e84cc3991..0cb9040eca49 100644
> >> > --- a/drivers/cpufreq/s3c64xx-cpufreq.c
> >> > +++ b/drivers/cpufreq/s3c64xx-cpufreq.c
> >> > @@ -107,7 +107,7 @@ static int s3c64xx_cpufreq_set_target(struct cpufreq_policy *policy,
> >> >  }
> >> >
> >> >  #ifdef CONFIG_REGULATOR
> >> > -static void __init s3c64xx_cpufreq_config_regulator(void)
> >> > +static void s3c64xx_cpufreq_config_regulator(void)
> >> >  {
> >> >     int count, v, i, found;
> >> >     struct cpufreq_frequency_table *freq;
> >>
> >> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> >
> > Rafael,
> > Are you going to pick it up?
> 
> I thought I did, didn't I?

Right, you did. I missed that. Thanks!

Best regards,
Krzysztof
