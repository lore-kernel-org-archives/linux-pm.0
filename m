From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/4] cpufreq: allow driver-specific flags
Date: Mon, 29 Sep 2014 01:54:51 -0700
Message-ID: <CAKohpo=8ernJ=bMJKB5K90nsvy4UpJH67dOnFCi80uyRR3EDvw@mail.gmail.com>
References: <CAKohpo=GiQHJ5eg=TkYAkzvsn=hTNTjSwmH20vitG2Z42zsoDA@mail.gmail.com>
	<1410342112-13264-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1410342112-13264-2-git-send-email-thomas.petazzoni@free-electrons.com>
	<CAKohpom4=nbg510bUb20C6rsG8r184YQ0SiPmPkxj8_8Y04+Bg@mail.gmail.com>
	<20140927224434.19023.35708@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20140927224434.19023.35708@quantum>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Mike Turquette <mike.turquette@linaro.org>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Sachin Kamat <spk.linux@gmail.com>, Thomas Abraham <thomas.ab@samsung.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, "pramod.gurav@smartplayin.com" <pramod.gurav@smartplayin.com>, Rob Herring <rob.herring@linaro.org>, Gregory Clement <gregory.clement@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>
List-Id: linux-pm@vger.kernel.org

On 27 September 2014 15:44, Mike Turquette <mike.turquette@linaro.org> wrote:
> I have another use case for exposing driver flags and I have created a
> similar patch to this locally in my git tree.
>
> Basically some cpufreq drivers may block or sleep during their
> .set_target callback, and others will not. E.g. the former case is the
> common pattern to use the clock framework and the regulator framework,
> both of which hold mutexes and may have slow operations and the latter
> case is more like the Intel P-state driver with just some register
> writes.
>
> For the energy-aware scheduling work it is desirable to know if the
> cpufreq driver can do a "fast" transition of it might sleep, since that
> affects whether we adjust the cpu frequency from the scheduler context
> of whether need to put new work on the workqueue (e.g. waking up a
> kthread dedicated to calling .set_target).

I wasn't against exposing the flags but using the same variable to store
driver specific data.
