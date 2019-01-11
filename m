From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 0/3] drivers: Frequency constraint infrastructure
Date: Fri, 11 Jan 2019 10:47:37 +0100
Message-ID: <CAJZ5v0gs3FnCgFS8rg7vwCeATJKfR+mfMVrpkTbM237XVhpDJQ@mail.gmail.com>
References: <cover.1547197612.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1547197612.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <vireshk@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Matthias Kaehlcke <mka@chromium.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Jan 11, 2019 at 10:18 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Hi,
>
> This commit introduces the frequency constraint infrastructure, which
> provides a generic interface for parts of the kernel to constraint the
> working frequency range of a device.
>
> The primary users of this are the cpufreq and devfreq frameworks. The
> cpufreq framework already implements such constraints with help of
> notifier chains (for thermal and other constraints) and some local code
> (for user-space constraints). The devfreq framework developers have also
> shown interest [1] in such a framework, which may use it at a later
> point of time.
>
> The idea here is to provide a generic interface and get rid of the
> notifier based mechanism.
>
> Only one constraint is added for now for the cpufreq framework and the
> rest will follow after this stuff is merged.
>
> Matthias Kaehlcke was involved in the preparation of the first draft of
> this work and so I have added him as Co-author to the first patch.
> Thanks Matthias.
>
> FWIW, This doesn't have anything to do with the boot-constraints
> framework [2] I was trying to upstream earlier :)

This is quite a bit of code to review, so it will take some time.

One immediate observation is that it seems to do quite a bit of what
is done in the PM QoS framework, so maybe there is an opportunity for
some consolidation in there.

Cheers,
Rafael
