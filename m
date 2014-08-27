From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: s5pv210: Remove spurious __init annotation
Date: Thu, 28 Aug 2014 01:52:08 +0200
Message-ID: <2098022.zvxAyBojh6@vostro.rjw.lan>
References: <1409137227-27080-1-git-send-email-broonie@kernel.org> <CAKohpokyUWnzUOdTtevGG8G8vrdxBCo3XsH9YdvmSt8BPZ1KwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:58751 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S965188AbaH0Xc6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 27 Aug 2014 19:32:58 -0400
In-Reply-To: <CAKohpokyUWnzUOdTtevGG8G8vrdxBCo3XsH9YdvmSt8BPZ1KwA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Mark Brown <broonie@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Wednesday, August 27, 2014 04:34:28 PM Viresh Kumar wrote:
> On 27 August 2014 16:30, Mark Brown <broonie@kernel.org> wrote:
> > From: Mark Brown <broonie@linaro.org>
> >
> > Since this is a platform driver and can be probed at any time we can't
> > annotate funtions in the probe path as __init, the code can't safely be
> > discarded at the end of kernel init.
> >
> > Signed-off-by: Mark Brown <broonie@linaro.org>
> > ---
> >  drivers/cpufreq/s5pv210-cpufreq.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
> > index 9a68225a757e..3f9791f07b8e 100644
> > --- a/drivers/cpufreq/s5pv210-cpufreq.c
> > +++ b/drivers/cpufreq/s5pv210-cpufreq.c
> > @@ -501,7 +501,7 @@ static int check_mem_type(void __iomem *dmc_reg)
> >         return val >> 8;
> >  }
> >
> > -static int __init s5pv210_cpu_init(struct cpufreq_policy *policy)
> > +static int s5pv210_cpu_init(struct cpufreq_policy *policy)
> >  {
> >         unsigned long mem_type;
> >         int ret;
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Queued up for 3.17-rc3, thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
