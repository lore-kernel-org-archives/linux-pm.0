From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH 05/14] PM / doc: update device documentation for devices in IRQ safe PM domains
Date: Mon, 25 Jul 2016 15:50:44 -0700
Message-ID: <7htwfd49iz.fsf@baylibre.com>
References: <1466624209-27432-1-git-send-email-lina.iyer@linaro.org>
	<1466624209-27432-6-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:33794 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753418AbcGYWur (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 25 Jul 2016 18:50:47 -0400
Received: by mail-pa0-f41.google.com with SMTP id fi15so65344048pac.1
        for <linux-pm@vger.kernel.org>; Mon, 25 Jul 2016 15:50:47 -0700 (PDT)
In-Reply-To: <1466624209-27432-6-git-send-email-lina.iyer@linaro.org> (Lina
	Iyer's message of "Wed, 22 Jun 2016 13:36:40 -0600")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: ulf.hansson@linaro.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, geert@linux-m68k.org, k.kozlowski@samsung.com, andy.gross@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, lorenzo.pieralisi@arm.com, ahaslam@baylibre.com, mtitinger@baylibre.com

Lina Iyer <lina.iyer@linaro.org> writes:

> Update documentation to reflect the changes made to support IRQ safe PM
> domains.
>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> ---
>  Documentation/power/devices.txt | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/power/devices.txt b/Documentation/power/devices.txt
> index 8ba6625..a622136 100644
> --- a/Documentation/power/devices.txt
> +++ b/Documentation/power/devices.txt
> @@ -607,7 +607,17 @@ individually.  Instead, a set of devices sharing a power resource can be put
>  into a low-power state together at the same time by turning off the shared
>  power resource.  Of course, they also need to be put into the full-power state
>  together, by turning the shared power resource on.  A set of devices with this
> -property is often referred to as a power domain.
> +property is often referred to as a power domain. A power domain may also be
> +nested inside another power domain.
> +
> +Devices, by default, operate in process context. If a device can operate in

minor nit: By "devices" here, I think you mean the runtime PM callbacks for
devices?  If so, it should be explicit, otherwise it's not clear what it
means for devices to operate in process context.

Kevin
