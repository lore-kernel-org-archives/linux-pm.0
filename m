From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/4] CPUFreq Fixes for 3.9
Date: Fri, 08 Feb 2013 21:02:37 +0100
Message-ID: <1653071.l2kN4Hy2U6@vostro.rjw.lan>
References: <cover.1360232293.git.viresh.kumar@linaro.org> <2130803.VQA31hf2jE@vostro.rjw.lan> <CAKohpokp4YrxKHibewdt+3-WF7P2Fa_bvRidHpjd9SpsT6bPpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohpokp4YrxKHibewdt+3-WF7P2Fa_bvRidHpjd9SpsT6bPpw@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: valdis.kletnieks@vt.edu, artem.savkov@gmail.com, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-dev@lists.linaro.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com
List-Id: linux-pm@vger.kernel.org

On Friday, February 08, 2013 08:06:52 PM Viresh Kumar wrote:
> On 8 February 2013 18:02, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > So as I said, please rework the fixes on top of linux-pm.git/pm-cpufreq.
> 
> I already did. Please check for-rafael branch

Cool.  This is the one I'm supposed to apply, then?

> > Moreover, I'd very much prefer it if you fixed the problems introduced by
> > b8eed8a "cpufreq: Simplify __cpufreq_remove_dev()" separately and *then* any
> > other locking problems you're seeing in the code, although people are not
> > reporting them.
> >
> > You seem to have a clear picture of how the code should work now, so that
> > won't be a big trouble I guess.
> 
> For me all problems are fixed in the current code. :)

Sounds great. :-)

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
