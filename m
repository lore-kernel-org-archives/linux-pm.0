From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2] cpufreq: brcmstb-cpufreq: CPUfreq driver for older
 Broadcom STB SoCs
Date: Tue, 22 Nov 2016 08:53:15 +0530
Message-ID: <20161122032315.GA3070@vireshk-i7>
References: <20161122010616.91307-1-code@mmayer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161122010616.91307-1-code@mmayer.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Markus Mayer <code@mmayer.net>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Power Management List <linux-pm@vger.kernel.org>, Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Markus Mayer <mmayer@broadcom.com>
List-Id: linux-pm@vger.kernel.org

On 21-11-16, 17:06, Markus Mayer wrote:
> From: Markus Mayer <mmayer@broadcom.com>
> 
> This CPUfreq driver provides basic frequency scaling for older Broadcom
> STB SoCs that do not use AVS firmware with DVFS support. There is no
> support for voltage scaling.
> 
> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
> ---
>  drivers/cpufreq/Kconfig.arm       |  12 ++
>  drivers/cpufreq/Makefile          |   1 +
>  drivers/cpufreq/brcmstb-cpufreq.c | 381 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 394 insertions(+)
>  create mode 100644 drivers/cpufreq/brcmstb-cpufreq.c

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
