From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: s3c64xx: Rename index to driver_data
Date: Tue, 22 Oct 2013 00:58:58 +0200
Message-ID: <14557635.AKI3PpiVcs@vostro.rjw.lan>
References: <1381775807-20144-1-git-send-email-ckeepax@opensource.wolfsonmicro.com> <CAKohpom-KBME6fa3BUmKfZSgJxYngD7RG+CD3vHHKdtWtrtOxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKohpom-KBME6fa3BUmKfZSgJxYngD7RG+CD3vHHKdtWtrtOxA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, patches@opensource.wolfsonmicro.com
List-Id: linux-pm@vger.kernel.org

On Monday, October 21, 2013 12:59:30 PM Viresh Kumar wrote:
> On 15 October 2013 00:06, Charles Keepax
> <ckeepax@opensource.wolfsonmicro.com> wrote:
> > The index field of cpufreq_frequency_table has been renamed to driver
> > data in this commit:
> >
> > commit 5070158804b5339c71809f5e673cea1cfacd804d
> > cpufreq: rename index as driver_data in cpufreq_frequency_table
> >
> > This patch updates the s3c64xx driver to match.
> >
> > Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> > ---
> >  drivers/cpufreq/s3c64xx-cpufreq.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/drivers/cpufreq/s3c64xx-cpufreq.c b/drivers/cpufreq/s3c64xx-cpufreq.c
> > index 8a72b0c..15631f9 100644
> > --- a/drivers/cpufreq/s3c64xx-cpufreq.c
> > +++ b/drivers/cpufreq/s3c64xx-cpufreq.c
> > @@ -166,7 +166,7 @@ static void __init s3c64xx_cpufreq_config_regulator(void)
> >                 if (freq->frequency == CPUFREQ_ENTRY_INVALID)
> >                         continue;
> >
> > -               dvfs = &s3c64xx_dvfs_table[freq->index];
> > +               dvfs = &s3c64xx_dvfs_table[freq->driver_data];
> >                 found = 0;
> >
> >                 for (i = 0; i < count; i++) {
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> @Rafael: Can you please get this in 3.12 as a bug fix?

It went in already, didn't it?

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
