From: Li Yang <leoli@freescale.com>
Subject: Re: [PATCH v2] dmaengine: fsl-edma: add PM suspend/resume support
Date: Thu, 13 Aug 2015 15:58:01 -0500
Message-ID: <CADRPPNQJi_x+mdQV=DEVuhCL_p6VOWcPiV3jzioeRdWgSW2w3g@mail.gmail.com>
References: <1437469005-3162-1-git-send-email-yao.yuan@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f68.google.com ([209.85.215.68]:33016 "EHLO
	mail-la0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752884AbbHMU6D (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 13 Aug 2015 16:58:03 -0400
In-Reply-To: <1437469005-3162-1-git-send-email-yao.yuan@freescale.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Yuan Yao <yao.yuan@freescale.com>
Cc: Vinod Koul <vinod.koul@intel.com>, stefan@agner.ch, Arnd Bergmann <arnd@arndb.de>, Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Tue, Jul 21, 2015 at 3:56 AM, Yuan Yao <yao.yuan@freescale.com> wrote:
> This add power management suspend/resume support for the fsl-edma
> driver.
>
> eDMA acted as a basic function used by others. What it needs to do is
> the two steps below to support power management.
>
> In fsl_edma_suspend_late:
> Check whether the DMA chan is idle and if it is not idle, stop PM
> operation.

You should try to quiesce the device on suspend instead of depending
on itself to be happen in idle and failing if it is not.

Regards,
Leo
