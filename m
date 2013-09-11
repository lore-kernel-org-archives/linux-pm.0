From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v8 0/7] cpufreq:boost: CPU Boost mode support
Date: Wed, 11 Sep 2013 13:20:41 +0530
Message-ID: <CAKohpo=4sg9AkXuwBwLVuj7_sdAdwap7a0Yp41KSEHvNMyWaTQ@mail.gmail.com>
References: <CAKohpom90VAMYHkp3stbJJ-7H3y3zrVoQ+1q=Vza2Q0JhG8bNw@mail.gmail.com>
	<20130910141603.6225fe4e@amdc308.digital.local>
	<1525010.ijhgMNYcdJ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1525010.ijhgMNYcdJ@vostro.rjw.lan>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Lukasz Majewski <l.majewski@samsung.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
List-Id: linux-pm@vger.kernel.org

That is some important piece of information that might be useful for
others and so cc'ing LKML and other lists..

On 11 September 2013 01:06, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Tuesday, September 10, 2013 02:16:03 PM Lukasz Majewski wrote:
>> For my curiosity - what is the difference between bleeding-edge and
>> linux-next branches at kernel_pm?
>
> linux-next are patches that I'm going to push to Linus in the future and that
> have passed automated build testing.  I still may drop one of them occasionally
> or add tags to commits and rebase the branch as a result, though.
>
> bleeding-edge is linux-next plus patches under automated build testing, but it
> may contain some purely experimental stuff too.  During a merge window, like
> for example today, it also may contain material for the second next release
> (like 3.13 at the moment).
>
> In addition to those, there are topic branches like pm-cpufreq, acpica etc.
> that are only material either in the Linus' tree already or going to be pushed
> to Linus going forward and I don't rebase them.
>
> So if you want a stable branch to work on top of, either use one of the topic
> branches (but please note that they may be somewhat behind Linus sometimes), or
> ask me for one directly.
>
> Thanks,
> Rafael
>
