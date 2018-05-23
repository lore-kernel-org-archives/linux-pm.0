From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 2/2] PM / devfreq: Generic cpufreq governor
Date: Wed, 23 May 2018 11:58:34 -0500
Message-ID: <20180523165834.GA11016@rob-hp-laptop>
References: <1526631889-5084-1-git-send-email-skannan@codeaurora.org>
 <1526631889-5084-3-git-send-email-skannan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1526631889-5084-3-git-send-email-skannan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Saravana Kannan <skannan@codeaurora.org>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Mark Rutland <mark.rutland@arm.com>, Rajendra Nayak <rjendra@codeaurora.org>, Amit Kucheria <amit.kucheria@linaro.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, May 18, 2018 at 01:24:48AM -0700, Saravana Kannan wrote:
> This devfreq governor is a generic implementation that can scale any
> devfreq device based on the current CPU frequency of all ONLINE CPUs. It
> allows for specifying CPU freq to devfreq mapping for specific devices.
> When such a mapping is not present, it defaults to scaling the device
> frequency in proportion to the CPU frequency.
> 
> Change-Id: I7f786b9059435afe85b9ec8c504a4655731ee20e

drop this.

> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
> ---
>  .../bindings/devfreq/devfreq-cpufreq.txt           |  53 ++

Please split bindings to separate patch.

>  drivers/devfreq/Kconfig                            |   8 +
>  drivers/devfreq/Makefile                           |   1 +
>  drivers/devfreq/governor_cpufreq.c                 | 628 +++++++++++++++++++++
>  4 files changed, 690 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/devfreq/devfreq-cpufreq.txt
>  create mode 100644 drivers/devfreq/governor_cpufreq.c
> 
> diff --git a/Documentation/devicetree/bindings/devfreq/devfreq-cpufreq.txt b/Documentation/devicetree/bindings/devfreq/devfreq-cpufreq.txt
> new file mode 100644
> index 0000000..6537538
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/devfreq/devfreq-cpufreq.txt
> @@ -0,0 +1,53 @@
> +Devfreq CPUfreq governor
> +
> +devfreq-cpufreq is a parent device that contains one or more child devices.
> +Each child device provides CPU frequency to device frequency mapping for a
> +specific device. Examples of devices that could use this are: DDR, cache and
> +CCI.
> +
> +Parent device name shall be "devfreq-cpufreq".

I don't really understand any of this and how it relates to the other 
QCom cpufreq and devfreq bindings. Seems like this all needs some 
discussion amongst the PM folks first.

Rob
