From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH 2/6] of: Add bindings for nvidia,tegra124-soctherm
Date: Mon, 30 Jun 2014 14:40:43 -0600
Message-ID: <53B1CB4B.7050706@wwwdotorg.org>
References: <1403856699-2140-1-git-send-email-mperttunen@nvidia.com> <1403856699-2140-3-git-send-email-mperttunen@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1403856699-2140-3-git-send-email-mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, mlongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 06/27/2014 02:11 AM, Mikko Perttunen wrote:
> This adds binding documentation and headers for the Tegra124
> SOCTHERM device tree node.

> diff --git a/Documentation/devicetree/bindings/thermal/tegra-soctherm.txt b/Documentation/devicetree/bindings/thermal/tegra-soctherm.txt

> +Required properties :
...
> +- #thermal-sensor-cells : For thermctl sensors. Should be 1.

I'd prefer a tiny bit more information here: A link to whatever other
document defines the meaning of #thermal-sensor-cells, and a link to the
header that defines the meaning of the data in the cell. Perhaps:

#thermal-sensor-cells : Should be 1. See ./thermal.txt for a description
of this property. See <dt-bindings/thermal/tegra124-soctherm.h> for a
list of valid values.

> diff --git a/include/dt-bindings/thermal/tegra124-soctherm.h b/include/dt-bindings/thermal/tegra124-soctherm.h
> +#endif
> +
> +

There are a couple of blank lines at the end of that file.
