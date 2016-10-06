From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: Re: [RFC PATCH 0/3] PM / Domains: Add support for devices that require
 multiple domains
Date: Thu, 06 Oct 2016 11:34:54 +0530
Message-ID: <57F5E986.40704@codeaurora.org>
References: <1474367287-10402-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:38624 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752187AbcJFGFA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 Oct 2016 02:05:00 -0400
In-Reply-To: <1474367287-10402-1-git-send-email-jonathanh@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org


On 09/20/2016 03:58 PM, Jon Hunter wrote:
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

Hey Jon, so does this RFC provide a way to just specify multiple Powerdomains
for a device (which then will *all* be powered on/off together) or does
it also provide for more granular control of these powerdomains?
The above statement seems to suggest you would need more granular control
of these powerdomains (like keeping XUSBA off in case superspeed it not
needed) but I can't seem to figure out how you achieve it with this series.

- Rajendra
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
