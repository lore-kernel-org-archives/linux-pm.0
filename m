From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH V2 1/2] cpufreq: suspend governors on system suspend/hibernate
Date: Mon, 25 Nov 2013 15:30:21 -0600
Message-ID: <5293C16D.80605@ti.com>
References: <cover.1385118255.git.viresh.kumar@linaro.org> <e4bc55fac6bc68694e9905cc3cc6844173b64925.1385118256.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <e4bc55fac6bc68694e9905cc3cc6844173b64925.1385118256.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, rjw@rjwysocki.net
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, tianyu.lan@intel.com, jinchoi@broadcom.com, sebastian.capella@linaro.org
List-Id: linux-pm@vger.kernel.org

On 11/22/2013 05:29 AM, Viresh Kumar wrote:
> This patch adds cpufreq callbacks to dpm_{suspend|resume}_noirq() for handling
> suspend/resume of cpufreq governors. This is required for early suspend and late
> resume of governors.
> 
> There are multiple problems that are fixed by this patch:
> - Nishanth Menon (TI) found an interesting problem on his platform, OMAP. His board
>   wasn't working well with suspend/resume as calls for removing non-boot CPUs
>   was turning out into a call to drivers ->target() which then tries to play
>   with regulators. But regulators and their I2C bus were already suspended and
>   this resulted in a failure. This is why we need a PM notifier here.
> - Lan Tianyu (Intel) & Jinhyuk Choi (Broadcom) found another issue where
>   tunables configuration for clusters/sockets with non-boot CPUs was getting
>   lost after suspend/resume, as we were notifying governors with
>   CPUFREQ_GOV_POLICY_EXIT on removal of the last cpu for that policy and so
>   deallocating memory for tunables.
> 
> Reported-by: Lan Tianyu <tianyu.lan@intel.com>
> Reported-by: Nishanth Menon <nm@ti.com>
> Reported-by: Jinhyuk Choi <jinchoi@broadcom.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/base/power/main.c |  3 +++
>  drivers/cpufreq/cpufreq.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/cpufreq.h   |  3 +++
>  3 files changed, 68 insertions(+)
yes, this seems to work for me as well.
http://pastebin.mozilla.org/3670909 - no cpufreq attempts to
transition were triggered.

-- 
Regards,
Nishanth Menon
