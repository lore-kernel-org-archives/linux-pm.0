From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH v5 1/7] cpufreq: Store cpufreq policies in a list
Date: Tue, 16 Jul 2013 11:39:24 +0200
Message-ID: <20130716113924.46f40467@amdc308.digital.local>
References: <1370502472-7249-1-git-send-email-l.majewski@samsung.com>
 <1372927830-2949-1-git-send-email-l.majewski@samsung.com>
 <1372927830-2949-2-git-send-email-l.majewski@samsung.com>
 <CAKohponOEcwq4eAjwxHMM6puuqGmtJ4GpqqRHyEqvhXM+Yt6wQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-reply-to: <CAKohponOEcwq4eAjwxHMM6puuqGmtJ4GpqqRHyEqvhXM+Yt6wQ@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, "l.majewski@majess.pl" <l.majewski@majess.pl>, linux-kernel <linux-kernel@vger.kernel.org>, Andre Przywara <andre.przywara@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Tue, 16 Jul 2013 10:51:27 +0200 Viresh Kumar wrote,
> On 4 July 2013 14:20, Lukasz Majewski <l.majewski@samsung.com> wrote:
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> 
> > @@ -2056,6 +2058,7 @@ int cpufreq_unregister_driver(struct
> > cpufreq_driver *driver)
> > subsys_interface_unregister(&cpufreq_interface);
> > unregister_hotcpu_notifier(&cpufreq_cpu_notifier);
> >
> > +       list_del(&cpufreq_policy_list);
> 
> You can't delete the list this way... You must have passed the list
> entry you wanted to delete. More precisely link from the struct
> cpufreq_policy.

Yes. I shouldn't delete statically defined head of the list. Thanks for
spotting.

> 
> Over that, it shouldn't be done at the time of unregistering cpufreq
> driver but as and when cpus are removed and _cpu_remove_dev
> is called.

OK, I will iterate the list at __cpufreq_remove_dev() and remove each
of them there.

-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
