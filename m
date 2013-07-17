From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH v5 7/7] Documentation:cpufreq:boost: Update BOOST
 documentation
Date: Wed, 17 Jul 2013 09:36:14 +0200
Message-ID: <20130717093614.1ee4839e@amdc308.digital.local>
References: <1370502472-7249-1-git-send-email-l.majewski@samsung.com>
 <1372927830-2949-1-git-send-email-l.majewski@samsung.com>
 <1372927830-2949-8-git-send-email-l.majewski@samsung.com>
 <CAKohpo=oB_4gGtNn6jvxSCp665pOq6oqeTCCyGzmN_eWqt0Lhg@mail.gmail.com>
 <20130716133319.49ed0838@amdc308.digital.local>
 <CAKohponeZ15ruJA9__V70u1Ztr4F9aT+zBinMT5Ewyew53rbyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-reply-to: <CAKohponeZ15ruJA9__V70u1Ztr4F9aT+zBinMT5Ewyew53rbyQ@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, l.majewski@majess.pl, linux-kernel <linux-kernel@vger.kernel.org>, Andre Przywara <andre.przywara@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Wed, 17 Jul 2013 10:52:18 +0530 Viresh Kumar viresh.kumar@linaro.org
wrote,
> On 16 July 2013 17:03, Lukasz Majewski <l.majewski@samsung.com> wrote:
> > As fair as I've understood our previous discussion (at [*]) we have
> > agreed about this. We only export boost attribute when it is
> > supported by cpufreq_driver. Rafael was very clear about exporting
> > boost attribute:
> >
> > "Simple: Export it only when supported."
> >
> > [*]: Re: [PATCH v4 2/7] cpufreq: Add boost frequency support in core
> 
> I don't want to search in the Archives but I am sure what we decided
> earlier.

At v4 there was the old acpi-cpufreq.c behaviour preserved (with always
exporting boost - when not supported ro, when supported rw).

Due to Rafael and Dirk comments it has been rewritten at v5:

http://thread.gmane.org/gmane.linux.kernel/1511831/match=patch+v4+2+7+cpufreq+add+boost+frequency+support+core


> 
> Rafael Said:
> "Simple: Export it only when supported."
              [*]

> 
> AND
> 
> "Don't change behavior of acpi-cpufreq driver" 
              [**]
> 
> If you see acpi-cpufreq driver carefully, it always creates "boost"
> sysfs entry. If its not supported then it creates a read only entry.

For me those two statements [*] and [**] contradict:

At v5:
1. ARM - export "boost" only when supported (rw)
2. x86 - export boost only when x86 supports it (as rw). When x86
	 doesn't support HW boost - DO NOT export it at all.

At v4:
1. ARM - export "boost" only when supported (rw)
2. x86 - always export boost - no matter if supported or not. If not
	 supported, then export it as ro only.


> 
> So, please preserve that.


-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
