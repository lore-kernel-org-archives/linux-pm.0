From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V4] cpufreq: suspend governors on system suspend/hibernate
Date: Thu, 28 Nov 2013 19:49:29 +0530
Message-ID: <CAKohpondYbBeObUJJqNZLe04dmN9tLMZv9KrjzqLr2NDorRtLw@mail.gmail.com>
References: <28d493f20239a242a7b26dfe1efed40d83bf1e10.1385523340.git.viresh.kumar@linaro.org>
	<3057132.zHNVNQZ8pP@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <3057132.zHNVNQZ8pP@vostro.rjw.lan>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Warren <swarren@wwwdotorg.org>, Kgene Kim <kgene.kim@samsung.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, linux-tegra@vger.kernel.org, jinchoi@broadcom.com, Lan Tianyu <tianyu.lan@intel.com>, Sebastian Capella <sebastian.capella@linaro.org>, Jonghwan Choi <jhbird.choi@samsung.com>
List-Id: linux-pm@vger.kernel.org

On 28 November 2013 19:53, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> I don't think that the Nishanth's issue is fixed by this particular version of
> the patch, so I modified the changelog and removed a the comment above
> cpufreq_suspend()

No, it does fix his issue as we are just stopping the governors from
dpm_suspend_noirq() and not initiating any new transitions. I said we need
these calls from dpm_suspend() instead as platforms like exynos and tegra
do need to change frequency before suspending..

See:

https://lkml.org/lkml/2013/11/25/692

> (which should be a proper kerneldoc one if any, BTW).

Okay.. I will add that separately..

> I've also made some minor changes to the conditionals, because I didn't like them
> the way they were written originally.
>
> Please check the result in bleeding-edge.

Everything else is fine..
