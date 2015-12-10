From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v6.1 08/10] cpufreq: st: Provide runtime initialised
 driver for ST's platforms
Date: Thu, 10 Dec 2015 14:52:06 +0530
Message-ID: <20151210092206.GC6991@ubuntu>
References: <1449676697-25432-1-git-send-email-lee.jones@linaro.org>
 <1449676697-25432-9-git-send-email-lee.jones@linaro.org>
 <20151210091407.GF17876@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151210091407.GF17876@x1>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, maxime.coquelin@st.com, linux-pm@vger.kernel.org, rjw@rjwysocki.net, devicetree@vger.kernel.org, ajitpal.singh@st.com
List-Id: linux-pm@vger.kernel.org

On 10-12-15, 09:14, Lee Jones wrote:
> The bootloader is charged with the responsibility to provide platform
> specific Dynamic Voltage and Frequency Scaling (DVFS) information via
> Device Tree.  This driver takes the supplied configuration and
> registers it with the new generic OPP framework, to then be used with
> CPUFreq.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
> Viresh,
>   This incremental submission contains fixes to your last requests.
> 
>  drivers/cpufreq/Kconfig.arm   |  10 ++
>  drivers/cpufreq/Makefile      |   1 +
>  drivers/cpufreq/sti-cpufreq.c | 294 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 305 insertions(+)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
