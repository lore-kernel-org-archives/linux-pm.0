From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH v4 3/7] cpufreq:acpi:x86: Adjust the acpi-cpufreq.c code to
 work with common boost solution
Date: Wed, 26 Jun 2013 14:17:20 +0200
Message-ID: <20130626141720.24f6bcb0@amdc308.digital.local>
References: <1370502472-7249-1-git-send-email-l.majewski@samsung.com>
 <1371661969-7660-1-git-send-email-l.majewski@samsung.com>
 <1371661969-7660-4-git-send-email-l.majewski@samsung.com>
 <CAKohpom2h3R4=B9e8ZvqEUmudB19-cnv3Lgp0=BkxgYdGA6CUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-reply-to: <CAKohpom2h3R4=B9e8ZvqEUmudB19-cnv3Lgp0=BkxgYdGA6CUA@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocky" <rjw@sisk.pl>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>, linux-kernel <linux-kernel@vger.kernel.org>, Lukasz Majewski <l.majewski@majess.pl>, Andre Przywara <andre.przywara@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>
List-Id: linux-pm@vger.kernel.org

On Wed, 26 Jun 2013 16:33:30 +0530, Viresh Kumar wrote:
> On 19 June 2013 22:42, Lukasz Majewski <l.majewski@samsung.com> wrote:
> > diff --git a/drivers/cpufreq/acpi-cpufreq.c
> > b/drivers/cpufreq/acpi-cpufreq.c
> 
> >  static unsigned int acpi_pstate_strict;
> > -static bool boost_enabled, boost_supported;
> > +static bool boost_enabled;
> 
> Instead of this variable use cpufreq_boost_enabled() directly.

OK.

> 
> And then this patch may change as well..
> 
> I couldn't find any more issues with this patch but some Intel guy
> must review it.

Yes, indeed Intel review is welcome.
-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
