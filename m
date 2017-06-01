From: =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: Re: [PATCH] thermal: broadcom: ns-thermal: depends/default only for
 NS/NSP
Date: Thu, 01 Jun 2017 07:29:53 +0200
Message-ID: <a47f69920ab85252f106b40e8c08e508@milecki.pl>
References: <1496260544-4200-1-git-send-email-jon.mason@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from 10.mo4.mail-out.ovh.net ([188.165.33.109]:41855 "EHLO
        10.mo4.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750926AbdFAGpu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Jun 2017 02:45:50 -0400
Received: from player746.ha.ovh.net (b6.ovh.net [213.186.33.56])
        by mo4.mail-out.ovh.net (Postfix) with ESMTP id ED7976E2AF
        for <linux-pm@vger.kernel.org>; Thu,  1 Jun 2017 07:30:00 +0200 (CEST)
In-Reply-To: <1496260544-4200-1-git-send-email-jon.mason@broadcom.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jon Mason <jon.mason@broadcom.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com

On 2017-05-31 21:55, Jon Mason wrote:
> ARCH_BCM_IPROC includes support for many SoCs, not all of which have 
> the
> same thermal hardware interface as the Northstar/Northstar Plus SoCs.
> This is not a major issue, as this driver will only be probed if the
> relevant device tree entry is present.  However, it will result in a
> slightly larger than necessary kernel.  By limiting the driver to only
> work on the NS/NSP SoCs, we can avoid the issue.
> 
> Suggested-by: Scott Branden <scott.branden@broadcom.com>
> Signed-off-by: Jon Mason <jon.mason@broadcom.com>

Sounds OK, thanks.
