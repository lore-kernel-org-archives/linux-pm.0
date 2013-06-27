From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH v4 4/7] cpufreq:exynos:Extend Exynos cpufreq driver to
 support boost framework
Date: Thu, 27 Jun 2013 11:08:13 +0200
Message-ID: <20130627110813.6797b1fe@amdc308.digital.local>
References: <1370502472-7249-1-git-send-email-l.majewski@samsung.com>
 <1371661969-7660-1-git-send-email-l.majewski@samsung.com>
 <1371661969-7660-5-git-send-email-l.majewski@samsung.com>
 <CAKohpokf8TZkP5Nzpp+m5KaUK8zJ6mwiuiW-td7boHQ7NtB-DQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-reply-to: <CAKohpokf8TZkP5Nzpp+m5KaUK8zJ6mwiuiW-td7boHQ7NtB-DQ@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocky" <rjw@sisk.pl>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>, linux-kernel <linux-kernel@vger.kernel.org>, Lukasz Majewski <l.majewski@majess.pl>, Andre Przywara <andre.przywara@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>
List-Id: linux-pm@vger.kernel.org

On Thu, 27 Jun 2013 14:28:11 +0530, Viresh Kumar wrote:

> On 19 June 2013 22:42, Lukasz Majewski <l.majewski@samsung.com> wrote:
> > The struct cpufreq_driver has been extended to embrace the
> > information related to boost support.
> >
> > When "boost_mode" device tree attribute is defined for a platform,
> > the boost_supported flag is set. Moreover boost related attributes
> > were exported.
> >
> > Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> > Signed-off-by: Myungjoo Ham <myungjoo.ham@samsung.com>
> >
> > Changes for v4:
> > - None
> >
> > Changes for v3:
> > - Remove low level boost code
> > - Move boost management code to cpufreq core code
> > - Use boost_supported flag to indicate if driver supports over
> > clocking
> >
> > Changes for v2:
> > - Removal of struct cpufreq_boost
> > - Removal of the CONFIG_CPU_FREQ_BOOST flag
> > - low_level_boost with valid address when boost is supported
> > ---
> >  drivers/cpufreq/exynos-cpufreq.c |    4 ++++
> >  1 file changed, 4 insertions(+)
> 
> Yes, this looks fine..
> 
> I will Ack the whole series in the end, so no individual acks :)

Ok.

-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
