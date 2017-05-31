From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH] thermal: broadcom: ns-thermal: depends/default only for
 NS/NSP
Date: Wed, 31 May 2017 13:03:34 -0700
Message-ID: <175796a4-41f3-9d27-4d26-58aca1f97a36@gmail.com>
References: <1496260544-4200-1-git-send-email-jon.mason@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:35506 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751009AbdEaUDi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 May 2017 16:03:38 -0400
In-Reply-To: <1496260544-4200-1-git-send-email-jon.mason@broadcom.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jon Mason <jon.mason@broadcom.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: rafal@milecki.pl, Florian Fainelli <f.fainelli@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com

On 05/31/2017 12:55 PM, Jon Mason wrote:
> ARCH_BCM_IPROC includes support for many SoCs, not all of which have the
> same thermal hardware interface as the Northstar/Northstar Plus SoCs.
> This is not a major issue, as this driver will only be probed if the
> relevant device tree entry is present.  However, it will result in a
> slightly larger than necessary kernel.  By limiting the driver to only
> work on the NS/NSP SoCs, we can avoid the issue.
> 
> Suggested-by: Scott Branden <scott.branden@broadcom.com>
> Signed-off-by: Jon Mason <jon.mason@broadcom.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
