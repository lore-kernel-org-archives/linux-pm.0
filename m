From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFCv7 PATCH 02/10] cpufreq: introduce cpufreq_driver_is_slow
Date: Tue, 23 Feb 2016 02:31:09 +0100
Message-ID: <CAJZ5v0gM56y0+_SCV5RDQzWWJxS_aNWWpi8ZrcGtjZo+fH2uUA@mail.gmail.com>
References: <1456190570-4475-1-git-send-email-smuckle@linaro.org>
	<1456190570-4475-3-git-send-email-smuckle@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456190570-4475-3-git-send-email-smuckle@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Feb 23, 2016 at 2:22 AM, Steve Muckle <steve.muckle@linaro.org> wrote:
> From: Michael Turquette <mturquette@baylibre.com>
>
> Some architectures and platforms perform CPU frequency transitions
> through a non-blocking method, while some might block or sleep. Even
> when frequency transitions do not block or sleep they may be very slow.
> This distinction is important when trying to change frequency from
> a non-interruptible context in a scheduler hot path.
>
> Describe this distinction with a cpufreq driver flag,
> CPUFREQ_DRIVER_FAST. The default is to not have this flag set,
> thus erring on the side of caution.
>
> cpufreq_driver_is_slow() is also introduced in this patch. Setting
> the above flag will allow this function to return false.
>
> [smuckle@linaro.org: change flag/API to include drivers that are too
>  slow for scheduler hot paths, in addition to those that block/sleep]
>
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Michael Turquette <mturquette@baylibre.com>
> Signed-off-by: Steve Muckle <smuckle@linaro.org>

Something more sophisticated than this is needed, because one driver
may actually be able to do "fast" switching in some cases and may not
be able to do that in other cases.

For example, in the acpi-cpufreq case all depends on what's there in
the ACPI tables.

Thanks,
Rafael
