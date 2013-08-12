From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH v6 2/8] cpufreq: Add boost frequency support in core
Date: Mon, 12 Aug 2013 11:07:41 +0200
Message-ID: <20130812110741.608e1e34@amdc308.digital.local>
References: <1370502472-7249-1-git-send-email-l.majewski@samsung.com>
 <1374770011-22171-1-git-send-email-l.majewski@samsung.com>
 <1374770011-22171-3-git-send-email-l.majewski@samsung.com>
 <CAKohpom9QHf+XBYQcajv4tni4_KA2x+Y3BAXWhZkdCFnZxp3XA@mail.gmail.com>
 <20130726103321.21238bbb@amdc308.digital.local>
 <CAKohpokK8eNid3yNGTEax_-3CZNaJ4T6Osz8RrXk11hn+Mmxxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <CAKohpokK8eNid3yNGTEax_-3CZNaJ4T6Osz8RrXk11hn+Mmxxg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, linux-kernel <linux-kernel@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>, durgadoss.r@intel.com, Lists linaro-kernel <linaro-kernel@lists.linaro.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 26 Jul 2013 15:06:45 +0530 Viresh Kumar viresh.kumar@linaro.org
wrote,
> On 26 July 2013 14:03, Lukasz Majewski <l.majewski@samsung.com> wrote:
> > The problem here is with the cpufreq_driver->set_boost() call.
> >
> > I tried to avoid acquiring lock at one function and release it at
> > another (in this case cpufreq_boost_set_sw), especially since the
> > __cpufreq_governor() acquires its own lock - good place for
> > deadlock.
> >
> > Is it OK for you to grab lock at one function
> > (cpufreq_boost_trigger_state()) and then at other function
> > (cpufreq_boost_set_sw) release it before calling
> > __cpufreq_governor() and grab it again after its completion?
> 
> Problem is not only that.. but we shouldn't call boost_set() of
> drivers like acpi-cpufreq with this lock..... Leave it as it is for
> now.. Let me see if I can think of any problems that can happen due
> to this.

Do you have any second thoughts about this? Shall I leave it as it is
now?

-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
