From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v5 09/12] dt-bindings: misc: add bindings for throttler
Date: Wed, 01 Aug 2018 17:27:57 +0900
Message-ID: <5B616F0D.1050901@samsung.com>
References: <20180703234705.227473-1-mka@chromium.org>
        <CGME20180703234851epcas2p366dcf068db0a7761d7cdccabc4f1fb6e@epcas2p3.samsung.com>
        <20180703234705.227473-10-mka@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20180703234705.227473-10-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Kaehlcke <mka@chromium.org>, MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Brian Norris <briannorris@chromium.org>, Douglas Anderson <dianders@chromium.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Lee Jones <lee.jones@linaro.org>, Benson Leung <bleung@chromium.org>, Olof Johansson <olof@lixom.net>
List-Id: linux-pm@vger.kernel.org

Hi Matthias,

On 2018년 07월 04일 08:47, Matthias Kaehlcke wrote:
> The Throttler is used for non-thermal throttling of system components
> like CPUs or devfreq devices.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> --
> Changes in v5:
> - patch added to the series (replacing "dt-bindings: PM / OPP: add
>   opp-throttlers property")
> ---
>  .../devicetree/bindings/misc/throttler.txt          | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/throttler.txt
> 
> diff --git a/Documentation/devicetree/bindings/misc/throttler.txt b/Documentation/devicetree/bindings/misc/throttler.txt
> new file mode 100644
> index 000000000000..2ea80c62dbe1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/throttler.txt
> @@ -0,0 +1,13 @@
> +Throttler driver
> +
> +The Throttler is used for non-thermal throttling of system components like
> +CPUs or devfreq devices.
> +
> +Required properties:
> +- throttler-opps	Array of OPP-v2 phandles with the OPPs used for
> +			throttling.
> +
> +Example:
> +	throttler {
> +		 throttler-opps = <&cpu0_opp03, &cpu1_opp02, &gpu_opp03>;
> +	};
> 

If possible, I hope the more detailed example for "cpu0_opp03, &cpu1_opp02, &gpu_opp03"
because I'm confusing the meaning of 'cpu0_opp03' phandle.

cpu0_opp03 indicates the only one specific OPP entry among set of OPP entries of CPU0 cpufreq? or
cpu0_opp03 indicates the set of OPP entries for CPU0 cpufreq ?


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
