From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2 2/2] cpufreq: Change freq before suspending governors
Date: Sun, 24 Nov 2013 22:32:13 +0100
Message-ID: <2065978.h16hV1Cgky@vostro.rjw.lan>
References: <cover.1385118255.git.viresh.kumar@linaro.org> <CAKohpo=RWi1nRUJq4qx8K+Y7swMDaqwEOH24-KfBCMgdbW=hMQ@mail.gmail.com> <528FB2EC.2020202@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <528FB2EC.2020202@wwwdotorg.org>
Sender: cpufreq-owner@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Stephen Warren <swarren@nvidia.com>, Kukjin Kim <kgene@kernel.org>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Sachin Kamat <sachin.kamat@linaro.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Lan Tianyu <tianyu.lan@intel.com>, Nishanth Menon <nm@ti.com>, jinchoi@broadcom.com, Sebastian Capella <sebastian.capella@linaro.org>, Peter De Schrijver <pdeschrijver@nvidia.com>
List-Id: linux-pm@vger.kernel.org

On Friday, November 22, 2013 12:39:24 PM Stephen Warren wrote:
> On 11/22/2013 05:52 AM, Viresh Kumar wrote:
> > On 22 November 2013 18:07, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >> On Friday, November 22, 2013 04:59:49 PM Viresh Kumar wrote:
> >>> Some platforms might want to change frequency before suspending governors. Like:
> >>> - Some platform which want to set freq to max to speed up suspend/hibernation
> >>>   process.
> >>> - Some platform (like: Tegra or exynos), set this to min or bootloader's
> >>>   frequency.
> >>>
> >>> This patch adds an option for those, so that they can specify this at call to
> >>> ->init(), so that cpufreq core can take care of this before suspending system.
> >>>
> >>> If this variable is not updated by ->init() then its value would be zero and so
> >>> core wouldn't do anything.
> >>>
> >>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> >>
> >> I don't think this is generally necessary, because the suspend/resume routines
> >> added by patch [1/2] will be executed very late during suspend or very early
> >> during resume and it shouldn't really matter what performance levels the CPUs
> >> are at then.
> > 
> > There are few things here:
> > - I feel that the current place from where we have suspended stuff is not gonna
> > fly. We are doing that in noirq and probably devices which might be required
> > during frequency transitions might already be down.. So we *may* need to
> > move that in dpm_suspend()..
> > - Secondly I want to understand why Tegra/Exynos has such code which I
> > mentioned above..
> > 
> > @Stephen, Kukjin and other samsung folks: Please provide some input here,
> > before your systems break in mainline :)
> 
> I believe we set the clock to a low value because fast clocks consume
> more power. Tegra architecturally supports a number of different suspend
> levels. Only some of those actually power off or gate the clock source
> itself.

Hmm.

Viresh, maybe make it possible for the cpufreq driver to provide suspend/resume
callbacks to be executed by cpufreq_suspend() and cpufreq_resume() introduced
by [1/2]?  Then Tegra could set the frequencies to what it wants from there
before the governors are stopped.

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
