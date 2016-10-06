From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFC PATCH 0/3] PM / Domains: Add support for devices that
 require multiple domains
Date: Thu, 6 Oct 2016 14:22:12 +0200
Message-ID: <CAPDyKFoFPNNnoc-7G34A7a4Yo8f=WUyurNP1evabw3MOEubEoA@mail.gmail.com>
References: <1474367287-10402-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:35703 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752097AbcJFMWP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 Oct 2016 08:22:15 -0400
Received: by mail-wm0-f53.google.com with SMTP id f193so287230443wmg.0
        for <linux-pm@vger.kernel.org>; Thu, 06 Oct 2016 05:22:14 -0700 (PDT)
In-Reply-To: <1474367287-10402-1-git-send-email-jonathanh@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>

On 20 September 2016 at 12:28, Jon Hunter <jonathanh@nvidia.com> wrote:
> The Tegra124/210 XUSB subsystem (that consists of both host and device
> controllers) is partitioned across 3 PM domains which are:
> - XUSBA: Superspeed logic (for USB 3.0)
> - XUSBB: Device controller
> - XUSBC: Host controller
>
> These power domains are not nested and can be powered-up and down
> independently of one another. In practice different scenarios require
> different combinations of the power domains, for example:
> - Superspeed host: XUSBA and XUSBC
> - Superspeed device: XUSBA and XUSBB
>
> Although it could be possible to logically nest both the XUSBB and XUSBC
> domains under the XUSBA, superspeed may not always be used/required and
> so this would keep it on unnecessarily.
>
> Given that Tegra uses device-tree for describing the hardware, it would
> be ideal that the device-tree 'power-domains' property for generic PM
> domains could be extended to allow more than one PM domain to be
> specified. For example, define the following the Tegra210 xHCI device ...
>
>         usb@70090000 {
>                 compatible = "nvidia,tegra210-xusb";
>                 ...
>                 power-domains = <&pd_xusbhost>, <&pd_xusbss>;
>         };
>
> This RFC extends the generic PM domain framework to allow a device to
> define more than one PM domain in the device-tree 'power-domains'
> property.

First, I don't really like extending the internal logic of genpd to
deal with multiple PM domains per device. *If* this really is needed,
I think we should try to extend the struct device to cover this, then
make genpd to use it somehow.

Second, another way of seeing this is: Depending on the current
runtime selected configuration you need to re-configure the PM domain
topology - but the device would still remain in the same PM domain.

In other words, you would need to remove/add subdomain(s) depending on
the selected configuration. Would that better reflect the HW?

[...]

Kind regards
Uffe
