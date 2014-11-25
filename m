From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH RFC v2 08/12] soc: samsung: pm_domain: Add support for
 parent power domain
Date: Tue, 25 Nov 2014 08:59:29 +0100
Message-ID: <CAPDyKFoBnViXQF=wDYp0x4gaOO4ht3a8KBeY6=k6_Zkkav28pQ@mail.gmail.com>
References: <1416833572-6880-1-git-send-email-amit.daniel@samsung.com>
	<1416834256-11225-1-git-send-email-amit.daniel@samsung.com>
	<1416834256-11225-8-git-send-email-amit.daniel@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:35880 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751614AbaKYH73 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 25 Nov 2014 02:59:29 -0500
Received: by mail-qc0-f174.google.com with SMTP id c9so38271qcz.5
        for <linux-pm@vger.kernel.org>; Mon, 24 Nov 2014 23:59:29 -0800 (PST)
In-Reply-To: <1416834256-11225-8-git-send-email-amit.daniel@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Amit Daniel Kachhap <amit.daniel@samsung.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Kukjin Kim <kgene.kim@samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, pankaj.dubey@samsung.com, Kevin Hilman <khilman@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On 24 November 2014 at 14:04, Amit Daniel Kachhap
<amit.daniel@samsung.com> wrote:
> This patch adds supports for parent power domain. This will ensure
> invoking of parent/child power domain on/off in a correct sequence.
> In exynos7 SOC's, power domain controllers have parent and child
> hierarchy.
>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
> ---
>  .../bindings/arm/exynos/power_domain.txt           |    2 +
>  drivers/soc/samsung/pm_domains.c                   |   43 +++++++++++++++++++-
>  2 files changed, 44 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/arm/exynos/power_domain.txt b/Documentation/devicetree/bindings/arm/exynos/power_domain.txt
> index 00ebda1..0160bdc 100644
> --- a/Documentation/devicetree/bindings/arm/exynos/power_domain.txt
> +++ b/Documentation/devicetree/bindings/arm/exynos/power_domain.txt
> @@ -24,6 +24,7 @@ Optional Properties:
>         - pclkN, clkN: Pairs of parent of input clock and input clock to the
>                 devices in this power domain. Maximum of 4 pairs (N = 0 to 3)
>                 are supported currently.
> +- parents: phandle of parent power domains.
>
>  Node of a device using power domains must have a samsung,power-domain property
>  defined with a phandle to respective power domain.
> @@ -48,6 +49,7 @@ Example:
>         mfc_pd: power-domain@10044060 {
>                 compatible = "samsung,exynos4210-pd", "samsung,exynos7-pd-mfc";
>                 reg = <0x10044060 0x20>;
> +               parents = <&pd_top>;
>                 #power-domain-cells = <0>;
>         };

This seems like a good and generic approach to describe that a PM
domain could have a parent. I would suggest to rename it, such it
reflects its a PM domain binding though.

So, maybe we can add this as a common DT binding for the generic PM
domain instead of having it as Exynos specific?

Kind regards
Uffe
