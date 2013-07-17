From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH v5 2/7] cpufreq: Add boost frequency support in core
Date: Wed, 17 Jul 2013 09:00:44 +0200
Message-ID: <20130717090044.4392d86a@amdc308.digital.local>
References: <1370502472-7249-1-git-send-email-l.majewski@samsung.com>
 <1372927830-2949-1-git-send-email-l.majewski@samsung.com>
 <1372927830-2949-3-git-send-email-l.majewski@samsung.com>
 <CAKohpomfWKiRjznXeYsg32xAAWPTBQ4Gd0D_pftbA5=zMDiH4Q@mail.gmail.com>
 <20130716140632.70fb2838@amdc308.digital.local>
 <CAKohpokni=zPob9yz2-ak_g_xhwFaLBhk6wNGV5EGSfxx-eGZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-reply-to: <CAKohpokni=zPob9yz2-ak_g_xhwFaLBhk6wNGV5EGSfxx-eGZA@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, l.majewski@majess.pl, linux-kernel <linux-kernel@vger.kernel.org>, Andre Przywara <andre.przywara@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Wed, 17 Jul 2013 10:58:40 +0530 Viresh Kumar viresh.kumar@linaro.org
wrote,
> On 16 July 2013 17:36, Lukasz Majewski <l.majewski@samsung.com> wrote:
> > On Tue, 16 Jul 2013 15:11:54 +0530 Viresh Kumar
> > viresh.kumar@linaro.org wrote,
> >> On 4 July 2013 14:20, Lukasz Majewski <l.majewski@samsung.com>
> >> wrote:
> 
> >> > +void cpufreq_set_boost_enabled(int state)
> >           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ [*]
> >
> >>
> >> Maybe cpufreq_block_boost? As suggested by Rafael.
> >
> > What do you mean by cpufreq_block_boost()? This name would reverse
> > the logic.
> >
> > Function [*] is used to change boost_enabled static flag (defined at
> > cpufreq.c file) state according to acpi-cpufreq.c boost support
> > status.
> 
> I misread it again :(
> 
> So, what about adding another field in struct cpufreq_driver:
> boost_enabled? And get rid of the global boost_enabled we have used?
> Similar to how boost_supported is used, then we don't need this
> routine.

Ok, I will implement this.

-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
