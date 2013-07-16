From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH v5 3/7] cpufreq:acpi:x86: Adjust the acpi-cpufreq.c code to
 work with common boost solution
Date: Tue, 16 Jul 2013 13:17:04 +0200
Message-ID: <20130716131704.6e3c5373@amdc308.digital.local>
References: <1370502472-7249-1-git-send-email-l.majewski@samsung.com>
 <1372927830-2949-1-git-send-email-l.majewski@samsung.com>
 <1372927830-2949-4-git-send-email-l.majewski@samsung.com>
 <CAKohpomdkF-XVWXaxNx+SfnHvHE_N6=gcU06YD6D7_oB0-M9aA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-reply-to: <CAKohpomdkF-XVWXaxNx+SfnHvHE_N6=gcU06YD6D7_oB0-M9aA@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, l.majewski@majess.pl, linux-kernel <linux-kernel@vger.kernel.org>, Andre Przywara <andre.przywara@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Tue, 16 Jul 2013 15:34:02 +0530 Viresh Kumar viresh.kumar@linaro.org
wrote,
> On 4 July 2013 14:20, Lukasz Majewski <l.majewski@samsung.com> wrote:
> >  static void __init acpi_cpufreq_boost_init(void)
> > @@ -953,33 +937,22 @@ static void __init
> > acpi_cpufreq_boost_init(void) if (!msrs)
> >                         return;
> >
> > -               boost_supported = true;
> > -               boost_enabled = boost_state(0);
> > +               cpufreq_set_boost_enabled(boost_state(0));
> > +               acpi_cpufreq_driver.boost_supported = true;
> 
> You are again doing the same mistake. Boost must be
> always supported for acpi-cpufreq with read permissions, as it was
> earlier.

The boost attribute is exported to sysfs only when boost is supported
by the driver (as we had agreed earlier).  

The problem here is that the original acpi-cpufreq.c file had two
static flags:
static bool boost_enabled, boost_supported;

Both of them are not needed at acpi-cpufreq, since:
1. boost_enabled is defined at cpufreq.c core file.
2. boost_supported is defined at struct cpufreq_driver
(acpi_cpufreq_driver).

I've reused the boost_supported from acpi_cpufreq_driver structure to
avoid code duplication.


-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
