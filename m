From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 5/5] Thermal: Get cooling state via cpu cooling table
Date: Thu, 07 Feb 2013 09:45:11 +0800
Message-ID: <1360201511.2982.74.camel@rzhang1-mobl4>
References: <CADGdYn4fjoWXmGJ-xTZ48Fo9LE7GK37n_W41GFrBv+VNMPA23w@mail.gmail.com>
	 <CADGdYn5iPOhK51FXE4O-fU=nrXxufx_qqyPBpaMXA2wOSMcNTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:48041 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755964Ab3BGBpZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 6 Feb 2013 20:45:25 -0500
In-Reply-To: <CADGdYn5iPOhK51FXE4O-fU=nrXxufx_qqyPBpaMXA2wOSMcNTA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: amit daniel kachhap <amit.daniel@samsung.com>
Cc: linux-pm@vger.kernel.org, Gu1 <gu1@aeroxteam.fr>, Hongbo Zhang <hongbo.zhang@linaro.org>, amit.kachhap@gmail.com

Hi, Amit,

On Wed, 2013-02-06 at 17:38 -0800, amit daniel kachhap wrote:
> Hi Rui,
> 
> I tested these patches. Below are the comments.
> 
great, thanks for testing.

> On Wed, Feb 6, 2013 at 5:30 PM, amit kachhap <amit.kachhap@gmail.com> wrote:
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > ---
> >  drivers/thermal/cpu_cooling.c    |   22 ++++++++++++++++++++++
> >  drivers/thermal/exynos_thermal.c |   24 ++----------------------
> >  include/linux/cpu_cooling.h      |    6 ++++++
> >  include/linux/thermal.h          |    4 +++-
> >  4 files changed, 33 insertions(+), 23 deletions(-)
> >
> > diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> > index 784be30..9dbcbc1 100644
> > --- a/drivers/thermal/cpu_cooling.c
> > +++ b/drivers/thermal/cpu_cooling.c
> > @@ -178,6 +178,28 @@ get_cpu_cooling_table(unsigned int cpu)
> >         return new;
> >  }
> >
> > +unsigned long cpufreq_cooling_get_level(unsigned int cpu,
> > +                       unsigned int freq)
> > +{
> > +       struct cpufreq_frequency_table *table;
> > +       int i;
> > +       unsigned long level = THERMAL_COOLING_STATE_INVALID;
> > +
> > +       table = get_cpu_cooling_table(cpu);
> > +       if (IS_ERR(table))
> > +               return -EINVAL;
> Here return should be THERMAL_COOLING_STATE_INVALID as the same value
> is checked below.
> 
right. will fix it in next version.

thanks,
rui


