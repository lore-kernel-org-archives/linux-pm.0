From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 0/3] drivers: Frequency constraint infrastructure
Date: Fri, 8 Feb 2019 11:35:15 +0100
Message-ID: <CAJZ5v0gNhmqY_oem9SZk2fEkOikmjTK3YfFRuOi8f=66GSgVuw@mail.gmail.com>
References: <cover.1547197612.git.viresh.kumar@linaro.org> <CAJZ5v0gs3FnCgFS8rg7vwCeATJKfR+mfMVrpkTbM237XVhpDJQ@mail.gmail.com>
 <20190208090912.43aao5kny42iirum@vireshk-i7> <CAJZ5v0iE9tFt9Xs27EYcjv6N1KAq-LaAQnv=QBvnbNRpfwrWCg@mail.gmail.com>
 <20190208102346.ophy3eqhxjzaqsxr@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190208102346.ophy3eqhxjzaqsxr@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Rafael Wysocki <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Viresh Kumar <vireshk@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Matthias Kaehlcke <mka@chromium.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Feb 8, 2019 at 11:23 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 08-02-19, 10:53, Rafael J. Wysocki wrote:
> > On Fri, Feb 8, 2019 at 10:09 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > On 11-01-19, 10:47, Rafael J. Wysocki wrote:
> > > > On Fri, Jan 11, 2019 at 10:18 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > This commit introduces the frequency constraint infrastructure, which
> > > > > provides a generic interface for parts of the kernel to constraint the
> > > > > working frequency range of a device.
> > > > >
> > > > > The primary users of this are the cpufreq and devfreq frameworks. The
> > > > > cpufreq framework already implements such constraints with help of
> > > > > notifier chains (for thermal and other constraints) and some local code
> > > > > (for user-space constraints). The devfreq framework developers have also
> > > > > shown interest [1] in such a framework, which may use it at a later
> > > > > point of time.
> > > > >
> > > > > The idea here is to provide a generic interface and get rid of the
> > > > > notifier based mechanism.
> > > > >
> > > > > Only one constraint is added for now for the cpufreq framework and the
> > > > > rest will follow after this stuff is merged.
> > > > >
> > > > > Matthias Kaehlcke was involved in the preparation of the first draft of
> > > > > this work and so I have added him as Co-author to the first patch.
> > > > > Thanks Matthias.
> > > > >
> > > > > FWIW, This doesn't have anything to do with the boot-constraints
> > > > > framework [2] I was trying to upstream earlier :)
> > > >
> > > > This is quite a bit of code to review, so it will take some time.
> > >
> > > @Rafael: You are going to provide some more feedback here, right ?
> >
> > I think I've said something already.
> >
> > TLDR: I'm not convinced.
> >
> > PM QoS does similar things in a similar way.  Why does it have to be a
> > different framework?
>
> I did it because no one objected to the initial proposal [1]. But you
> weren't directly cc'd (but only PM list) so can't blame you either :)
>
> Maybe we can make it work with PM QoS as well, I will see that aspect.

At least some of the underlying mechanics seem to be very similar.
You have priority lists, addition and removal of requests etc.

Arguably, PM QoS may be regarded as a bit overly complicated, but
maybe they both can use a common library underneath?

> > Using freq constraints for thermal reasons without coordinating it
> > with scheduling is questionable in general, because thermal control
> > may work against scheduling then.
>
> Sure, I agree but all we are talking about here is the mechanism with
> which the constraints should be put and it doesn't make things bad
> than they already are. With the notifiers in place currently, thermal
> core doesn't talk to scheduler.
>
> I think a different set of people are trying to fix that by issuing
> some calls to scheduler from thermal core, or something like that but
> I still consider that work orthogonal to the way constraints should be
> added instead of notifiers.
>
> Will implementing it the QoS way would be fine from thermal-scheduler
> standpoint ?

As I said I like the idea of replacing cpufreq notifiers with
something nicer, so if you can avoid doing almost-the-same-ting in two
different frameworks, it would be fine by me.
