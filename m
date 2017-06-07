From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 0/2] power: reset: Couple of POWER_RESET_BRCMSTB Kconfig
 changes
Date: Wed, 7 Jun 2017 09:59:19 -0700
Message-ID: <99b73965-f64b-7f92-6ee1-eb8fbb711f85@gmail.com>
References: <20170531203946.32644-1-f.fainelli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34079 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751260AbdFGQ7Z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Jun 2017 12:59:25 -0400
In-Reply-To: <20170531203946.32644-1-f.fainelli@gmail.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org, sre@kernel.org
Cc: linux-pm@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com

On 05/31/2017 01:39 PM, Florian Fainelli wrote:
> Hi Sebastian,
> 
> Here are two small tweaks to the POWER_RESET_BRCMSTB Kconfig selection to allow
> the driver on ARM64 and make it default to BMIPS_GENERIC on MIPS platforms.
> 
> Based on your "for-next" branch.

Sebastian, are these changes okay with you?

> 
> Thanks
> 
> Florian Fainelli (2):
>   power: reset: Allow selecting POWER_RESET_BRCMSTB on ARM64
>   power: reset: Default POWER_RESET_BRCMSTB to BMIPS_GENERIC
> 
>  drivers/power/reset/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 


-- 
Florian
