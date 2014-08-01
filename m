From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH 1/1] cpufreq: s5pv210: Fix section mismatch warning
Date: Fri, 01 Aug 2014 23:21:24 +0900
Message-ID: <081201cfad93$dfed6ab0$9fc84010$@samsung.com>
References: <1406891691-27708-1-git-send-email-sachin.kamat@samsung.com>
 <CAKohpo=vdjPxDWD55v1i0oKK7tjg_p43bLPszZzCybBE0DDV+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:56895 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750738AbaHAOV0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 1 Aug 2014 10:21:26 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N9M003U3T7OSM90@mailout1.samsung.com> for
 linux-pm@vger.kernel.org; Fri, 01 Aug 2014 23:21:24 +0900 (KST)
In-reply-to: <CAKohpo=vdjPxDWD55v1i0oKK7tjg_p43bLPszZzCybBE0DDV+g@mail.gmail.com>
Content-language: ko
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Viresh Kumar' <viresh.kumar@linaro.org>, 'Sachin Kamat' <sachin.kamat@samsung.com>
Cc: linux-pm@vger.kernel.org, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Tomasz Figa' <tomasz.figa@gmail.com>, 'Sachin Kamat' <spk.linux@gmail.com>

Viresh Kumar wrote:
> 
> On 1 August 2014 16:44, Sachin Kamat <sachin.kamat@samsung.com> wrote:
> > struct s5pv210_driver is registered in probe function which
> > does not have __init annotation. However s5pv210_driver contains
> > the pointer to s5pv210_cpu_init() which is annotated with __init
> > which causes the following section mismatch warning:
> > WARNING: drivers/cpufreq/built-in.o(.data+0xc3c): Section mismatch in reference from the variable
> s5pv210_driver to the function .init.text:s5pv210_cpu_init()
> >
> > Fixed by removing the annotation for s5pv210_cpu_init.
> >
> > Signed-off-by: Sachin Kamat <sachin.kamat@samsung.com>
> > ---
> >  drivers/cpufreq/s5pv210-cpufreq.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
> > index 9a68225..3f9791f 100644
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
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

OK, I will take this into non-critical-fixes.

Thanks,
Kukjin

