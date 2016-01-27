From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: pxa2xx: fix pxa_cpufreq_change_voltage prototype
Date: Wed, 27 Jan 2016 23:56:54 +0100
Message-ID: <2688976.HQuYVlFBvt@vostro.rjw.lan>
References: <1453736683-1959283-1-git-send-email-arnd@arndb.de> <20160125163523.GD3322@vireshk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160125163523.GD3322@vireshk>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, Joe Perches <joe@perches.com>, Fabian Frederick <fabf@skynet.be>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Monday, January 25, 2016 10:05:23 PM Viresh Kumar wrote:
> On 25-01-16, 16:44, Arnd Bergmann wrote:
> > There are two definitions of pxa_cpufreq_change_voltage, with slightly
> > different prototypes after one of them had its argument marked 'const'.
> > Now the other one (for !CONFIG_REGULATOR) produces a harmless warning:
> > 
> > drivers/cpufreq/pxa2xx-cpufreq.c: In function 'pxa_set_target':
> > drivers/cpufreq/pxa2xx-cpufreq.c:291:36: warning: passing argument 1 of 'pxa_cpufreq_change_voltage' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
> >    ret = pxa_cpufreq_change_voltage(&pxa_freq_settings[idx]);
> >                                     ^
> > drivers/cpufreq/pxa2xx-cpufreq.c:205:12: note: expected 'struct pxa_freqs *' but argument is of type 'const struct pxa_freqs *'
> >  static int pxa_cpufreq_change_voltage(struct pxa_freqs *pxa_freq)
> >             ^
> > 
> > This changes the prototype in the same way as the other, which
> > avoids the warning.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > Fixes: 03c229906311 ("cpufreq: pxa: make pxa_freqs arrays const")
> > ---
> >  drivers/cpufreq/pxa2xx-cpufreq.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cpufreq/pxa2xx-cpufreq.c b/drivers/cpufreq/pxa2xx-cpufreq.c
> > index efe3b215fd34..46fee1539cc8 100644
> > --- a/drivers/cpufreq/pxa2xx-cpufreq.c
> > +++ b/drivers/cpufreq/pxa2xx-cpufreq.c
> > @@ -202,7 +202,7 @@ static void __init pxa_cpufreq_init_voltages(void)
> >  	}
> >  }
> >  #else
> > -static int pxa_cpufreq_change_voltage(struct pxa_freqs *pxa_freq)
> > +static int pxa_cpufreq_change_voltage(const struct pxa_freqs *pxa_freq)
> >  {
> >  	return 0;
> >  }
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied, thanks!

Rafael
