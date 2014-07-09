From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 09/14] cpufreq: cpu0: Move per-cluster initialization code
 to ->init()
Date: Wed, 9 Jul 2014 20:57:47 +0530
Message-ID: <CAKohpokOMs3V250wyWB=wdW6SQEcj+RUQaQZk5MYikUKqF6Nsg@mail.gmail.com>
References: <cover.1404231535.git.viresh.kumar@linaro.org>
	<b26946cc4573904cd1ef0212ad053a983b547c23.1404231535.git.viresh.kumar@linaro.org>
	<53BD576F.2010408@ti.com>
	<CAKohpokz4eyw86Uxp_aA=9T9x-X=kTV=_=zx4dEuC2ZyR=3pKw@mail.gmail.com>
	<53BD5F0C.2050509@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <53BD5F0C.2050509@ti.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Shawn Guo <shawn.guo@linaro.org>, Nishanth Menon <nm@ti.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Tomasz Figa <t.figa@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas P Abraham <thomas.ab@samsung.com>, Arvind Chauhan <arvind.chauhan@arm.com>, Sachin Kamat <spk.linux@gmail.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
List-Id: linux-pm@vger.kernel.org

On 9 July 2014 20:56, Santosh Shilimkar <santosh.shilimkar@ti.com> wrote:
>>> We still *don't* support platforms with separate clock/voltage lines for CPUs.
>>> This would be done in a separate patch.

Probably s/separate/later would be enough to make you happy ?

>> Its already fixed as part of this series.
>>
> I suggest you word the commit in that case. Saying subsequent patch
> adds support for the remainder case. Let me scan the remainder
> patches again to see how its done.
>
> Regards,
> Santosh
