From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 8/8] PM / doc: Update device documentation for devices
 in IRQ safe PM domains
Date: Mon, 10 Oct 2016 13:06:48 +0200
Message-ID: <CAPDyKFrPwp=iOH3jmDdwk4fKT94tDSrm_3sEicZ_0BaqXNsNOA@mail.gmail.com>
References: <1475879821-8035-1-git-send-email-lina.iyer@linaro.org> <1475879821-8035-9-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174]:35412 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752180AbcJJLGu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Oct 2016 07:06:50 -0400
Received: by mail-qk0-f174.google.com with SMTP id z190so91339479qkc.2
        for <linux-pm@vger.kernel.org>; Mon, 10 Oct 2016 04:06:50 -0700 (PDT)
In-Reply-To: <1475879821-8035-9-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: Kevin Hilman <khilman@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Andy Gross <andy.gross@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Brendan Jackman <brendan.jackman@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Juri Lelli <Juri.Lelli@arm.com>

On 8 October 2016 at 00:37, Lina Iyer <lina.iyer@linaro.org> wrote:
> Update documentation to reflect the changes made to support IRQ safe PM
> domains.
>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  Documentation/power/devices.txt | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/power/devices.txt b/Documentation/power/devices.txt
> index 8ba6625..0401b53 100644
> --- a/Documentation/power/devices.txt
> +++ b/Documentation/power/devices.txt
> @@ -607,7 +607,14 @@ individually.  Instead, a set of devices sharing a power resource can be put
>  into a low-power state together at the same time by turning off the shared
>  power resource.  Of course, they also need to be put into the full-power state
>  together, by turning the shared power resource on.  A set of devices with this
> -property is often referred to as a power domain.
> +property is often referred to as a power domain. A power domain may also be
> +nested inside another power domain.
> +
> +Devices and PM domains may be defined as IRQ-safe, if they can be powered
> +on/off even when the IRQs are disabled. An IRQ-safe device in a domain will
> +disallow power management on the domain, unless the domain is also defined as
> +IRQ-safe. The restriction this framework imposes on the parent domain of an
> +IRQ-safe domain is that it must also be defined as IRQ-safe.
>
>  Support for power domains is provided through the pm_domain field of struct
>  device.  This field is a pointer to an object of type struct dev_pm_domain,
> --
> 2.7.4
>
