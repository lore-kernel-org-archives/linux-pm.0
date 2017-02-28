From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [RFC PATCH 0/3] PM / Domains: Add support for devices that
 require multiple domains
Date: Tue, 28 Feb 2017 15:18:47 +0000
Message-ID: <52493231-71f4-1b62-b325-8532e63e4229@nvidia.com>
References: <1474367287-10402-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:19081 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751135AbdB1P0J (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Feb 2017 10:26:09 -0500
In-Reply-To: <1474367287-10402-1-git-send-email-jonathanh@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, geert@linux-m68k.org, rnayak@codeaurora.org, stanimir.varbanov@linaro.org, sboyd@codeaurora.org, Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org

Hi all,

On 20/09/16 11:28, Jon Hunter wrote:
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
> 	usb@70090000 {
> 		compatible = "nvidia,tegra210-xusb";
> 		...
> 		power-domains = <&pd_xusbhost>, <&pd_xusbss>;
> 	};
> 
> This RFC extends the generic PM domain framework to allow a device to
> define more than one PM domain in the device-tree 'power-domains'
> property.

I wanted to kick this thread again now in the new year and see if there
is still some interest in pursuing this?

There is still very much a need from a Tegra perspective. I have put all
those who responded on TO.

I know that a lot of time has passed since we discuss this and so if you
are scratching your head wondering what I am harping on about,
essentially with this RFC I was looking for a way to support devices
that require multiple power domains where the domains do not have a
parent-child relationship and so not are nested in anyway.

If you need me to elaborate on the need for this, I am happy to do this.
My take away from when we discussed this last year, was that there was a
need for this.

Cheers
Jon

-- 
nvpublic
