From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] cpufreq: userspace: Simplify governor
Date: Tue, 18 Jun 2013 15:32:37 +0200
Message-ID: <3393395.Lr3gVarna8@vostro.rjw.lan>
References: <68ae523282b494da0e8f67536af1df874c326675.1370422554.git.viresh.kumar@linaro.org> <CAKohpon3Tc+dSycv-QeLg9vwjXijaZrtjzw0-tHVAqX6moBUjA@mail.gmail.com> <CAKohpokwbLyCiL88i+6hKaLiKciZ0mZhOqenSzOJ7oBfgsCpZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohpokwbLyCiL88i+6hKaLiKciZ0mZhOqenSzOJ7oBfgsCpZg@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, arvind.chauhan@arm.com, chenxg.marvell@gmail.com
List-Id: linux-pm@vger.kernel.org

On Tuesday, June 18, 2013 10:20:33 AM Viresh Kumar wrote:
> On 5 June 2013 18:38, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > To be honest with the amount of experience I have now, my log was
> > poor :(
> >
> > I have used following log in the attached patch:
> >
> > Subject: [PATCH] cpufreq: userspace: Simplify governor
> >
> > Userspace governor has got more code than what it needs for its functioning.
> > Lets simplify it. Portions of code removed are:
> > - Extra header files which aren't required anymore (rearranged them as well)
> > - cpu_{max|min|cur|set}_freq, as they are always same as policy->{max|min|cur}
> > - userspace_cpufreq_notifier_block as we don't need to set cpu_cur_freq anymore
> > - cpus_using_userspace_governor as it was for notifier code
> >
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> Hi Rafael,
> 
> Are you happy with the log & description of this patch now?

Yes, I am.  I'm hoping to get to the pending patches later today.

Thanks,
Rafael

