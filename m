From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [RFC PATCH 2/3] PM / Domains: Add support for devices with multiple domains
Date: Fri, 07 Oct 2016 02:14:56 -0700
Message-ID: <7hlgy0frlb.fsf@baylibre.com>
References: <1474367287-10402-1-git-send-email-jonathanh@nvidia.com>
        <1474367287-10402-3-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34175 "EHLO
        mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751591AbcJGJO6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Oct 2016 05:14:58 -0400
Received: by mail-pa0-f52.google.com with SMTP id rz1so20420390pab.1
        for <linux-pm@vger.kernel.org>; Fri, 07 Oct 2016 02:14:57 -0700 (PDT)
In-Reply-To: <1474367287-10402-3-git-send-email-jonathanh@nvidia.com> (Jon
        Hunter's message of "Tue, 20 Sep 2016 11:28:06 +0100")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org

Jon Hunter <jonathanh@nvidia.com> writes:

> Some devices may require more than one PM domain to operate and this is
> not currently by the PM domain framework. Furthermore, the current Linux
> 'device' structure only allows devices to be associated with a single PM
> domain and so cannot easily be associated with more than one. To allow
> devices to be associated with more than one PM domain, if multiple
> domains are defined for a given device (eg. via device-tree), then:
> 1. Create a new PM domain for this device. The name of the new PM domain
>    created matches the device name for which it was created for.
> 2. Register the new PM domain as a sub-domain for all PM domains
>    required by the device.
> 3. Attach the device to the new PM domain.

Did you look at what might be involved to extend struct device to hace a
list of pm_domains?  Like Ulf, I'm a bit unsettled by this
implementation that has to work around the basic limitation in the
driver model.

Having devices in multitple domains is needed for SoCs I'm familiar with
also, so is a needed feature.

I think removing the struct device limitation and corresponding
assumptions in the driver and PM core is a prerequisite for this
feature.

Doing that will lead to several questions about how to handle runtime PM
operations (e.g. which of the multiple PM domains should the one to call
the drivers runtime PM hooks when a device changes runtime PM state?)

Anyways, even with the potential complexities, I think attempting this
is the right way forward.

Kevin
