From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH V3 4/4] cpufreq: Add Kconfig option to enable/disable have_multiple_policies
Date: Wed, 20 Mar 2013 01:20:52 +0100
Message-ID: <1409962.M4gLo8y6eX@vostro.rjw.lan>
References: <cover.1362381470.git.viresh.kumar@linaro.org> <3174774.7AKCbYrzc6@vostro.rjw.lan> <CAKohpokwdtSwQmcK=gb2mpzjzp0vpbS7Sra-EhM3QsiQwpog1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohpokwdtSwQmcK=gb2mpzjzp0vpbS7Sra-EhM3QsiQwpog1w@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com
List-Id: linux-pm@vger.kernel.org

On Thursday, March 14, 2013 08:39:55 AM Viresh Kumar wrote:
> On 14 March 2013 03:11, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Tuesday, March 12, 2013 08:55:12 AM Viresh Kumar wrote:
> >> On 12 March 2013 07:38, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> >> > One more question before I apply it.
> >> >
> >> > Is there any architecture/platform that will set
> >> > CONFIG_CPU_FREQ_HAVE_MULTIPLE_POLICIES and keep have_multiple_policies unset
> >> > at the same time?
> >>
> >> No, they are redundant. That's why i have been forcing to drop this patch.
> >
> > I see.
> >
> > What about having the Kconfig option alone, however?
> 
> Even that is not enough. We build multiplatform kernels and so need a
> variable to be set by platform.

Which means the Kconfig option and the field are not redundant in fact.

But do we need the field to reside in the policy structure?  It looks like
it may just be a global bool variable (in which case the Kconfig option could
be dropped IMO).  Is there any particular reason to put that thing into
struct cpufreq_policy?

Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
