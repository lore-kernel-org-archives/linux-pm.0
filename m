From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 00/16] cpufreq: create & use cpufreq_generic_get() routine
Date: Sat, 24 Aug 2013 16:50:11 +0200
Message-ID: <3157592.DnWQ5yyNjd@vostro.rjw.lan>
References: <cover.1377272740.git.viresh.kumar@linaro.org> <2330969.4ermKsDahJ@vostro.rjw.lan> <CAKohpokQkwYJBp=Bf7jOVk3MU-ziWtUCSyiX_f-JNzkt0F+-Dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohpokQkwYJBp=Bf7jOVk3MU-ziWtUCSyiX_f-JNzkt0F+-Dw@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Saturday, August 24, 2013 09:50:06 AM Viresh Kumar wrote:
> On 24 August 2013 01:10, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Friday, August 23, 2013 09:20:35 PM Viresh Kumar wrote:
> >> CPUFreq drivers that use clock frameworks interface,i.e. clk_get_rate(), to get
> >> CPUs clk rate, has similar sort of code used for most of them.
> >>
> >> This patchset adds a generic ->get() which will do the same thing for them. All
> >> those drivers are required to now is to set .get to cpufreq_generic_get() and
> >> set their clk pointer in policy->clk during ->init().
> >>
> >> Later part of this patchset fixes 17 drivers with this change.
> >>
> >> That's part 7 of my generic cleanups for CPUFreq core, first six are here:
> >
> > And that's the last one for 3.13, right?
> 
> 3.13 is too far, can't promise that really :)

OK, let me rephrase that more directly: Please, slow down.  Allow your previous
changes to be integrated before you throw more of them at people.

Thanks,
Rafael

