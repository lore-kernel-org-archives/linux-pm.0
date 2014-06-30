From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH 4/6] ARM: tegra: Add soctherm and thermal zones to Tegra124
 device tree
Date: Mon, 30 Jun 2014 14:48:32 -0600
Message-ID: <53B1CD20.3010008@wwwdotorg.org>
References: <1403856699-2140-1-git-send-email-mperttunen@nvidia.com> <1403856699-2140-5-git-send-email-mperttunen@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1403856699-2140-5-git-send-email-mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, mlongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 06/27/2014 02:11 AM, Mikko Perttunen wrote:
> This adds the soctherm thermal sensing and management unit to the
> Tegra124 device tree along with the four thermal zones it exports.

> diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi

> +	thermal-zones {
> +		cpu {
> +			polling-delay-passive = <0>;
> +			polling-delay = <0>;

I think we should still define a polling delay so that if there's SW
that doesn't support HW trip points/interrupts, it still knows how often
it should reasonably check the sensor.

Perhaps a delay of 0 is used to determine whether to use HW trip points
vs polling (I haven't read patch 1 yet)? If so, I'd prefer not to do
that. Rather, the driver should advertize its ability to provide HW trip
points, and it would be up to the core to then make use of them. The DT
should just describe the HW, not assume it can influence SW's choice of
whether to use HW trip points.

> +	soctherm: soctherm@0,700e2000 {
...
> +		reset-names = "soctherm";
> +
> +		#thermal-sensor-cells = <1>;

I don't see any real need for that blank line. If there was, there would
probably be more blank lines in the big list of properties above.
