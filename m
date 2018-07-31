From: skannan@codeaurora.org
Subject: Re: [PATCH] PM / devfreq: Generic cpufreq governor
Date: Tue, 31 Jul 2018 12:24:59 -0700
Message-ID: <304a412a17e9bff85991eb1e7e175be8@codeaurora.org>
References: <1532750217-8886-1-git-send-email-skannan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1532750217-8886-1-git-send-email-skannan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rajendra Nayak <rnayak@codeaurora.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 2018-07-27 20:56, Saravana Kannan wrote:
> Many CPU architectures have caches that can scale independent of the 
> CPUs.
> Frequency scaling of the caches is necessary to make sure the cache is 
> not
> a performance bottleneck that leads to poor performance and power. The 
> same
> idea applies for RAM/DDR.
> 
> To achieve this, this patch adds a generic devfreq governor that can 
> listen
> to the frequency transitions of each CPU frequency domain and then 
> adjusts
> the frequency of the cache (or any devfreq device) based on the 
> frequency
> of the CPUs.
> 
> To decide the frequency of the device, the governor does one of the
> following:
> 
> * Uses a CPU frequency to device frequency mapping table
>   - Either one mapping table used for all CPU freq policies (typically 
> used
>     for system with homogeneous cores/clusters that have the same OPPs.
>   - One mapping table per CPU freq policy (typically used for ASMP 
> systems
>     with heterogeneous CPUs with different OPPs)
> 
> OR
> 
> * Scales the device frequency in proportion to the CPU frequency. So, 
> if
>   the CPUs are running at their max frequency, the device runs at its 
> max
>   frequency.  If the CPUs are running at their min frequency, the 
> device
>   runs at its min frequency. And interpolated for frequencies in 
> between.
> 
> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
> ---
>  .../bindings/devfreq/devfreq-cpufreq.txt           |  53 ++
>  drivers/devfreq/Kconfig                            |   8 +
>  drivers/devfreq/Makefile                           |   1 +
>  drivers/devfreq/governor_cpufreq.c                 | 583 
> +++++++++++++++++++++
>  4 files changed, 645 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/devfreq/devfreq-cpufreq.txt
>  create mode 100644 drivers/devfreq/governor_cpufreq.c
> 
> diff --git
> a/Documentation/devicetree/bindings/devfreq/devfreq-cpufreq.txt
> b/Documentation/devicetree/bindings/devfreq/devfreq-cpufreq.txt
> new file mode 100644
> index 0000000..6537538

MyungJoo, Chanwoo,

Thoughts? Good enough to merge?

Rob,

DT review? I know this DT documentation should be a separate patch, but 
I've kept it here for context. I can split it up once the code and the 
binding have been agreed to.

Thanks,
Saravana
