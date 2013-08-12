From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH v6 5/8] cpufreq:boost:Kconfig: Provide support for software
 managed BOOST
Date: Mon, 12 Aug 2013 12:26:14 +0200
Message-ID: <20130812122614.0d4d31a3@amdc308.digital.local>
References: <1370502472-7249-1-git-send-email-l.majewski@samsung.com>
 <1374770011-22171-1-git-send-email-l.majewski@samsung.com>
 <1374770011-22171-6-git-send-email-l.majewski@samsung.com>
 <CAKohpokL57mXSQooX=4LZKtjMxJoXAB4uuzj13fgr3Gs7Wcf0A@mail.gmail.com>
 <20130726132120.5b9cf32f@amdc308.digital.local>
 <CAKohponvOXuHSS+-+m5PR9tPkAqkrYtjA3FJaNh9NJXrhQ9wmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <CAKohponvOXuHSS+-+m5PR9tPkAqkrYtjA3FJaNh9NJXrhQ9wmw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, linux-kernel <linux-kernel@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, durgadoss.r@intel.com
List-Id: linux-pm@vger.kernel.org

On Mon, 29 Jul 2013 12:28:02 +0530 Viresh Kumar viresh.kumar@linaro.org
wrote,
> On 26 July 2013 16:51, Lukasz Majewski <l.majewski@samsung.com> wrote:
> > On Fri, 26 Jul 2013 15:54:56 +0530 Viresh Kumar wrote,
> >> On 25 July 2013 22:03, Lukasz Majewski <l.majewski@samsung.com>
> >> wrote:
> 
> >> > +config CPU_FREQ_BOOST_SW
> >> > +       bool
> >>
> >> Invisible is fine but this must be disabled by default and must
> >> depend on thermal, rather than moving dependency on platform's
> >> config.
> >
> > The CPU_FREQ_BOOST_SW [1] is a generic flag (invisible).
> >
> > I will add "default n" to it.
> 
> Leave it.. We don't need it now.. that's how these kind of config
> options are defined as they are disabled by default.

Ok. Please see below proposition.

> 
> > Depending only on [3], results at situation where SW BOOST can be
> > enabled at x86 or ARM target with only generic THERMAL support
> > (which doesn't protect from overheating).
> 
> I had a similar concern.. Currently also we aren't stopping anybody to
> enable boost. By selecting thermal from CPU_FREQ_BOOST_SW, atleast
> we are communicating this very well to developers that they need
> something else as well. And currently we only have thermal as a source
> for telling when to block boost but it can be something else too..
> 
> I never said, don't use EXYNOS_THERMAL, its good to have a
> dependency on it in the Exynos specific config for boost, but I wanted
> normal sw boost also to depend on thermal..

1. at ./drivers/cpufreq/Kconfig:

+config CPU_FREQ_BOOST_SW
+	bool
+	depends on THERMAL

2. at ./drivers/cpufreq/Kconfig.arm:

+config ARM_EXYNOS_CPU_FREQ_BOOST_SW
+	bool "EXYNOS Frequency Overclocking - Software"
+	depends on ARM_EXYNOS_CPUFREQ
+	select CPU_FREQ_BOOST_SW
+	select EXYNOS_THERMAL
+	default n
+	help
+	  This driver supports software managed overclocking (BOOST).
+	  It allows usage of special frequencies for Samsung Exynos
+	  processors if thermal conditions are appropriate.
+
+	  It reguires, for safe operation, thermal framework with
  properly
+	  defined trip points.
+
+	  If in doubt, say N.
+

Shall I split this patch to two (1. and 2.) or leave it as a single one?

-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
