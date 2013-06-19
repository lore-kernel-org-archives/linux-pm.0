From: Lukasz Majewski <l.majewski@majess.pl>
Subject: Re: [PATCH v4 2/7] cpufreq: Add boost frequency support in core
Date: Wed, 19 Jun 2013 22:31:02 +0200
Message-ID: <20130619223102.70c2e359@jawa>
References: <1370502472-7249-1-git-send-email-l.majewski@samsung.com>
	<1371661969-7660-1-git-send-email-l.majewski@samsung.com>
	<1371661969-7660-3-git-send-email-l.majewski@samsung.com>
	<51C1EF05.90402@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <51C1EF05.90402@gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Dirk Brandewie <dirk.brandewie@gmail.com>
Cc: Lukasz Majewski <l.majewski@samsung.com>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocky" <rjw@sisk.pl>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>, linux-kernel <linux-kernel@vger.kernel.org>, Andre Przywara <andre.przywara@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>
List-Id: linux-pm@vger.kernel.org

On Wed, 19 Jun 2013 10:48:53 -0700
Dirk Brandewie <dirk.brandewie@gmail.com> wrote:

> On 06/19/2013 10:12 AM, Lukasz Majewski wrote:
> > This commit adds boost frequency support in cpufreq core (Hardware &
> 
> > +/*********************************************************************
> >    *               REGISTER / UNREGISTER CPUFREQ
> > DRIVER                *
> > *********************************************************************/
> >
> > @@ -1936,6 +2019,16 @@ int cpufreq_register_driver(struct
> > cpufreq_driver *driver_data) cpufreq_driver = driver_data;
> >   	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
> >
> > +	if (!cpufreq_driver->boost_supported)
> > +		boost.attr.mode = 0444;
> > +
> > +	ret = cpufreq_sysfs_create_file(&(boost.attr));
> > +	if (ret) {
> > +		pr_err("%s: cannot register global boost sysfs
> > file\n",
> > +		       __func__);
> > +		goto err_null_driver;
> > +	}
> > +
> 
> I do not think the boost sysfs should be created at all if boost is
> not supported.

This was my first thought. But unfortunately this "boost" attribute is
always exported at acpi-cpufreq.c and in my opinion is part of a
legacy API.

I totally agree with the idea of exporting boost only when supported,
but I would like to know the community opinion about this (especially
Viresh and Rafael shall speak up).

> 
> For intel_pstate the read-only boost would be there for no reason and
> would cause confusion on the part of the user IMHO

You are probably right here. However I don't know what was the
original rationale behind exporting this attribute as read only. 

> 
> >   	ret = subsys_interface_register(&cpufreq_interface);
> >   	if (ret)
> >   		goto err_null_driver;
> > @@ -1992,6 +2085,8 @@ int cpufreq_unregister_driver(struct
> > cpufreq_driver *driver) pr_debug("unregistering driver %s\n",
> > driver->name);
> >
> >   	subsys_interface_unregister(&cpufreq_interface);
> > +
> > +	cpufreq_sysfs_remove_file(&(boost.attr));
> >   	unregister_hotcpu_notifier(&cpufreq_cpu_notifier);
> >
> 

Best regards,

Lukasz Majewski

