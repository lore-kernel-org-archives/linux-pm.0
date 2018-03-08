From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] thermal: of: Allow selection of thermal governor in DT
Date: Thu, 8 Mar 2018 10:19:56 +0530
Message-ID: <CAOh2x=njFxcwDfQs1g3-Estrun5j=fSYVnG-EaVw0UcRaDKsSg@mail.gmail.com>
References: <cover.1520274879.git.amit.kucheria@linaro.org>
 <3b80853abb45a9e067cf7a16754b07bb67712457.1520274879.git.amit.kucheria@linaro.org>
 <6d5aeab8-aafe-fa3b-585e-953a34864e7d@arm.com> <CAP245DVwaY84+fZrbne1RLK9gKsfSTE2TELDAC0RkZGMzFkpWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAP245DVwaY84+fZrbne1RLK9gKsfSTE2TELDAC0RkZGMzFkpWg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Amit Kucheria <amit.kucheria@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Ram Chandrasekar <rkumbako@codeaurora.org>, DTML <devicetree@vger.kernel.org>, Lina Iyer <ilina@codeaurora.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Mar 7, 2018 at 4:29 PM, Amit Kucheria <amit.kucheria@linaro.org> wrote:
> Cpufreq/cpuidle are designed to control a single parameter while
> thermal framework is trying to mitigate heat from several disparate
> sources that are throttled in different ways. Besides, cpufreq/cpuidle
> have somewhat mature governors. Cpuidle has only one governor (for
> tickless) - menu governor, cpufreq has ondemand in mainline, replaced
> by interactive in android and hopefully soon both will be replaced by

Interactive and schedfreq are already removed from Android 4.4 and 4.9.
It used schedutil now.

> schedutil.
>
> Badly configured cpufreq/cpuidle/devfreq only leads to wasted power,
> while badly configured thermal zone leads to the loss of operation
> e.g. reboots, too hot to touch, etc.

I don't think such heat-ups will happen right during boot, where some
init.rc should
come up and change the governor.

Over that if we are worried about production images only, then what prevents us
to select the right default governor in the defconfig ? We shouldn't
be worried about
multi-platform kernels for production images.

--
viresh
