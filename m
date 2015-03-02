From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] cpufreq: hisilicon: add acpu driver
Date: Mon, 2 Mar 2015 11:44:28 +0530
Message-ID: <CAKohpokN3Ljuufv5i+TsoJRanGBVZoqEqF1wmUmCzfGbcPbUZQ@mail.gmail.com>
References: <1424956899-8891-1-git-send-email-leo.yan@linaro.org>
	<1424956899-8891-2-git-send-email-leo.yan@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424956899-8891-2-git-send-email-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Leo Yan <leo.yan@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Dan Zhao <dan.zhao@hisilicon.com>, zhenwei.wang@hisilicon.com, mohaoju@hisilicon.com
List-Id: linux-pm@vger.kernel.org

On 26 February 2015 at 18:51, Leo Yan <leo.yan@linaro.org> wrote:
> Add acpu driver for hisilicon SoC, acpu is application processor
> subsystem. Dependent on the H/W design, the silicon may has the coupled
> clock domain for all clusters, or every cluster can have the dedicated
> clock domain. So this driver will support both implementations.
>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  drivers/cpufreq/Kconfig.arm         |   9 +
>  drivers/cpufreq/Makefile            |   1 +
>  drivers/cpufreq/hisi-acpu-cpufreq.c | 324 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 334 insertions(+)
>  create mode 100644 drivers/cpufreq/hisi-acpu-cpufreq.c

What is stopping from reusing cpufreq-dt driver ?
