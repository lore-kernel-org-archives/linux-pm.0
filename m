From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 0/4] cpufreq-dt, platform_data based proposal
Date: Wed, 10 Sep 2014 16:08:51 +0530
Message-ID: <CAKohpo=C99cqO2FLoAex6NiCFVPY5ZmWcvdyxG_T-fHJjo+W=A@mail.gmail.com>
References: <CAKohpo=GiQHJ5eg=TkYAkzvsn=hTNTjSwmH20vitG2Z42zsoDA@mail.gmail.com>
	<1410342112-13264-1-git-send-email-thomas.petazzoni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1410342112-13264-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Sachin Kamat <spk.linux@gmail.com>, Thomas Abraham <thomas.ab@samsung.com>, Tomasz Figa <t.figa@samsung.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, "pramod.gurav@smartplayin.com" <pramod.gurav@smartplayin.com>, Rob Herring <rob.herring@linaro.org>, Mike Turquette <mike.turquette@linaro.org>, Gregory Clement <gregory.clement@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>
List-Id: linux-pm@vger.kernel.org

On 10 September 2014 15:11, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> And with Viresh not accepting any machine specific driver, it

Its not that we aren't accepting any drivers at all, but if we can reuse
existing infrastructure then we better use it for long term maintainability.

But there is another view here which Mike objected to, sometime back.
Its also not a good idea to push everything onto a virtual-cpu-clock
driver..

I had something in mind to get that fixed, but this thread hasn't allowed
me to work on that as it should be finished first.

Probably we can add some callbacks to the cpufreq-cpu0 driver. For
example if somebody wants to do something crazy enough in their
->target() routine then they can just register their callback and we
will call it instead of cpufreq-dt's target() routine..

That way we can still reuse the common part..

> results in platforms like Armada XP having no solution to support
> cpufreq...
>
> So this proposal consists in adding a platform_data flag for the
> cpufreq-dt driver, which allows platform code to tell whether CPU
> clocks are shared or are independent.
>
> If you don't like platform_data, we can also register two different
> platform_driver for the two different cases, simply with different
> names.
>
> Another approach would be to lift the ban on machine-specific cpufreq
> drivers, since the generic driver is not capable of handling all
> situations.

The platform-data solution is better than any other here :), and that
will get fixed once we get all this including which driver to probe from
DT..
