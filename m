From: Ross Zwisler <zwisler@google.com>
Subject: Re: [PATCH] thermal: add ratelimited thermal and power logging
Date: Mon, 29 Oct 2018 07:21:26 -0600
Message-ID: <CAGRrVHw=Hkch+U9Unrw0DCOWxddCx239hSEbvQTM=xrto1ekoA@mail.gmail.com>
References: <20181022202901.1654-1-zwisler@google.com> <20181024072227.achkbix2ndef2ule@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181024072227.achkbix2ndef2ule@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: viresh.kumar@linaro.org
Cc: linux-kernel@vger.kernel.org, Ricky Liang <jcliang@chromium.org>, amit.kachhap@gmail.com, daniel.lezcano@linaro.org, edubezval@gmail.com, javi.merino@kernel.org, rui.zhang@intel.com, linux-pm@vger.kernel.org, Stephen Barber <smbarber@chromium.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Oct 24, 2018 at 1:22 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 22-10-18, 14:29, Ross Zwisler wrote:
> > From: Ricky Liang <jcliang@chromium.org>
> >
> > Add thermal logs in devfreq_cooling and cpu_cooling.
>
> Why should we add them ?
>
> > Also add logging to
> > power_allocator when it starts to control power.
> >
> > These changes can lead to excessive log spam when running up against
> > thermal limits, so have this logging ratelimited to allow only 1 log each
> > 30 seconds from each of those subsystems.
>
> What's the use of these logs when we are going to print them only once every 30
> seconds ?
>
> I recently extended thermal sysfs support to share more stats.
>
> commit 8ea229511e06 ("thermal: Add cooling device's statistics in sysfs")
>
> Will that be helpful in your case ?
>
> Otherwise we should probably add trace points instead.

Thank you for the review.  Basically we use these prints to get a
notification when a system is having thermal issues.  It's easy to
look in dmesg and see the prints and know that something temperature
related is going on.

However, I agree that the current solution is a bit hacky, and in
looking at it a bit further we don't even cover all the paths that we
need to.  The processor_set_cur_state()  function in
drivers/acpi/processor_thermal.c, for example, is used on the x86_64
systems I'm testing with and wasn't augmented with prints.

I'm going to take a step back and try and find another solution.  The
info you added to sysfs looks very promising, thank you for pointing
it out.
