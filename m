From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 Resend 00/92] CPUFreq Cleanup Series: Part II
Date: Fri, 11 Oct 2013 19:27:44 +0530
Message-ID: <CAKohponVmnQr-QuPAW-aHyVJYpWX9ODdF5x-RbTdtjrVjn807A@mail.gmail.com>
References: <cover.1380783079.git.viresh.kumar@linaro.org>
	<4259753.v7BpD2vKia@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <4259753.v7BpD2vKia@vostro.rjw.lan>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 11/10/2013, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> So I've just added this to bleeding-edge, but I have a couple complaints.

Thanks..

> First off, this is three patch sets in one.  The first part is the generic
> .attr(), exit() and .verify() one, the second part is the duplicated
> initialization and the third one is about cpufreq_generic_init().  They
> really should have been posted and reviewed separately.

They were posted and reviewed separately earlier.. Only this time
I have merged them together for applying..

> And while I'm basically OK with the first and the third part, I'm concerned
> about the second one, because it has potential to introduce some subtle
> initialization issues (initializing something twice is not a bug per se,
> although it is inefficient, but failing to initialize that or initializing
> it
> with an incorrect value *is* a bug).

I agree.. Lets see if it breaks anything... I will get it fixed as soon as
possible.. (BTW, there was a fixup for the last series that you missed
to apply: fixup! cpufreq: sa11x0: Expose frequency table)

> Second, can you please make your own patch sets apply on top of each other
> next time?

I wasn't sure if you are going to apply the 11 patch patchset before
this one or not.. and hence have applied it directly on top of linux-next..

> Besides, I'm not going to apply any patchset with more than 40 patches in
> it
> in one go any more unless I'm seriously convinced that this is the only way
> to go.

Okay.. I will take care of this next time..
