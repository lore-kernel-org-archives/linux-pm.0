From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2 Resend 00/92] CPUFreq Cleanup Series: Part II
Date: Sat, 12 Oct 2013 22:30:54 +0200
Message-ID: <1786792.VSPfic7BzP@vostro.rjw.lan>
References: <cover.1380783079.git.viresh.kumar@linaro.org> <2275177.Q2M8STIc5R@vostro.rjw.lan> <CAKohpon+F3Y_azLaU80u=QKkmY_f5P2kM0cz-z9bZRSj55=Qcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohpon+F3Y_azLaU80u=QKkmY_f5P2kM0cz-z9bZRSj55=Qcg@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Saturday, October 12, 2013 08:52:33 PM Viresh Kumar wrote:
> On 12/10/2013, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Saturday, October 12, 2013 06:55:59 AM Viresh Kumar wrote:
> >> On 12/10/2013, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >> > On Friday, October 11, 2013 07:27:44 PM Viresh Kumar wrote:
> >> >> On 11/10/2013, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >> >> > So I've just added this to bleeding-edge, but I have a couple
> >> >> > complaints.
> >> >>
> >> >> Thanks..
> >> >>
> >> >> > First off, this is three patch sets in one.  The first part is the
> >> >> > generic
> >> >> > .attr(), exit() and .verify() one, the second part is the duplicated
> >> >> > initialization and the third one is about cpufreq_generic_init().
> >> >> > They
> >> >> > really should have been posted and reviewed separately.
> >> >>
> >> >> They were posted and reviewed separately earlier.. Only this time
> >> >> I have merged them together for applying..
> >> >>
> >> >> > And while I'm basically OK with the first and the third part, I'm
> >> >> > concerned
> >> >> > about the second one, because it has potential to introduce some
> >> >> > subtle
> >> >> > initialization issues (initializing something twice is not a bug per
> >> >> > se,
> >> >> > although it is inefficient, but failing to initialize that or
> >> >> > initializing
> >> >> > it
> >> >> > with an incorrect value *is* a bug).
> >> >>
> >> >> I agree.. Lets see if it breaks anything... I will get it fixed as
> >> >> soon
> >> >> as
> >> >> possible.. (BTW, there was a fixup for the last series that you missed
> >> >> to apply: fixup! cpufreq: sa11x0: Expose frequency table)
> >> >
> >> > Any links?
> >>
> >> https://lkml.org/lkml/2013/10/4/7
> >
> > OK, so which commit introduced the breakage?
> 
> I thought you will pick it from the link :)
> 
> 22c8b4f cpufreq: sa11x0: Expose frequency table

Applied.

Next time please respin the original patch instead of posting "fixups",
because that is less than helpful.

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
