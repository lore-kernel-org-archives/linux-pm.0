From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH v2 linux-next 2/2] cpufreq: Convert the cpufreq_driver_lock to use the rcu
Date: Mon, 11 Feb 2013 20:36:17 +0100
Message-ID: <1953281.cgEiiBGo0f@vostro.rjw.lan>
References: <74F10842A85F514CA8D8C487E74474BB2D2F925E@P-EXMB1-DC21.corp.sgi.com> <16615226.2vj4EkkIZJ@vostro.rjw.lan> <74F10842A85F514CA8D8C487E74474BB2D30DC9E@P-EXMB1-DC21.corp.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <74F10842A85F514CA8D8C487E74474BB2D30DC9E@P-EXMB1-DC21.corp.sgi.com>
Sender: cpufreq-owner@vger.kernel.org
To: Nathan Zimmer <nzimmer@sgi.com>
Cc: "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Monday, February 11, 2013 05:13:30 PM Nathan Zimmer wrote:
> There are some spots that I need to give a much deeper review, cpufreq_register_driver for example.
> 
> But I believe 
> > @@ -196,7 +195,7 @@ static void __cpufreq_cpu_put(struct cpufreq_policy *data, bool sysfs)
> >  {
> >       if (!sysfs)
> >               kobject_put(&data->kobj);
> > -     module_put(cpufreq_driver->owner);
> > +     module_put(rcu_dereference(cpufreq_driver)->owner);
> >  }
> would be ok.  In the documentation whatisRCU.txt they give a very similar example.

Well, the very same document states the following:

        Note that the value returned by rcu_dereference() is valid
        only within the enclosing RCU read-side critical section.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
