From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] cpufreq: stats: do cpufreq_cpu_put() corresponding to cpufreq_cpu_get
Date: Fri, 22 Mar 2013 12:47:35 +0100
Message-ID: <3472441.hhXSbXj7X9@vostro.rjw.lan>
References: <234906745c34fb72b0c450d897f261a22ed18d40.1363947023.git.viresh.kumar@linaro.org> <CAP245DWx_C0wcW-9SCfR0ViqyyqNbAeZnWfeMiXSgRGupo9jWQ@mail.gmail.com> <CAKohpo=bOcPLESk6p88gjHq=i-D8zFhhEL_4pgZUtjRYZnD_7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohpo=bOcPLESk6p88gjHq=i-D8zFhhEL_4pgZUtjRYZnD_7w@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Amit Kucheria <amit.kucheria@linaro.org>, Robin Randhawa <robin.randhawa@arm.com>, linux-pm@vger.kernel.org, Liviu Dudau <Liviu.Dudau@arm.com>, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, Steve Bannister <Steve.Bannister@arm.com>, Arvind Chauhan <arvind.chauhan@arm.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Charles Garcia-Tobin <charles.garcia-tobin@arm.com>
List-Id: linux-pm@vger.kernel.org

On Friday, March 22, 2013 04:47:29 PM Viresh Kumar wrote:
> On 22 March 2013 16:42, Amit Kucheria <amit.kucheria@linaro.org> wrote:
> > On Fri, Mar 22, 2013 at 3:43 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >> In cpufreq_stats_free_sysfs() we aren't balancing calls to cpufreq_cpu_get()
> >> with cpufreq_cpu_put(). This will never let us have ref count to policy->kobj as
> >> zero.
> >
> > Rafael,
> >
> > Since this prevents booting on our hardware (we unregister and
> > re-register the cpufreq driver to account for virtual cores), will
> > this be considered as a hotfix for 3.9?
> >
> >> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> >
> > Acked-by: Amit Kucheria <amit.kucheria@linaro.org>
> 
> Sorry i forgot to mention, this should be pushed for next rc.

Well, -rc5 is a realistic target.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
