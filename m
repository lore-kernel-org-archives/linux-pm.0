From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCHv2 0/4] cpufreq-dt, platform_data based proposal
Date: Mon, 6 Oct 2014 09:19:05 +0200
Message-ID: <20141006091905.4e0d976a@free-electrons.com>
References: <CAKohpo=GiQHJ5eg=TkYAkzvsn=hTNTjSwmH20vitG2Z42zsoDA@mail.gmail.com>
	<1410350908-11316-1-git-send-email-thomas.petazzoni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1410350908-11316-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Sachin Kamat <spk.linux@gmail.com>, Thomas Abraham <thomas.ab@samsung.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, "pramod.gurav@smartplayin.com" <pramod.gurav@smartplayin.com>, Rob Herring <rob.herring@linaro.org>, Mike Turquette <mike.turquette@linaro.org>, Gregory Clement <gregory.clement@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>
List-Id: linux-pm@vger.kernel.org

Hello,

On Wed, 10 Sep 2014 14:08:24 +0200, Thomas Petazzoni wrote:

> Thomas Petazzoni (4):
>   cpufreq: allow driver-specific data
>   cpufreq: cpufreq-dt: extend with platform_data
>   ARM: mvebu: use the cpufreq-dt platform_data for independent clocks
>   cpufreq: cpufreq-dt: adjust message related to regulators
> 
>  arch/arm/mach-mvebu/pmsu.c   |  8 +++++++-
>  drivers/cpufreq/cpufreq-dt.c | 21 +++++++++++++++++----
>  drivers/cpufreq/cpufreq.c    | 15 +++++++++++++++
>  include/linux/cpufreq-dt.h   | 22 ++++++++++++++++++++++
>  include/linux/cpufreq.h      |  2 ++
>  5 files changed, 63 insertions(+), 5 deletions(-)
>  create mode 100644 include/linux/cpufreq-dt.h

Since this series was Acked-by Viresh, would it be possible to get it
merged for 3.18 ?

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
