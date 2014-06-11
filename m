From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH 0/3] devfreq: exynos4_bus: Update Exynos4 busfreq driver
Date: Wed, 11 Jun 2014 12:27:13 +0900
Message-ID: <5397CC91.4050903@samsung.com>
References: <1402449476-6782-1-git-send-email-jonghwa3.lee@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:36663 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753461AbaFKD1P (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 10 Jun 2014 23:27:15 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N6Z005R6IXD2Y50@mailout1.samsung.com> for
 linux-pm@vger.kernel.org; Wed, 11 Jun 2014 12:27:14 +0900 (KST)
In-reply-to: <1402449476-6782-1-git-send-email-jonghwa3.lee@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jonghwa Lee <jonghwa3.lee@samsung.com>
Cc: linux-pm@vger.kernel.org, myungjoo.ham@samsung.com, kyungmin.park@samsung.com

Hi Jonghwa,

I sent already this patchset to support dt for exynos4-busfreq[1].
You can check history of exynos4-busfreq on following patchset[1].
[1] https://lkml.org/lkml/2014/3/13/58

So, I'm preparing to implement common driver to support dt of PPMU.

Thanks,
Chanwoo Choi


On 06/11/2014 10:17 AM, Jonghwa Lee wrote:
> Driver updates including devicetree supporting and some fixes.
> 
> Jonghwa Lee (3):
>   devfreq: exynos4_bus: Enable PPMU's source clock before use.
>   devfreq: exynos4_bus: Access memory mapped I/O region via dynamic
>     allocation.
>   devfreq: exynos4_bus: Support DT in exynos4 busfreq driver.
> 
>  .../devicetree/bindings/devfreq/exynos4_bus.txt    |   19 +++++
>  drivers/devfreq/exynos/exynos4_bus.c               |   77 +++++++++++++++++---
>  2 files changed, 87 insertions(+), 9 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/devfreq/exynos4_bus.txt
> 

