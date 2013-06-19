From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH v4 2/7] cpufreq: Add boost frequency support in core
Date: Thu, 20 Jun 2013 00:25:38 +0200
Message-ID: <6633375.dICiDrHJgK@vostro.rjw.lan>
References: <1370502472-7249-1-git-send-email-l.majewski@samsung.com> <51C1EF05.90402@gmail.com> <20130619223102.70c2e359@jawa>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <20130619223102.70c2e359@jawa>
Sender: cpufreq-owner@vger.kernel.org
To: Lukasz Majewski <l.majewski@majess.pl>
Cc: Dirk Brandewie <dirk.brandewie@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Viresh Kumar <viresh.kumar@linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>, linux-kernel <linux-kernel@vger.kernel.org>, Andre Przywara <andre.przywara@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>
List-Id: linux-pm@vger.kernel.org

On Wednesday, June 19, 2013 10:31:02 PM Lukasz Majewski wrote:
> On Wed, 19 Jun 2013 10:48:53 -0700
> Dirk Brandewie <dirk.brandewie@gmail.com> wrote:
> 
> > On 06/19/2013 10:12 AM, Lukasz Majewski wrote:
> > > This commit adds boost frequency support in cpufreq core (Hardware &
> > 
> > > +/*********************************************************************
> > >    *               REGISTER / UNREGISTER CPUFREQ
> > > DRIVER                *
> > > *********************************************************************/
> > >
> > > @@ -1936,6 +2019,16 @@ int cpufreq_register_driver(struct
> > > cpufreq_driver *driver_data) cpufreq_driver = driver_data;
> > >   	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
> > >
> > > +	if (!cpufreq_driver->boost_supported)
> > > +		boost.attr.mode = 0444;
> > > +
> > > +	ret = cpufreq_sysfs_create_file(&(boost.attr));
> > > +	if (ret) {
> > > +		pr_err("%s: cannot register global boost sysfs
> > > file\n",
> > > +		       __func__);
> > > +		goto err_null_driver;
> > > +	}
> > > +
> > 
> > I do not think the boost sysfs should be created at all if boost is
> > not supported.
> 
> This was my first thought. But unfortunately this "boost" attribute is
> always exported at acpi-cpufreq.c and in my opinion is part of a
> legacy API.
> 
> I totally agree with the idea of exporting boost only when supported,
> but I would like to know the community opinion about this (especially
> Viresh and Rafael shall speak up).

Simple: Export it only when supported.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
