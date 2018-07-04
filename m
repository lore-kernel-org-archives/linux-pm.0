From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v5 09/12] dt-bindings: misc: add bindings for throttler
Date: Wed, 4 Jul 2018 15:30:03 +0530
Message-ID: <20180704100003.u4fagd2vxwwbp443@vireshk-i7>
References: <20180703234705.227473-1-mka@chromium.org>
 <20180703234705.227473-10-mka@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180703234705.227473-10-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Kaehlcke <mka@chromium.org>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Brian Norris <briannorris@chromium.org>, Douglas Anderson <dianders@chromium.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Lee Jones <lee.jones@linaro.org>, Benson Leung <bleung@chromium.org>, Olof Johansson <olof@lixom.net>
List-Id: linux-pm@vger.kernel.org

On 03-07-18, 16:47, Matthias Kaehlcke wrote:
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

All you do with these phandles for now is that you parse them and read
"opp-hz" value. For that purpose current bindings look sufficient.
>From OPP point of view:

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
