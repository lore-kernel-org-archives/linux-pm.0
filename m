From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFC v11 2/3] ARM: imx6: pm: declare pm domain latency on
 power_state struct.
Date: Tue, 9 Feb 2016 16:39:43 +0100
Message-ID: <CAPDyKFoVfZ263WvrLLT6XnaLt7kGGswUhYNUy0RGzSAV1=4N9g@mail.gmail.com>
References: <1455023751-32521-1-git-send-email-ahaslam@baylibre.com>
	<1455023751-32521-3-git-send-email-ahaslam@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f179.google.com ([209.85.161.179]:34724 "EHLO
	mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756698AbcBIPjo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 9 Feb 2016 10:39:44 -0500
Received: by mail-yw0-f179.google.com with SMTP id h129so129424844ywb.1
        for <linux-pm@vger.kernel.org>; Tue, 09 Feb 2016 07:39:43 -0800 (PST)
In-Reply-To: <1455023751-32521-3-git-send-email-ahaslam@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Axel Haslam <ahaslam@baylibre.com>
Cc: Lina Iyer <lina.iyer@linaro.org>, Kevin Hilman <khilman@baylibre.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Marc Titinger <mtitinger@baylibre.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Benoit Cousson <bcousson@baylibre.com>, Axel Haslam <ahaslam+renesas@baylibre.com>

On 9 February 2016 at 14:15,  <ahaslam@baylibre.com> wrote:
> From: Axel Haslam <ahaslam+renesas@baylibre.com>
>
> The generic_pm_domain structure uses an array of latencies to be able to
> declare multiple intermediate states.
>
> Declare a single "OFF" state with the default latencies So that the
> power_off_latency_ns and power_on_latency_ns fields of generic_pm_domain
> structure can be eventualy removed.
>
> Signed-off-by: Axel Haslam <ahaslam+renesas@baylibre.com>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> [Lina: pm_genpd_init() argument change]

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  arch/arm/mach-imx/gpc.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-imx/gpc.c b/arch/arm/mach-imx/gpc.c
> index cfc696b..2630d94 100644
> --- a/arch/arm/mach-imx/gpc.c
> +++ b/arch/arm/mach-imx/gpc.c
> @@ -369,13 +369,20 @@ static struct generic_pm_domain imx6q_arm_domain = {
>         .name = "ARM",
>  };
>
> +static struct genpd_power_state imx6q_arm_domain_states[] = {
> +       {
> +               .power_off_latency_ns = 25000,
> +               .power_on_latency_ns = 2000000,
> +       },
> +};
> +
>  static struct pu_domain imx6q_pu_domain = {
>         .base = {
>                 .name = "PU",
>                 .power_off = imx6q_pm_pu_power_off,
>                 .power_on = imx6q_pm_pu_power_on,
> -               .power_off_latency_ns = 25000,
> -               .power_on_latency_ns = 2000000,
> +               .states = imx6q_arm_domain_states,
> +               .state_count = ARRAY_SIZE(imx6q_arm_domain_states),
>         },
>  };
>
> --
> 2.6.3
>
