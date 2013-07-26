From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH v6 2/8] cpufreq: Add boost frequency support in core
Date: Fri, 26 Jul 2013 12:11:23 +0200
Message-ID: <20130726121123.2d7da79a@amdc308.digital.local>
References: <1370502472-7249-1-git-send-email-l.majewski@samsung.com>
 <1374770011-22171-1-git-send-email-l.majewski@samsung.com>
 <1374770011-22171-3-git-send-email-l.majewski@samsung.com>
 <CAKohpom9QHf+XBYQcajv4tni4_KA2x+Y3BAXWhZkdCFnZxp3XA@mail.gmail.com>
 <20130726103321.21238bbb@amdc308.digital.local>
 <CAKohpokK8eNid3yNGTEax_-3CZNaJ4T6Osz8RrXk11hn+Mmxxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:18394 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753454Ab3GZKLb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 26 Jul 2013 06:11:31 -0400
In-reply-to: <CAKohpokK8eNid3yNGTEax_-3CZNaJ4T6Osz8RrXk11hn+Mmxxg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, linux-kernel <linux-kernel@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, durgadoss.r@intel.com, Lists linaro-kernel <linaro-kernel@lists.linaro.org>

On Fri, 26 Jul 2013 15:06:45 +0530 Viresh Kumar wrote,
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

Ok. No problem.

-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
